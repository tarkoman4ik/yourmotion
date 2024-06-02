package com.example.youmotion.controllers;

import com.example.youmotion.models.User;
import com.example.youmotion.models.Video;
import com.example.youmotion.services.UserService;
import com.example.youmotion.services.VideoService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class siteController {
    private final VideoService videoService;
    private  final UserService userService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String videos(@RequestParam(name="title",required = false) String title, Principal principal,Model model) {
        model.addAttribute("videos",videoService.listVideos(title));
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        return "videos";
    }

    @GetMapping("/profile/{id_user}")
    public String profile(@PathVariable Long id_user,Principal principal,Model model){
        model.addAttribute("videos",userService.getUserById(id_user).getVideos());
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        model.addAttribute("owner",userService.getUserById(id_user));
        return "profile";
    }

    @PostMapping("/video/delet")
    public String deleteVideoManager(@RequestParam(name="id_video") Long id_video,Principal principal) throws IOException {
        int id_user = Math.toIntExact(videoService.getUserByPrincipal(principal).getId_user());
        String title = videoService.getVideoById(id_video).getTitle();
        Files.delete(Path.of(uploadPath + "/" + id_user + "/" + title + ".mp4"));
        videoService.deleteVideo(id_video);
        return "redirect:/";
    }

    @GetMapping("/video-manager")
    public String videoManage(Principal principal,Model model){
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        return "video-manager";
    }

    @GetMapping("/video/{id_video}")
    public String videoWatch(@PathVariable Long id_video,Principal principal,Model model){
        videoService.UpdateViews(id_video);
        model.addAttribute("video",videoService.getVideoById(id_video));
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        return "video-watch";
    }

    @ResponseBody
    @GetMapping("/image/{id_video}")
    public ResponseEntity<?> returnImage(@PathVariable long id_video){
        return ResponseEntity.ok().body(new InputStreamResource(new ByteArrayInputStream(videoService.getVideoById(id_video).getPreview_image())));
    }

    @ResponseBody
    @GetMapping("/avatar/{id_user}")
    public ResponseEntity<?> returnAvatar(@PathVariable Long id_user){
        return ResponseEntity.ok().body(new InputStreamResource(new ByteArrayInputStream(userService.getUserById(id_user).getImage())));
    }

    @PostMapping("/video/create")
    public String createVideo(@RequestParam("file") MultipartFile file, @RequestParam("videofile") MultipartFile videofile, String title, String description, Principal principal) throws IOException {
        videoService.saveVideo(principal,title,description,file);
        if (videofile!=null) {
            File uploadDir = new File(uploadPath + "/" + videoService.getUserByPrincipal(principal).getId_user());
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            videofile.transferTo(new File(uploadPath + "/" + videoService.getUserByPrincipal(principal).getId_user() + "/" + title + ".mp4"));
        }
        return "redirect:/";
    }

    @PostMapping("/video/delete/{id_video}")
    public String deleteVideo(@PathVariable Long id_video,Principal principal) throws IOException{
        int id_user = Math.toIntExact(videoService.getUserByPrincipal(principal).getId_user());
        String title = videoService.getVideoById(id_video).getTitle();
        Files.delete(Path.of(uploadPath + "/" + id_user + "/" + title + ".mp4"));
        videoService.deleteVideo(id_video);
        return "redirect:/";
    }
}
