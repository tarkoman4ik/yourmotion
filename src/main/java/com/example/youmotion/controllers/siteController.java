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

import javax.swing.text.html.Option;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.Optional;

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

    @PostMapping("/profile/delete/{id_user}")
    public String profileDelete(@PathVariable Long id_user) {
        userService.deleteUser(id_user);
        return "/login";
    }

    @PostMapping("/video/delet")
    public String deleteVideoManager(@RequestParam(name="delete_id") Long id_video,Principal principal, Model model) throws IOException {
        int id_user = Math.toIntExact(videoService.getUserByPrincipal(principal).getId_user());
        String title = videoService.getVideoById(id_video).getTitle();
        Files.delete(Path.of(uploadPath + "/" + id_user + "/" + title + ".mp4"));
        videoService.deleteVideo(id_video);
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        model.addAttribute("deleteMessage","Видео успешно удалено!");
        return "video-manager";
    }

    @PostMapping("/profile/update/{id_user}")
    public String updateUser(@PathVariable Long id_user,
                             @RequestParam(name="channelname")String channelname, @RequestParam(name="name") String name,
                             @RequestParam(name="surname") String surname,@RequestParam(name="description") String description,
                             @RequestParam(name="country") String country,@RequestParam(name="file")MultipartFile file,
                             Principal principal,Model model) throws IOException {
        userService.UpdateUser(id_user,channelname,name,surname,description,country,file);
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        model.addAttribute("updateMessage","Профиль обновлен!");
        return "profile-manager";
    }

    @PostMapping("/video/update")
    public String updateVideo(@RequestParam(name="file") MultipartFile file,@RequestParam(name="update_id") Long id_video,@RequestParam(name="title") String title,@RequestParam(name="description") String description,Principal principal,Model model) throws IOException {
        if (!title.isEmpty()) {
            Path fileOld = Paths.get(uploadPath + "/" + videoService.getVideoById(id_video).getUser().getId_user() + "/" + videoService.getVideoById(id_video).getTitle() + ".mp4");
            Files.move(fileOld, fileOld.resolveSibling(title + ".mp4"));
        }
        videoService.UpdateVideo(id_video,title,description,file);
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        model.addAttribute("updateMessage","Видео обновлено!");
        return "video-manager";
    }

    @GetMapping("/video-manager")
    public String videoManage(Principal principal,Model model){
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        return "video-manager";
    }

    @GetMapping("/profile-manager")
    public String profileManager(Principal principal,Model model){
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        return "profile-manager";
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
    public String createVideo(@RequestParam("file") MultipartFile file, @RequestParam("videofile") MultipartFile videofile, String title, String description, Principal principal,Model model) throws IOException {
        videoService.saveVideo(principal,title,description,file);
        if (videofile!=null) {
            File uploadDir = new File(uploadPath + "/" + videoService.getUserByPrincipal(principal).getId_user());
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            videofile.transferTo(new File(uploadPath + "/" + videoService.getUserByPrincipal(principal).getId_user() + "/" + title + ".mp4"));
        }
        model.addAttribute("user",videoService.getUserByPrincipal(principal));
        model.addAttribute("createMessage","Видео успешно создано!");
        return "video-manager";
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
