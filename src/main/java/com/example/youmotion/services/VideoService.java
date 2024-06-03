package com.example.youmotion.services;

import com.example.youmotion.models.Comment;
import com.example.youmotion.models.Subscribe;
import com.example.youmotion.models.User;
import com.example.youmotion.models.Video;
import com.example.youmotion.repositories.CommentRepository;
import com.example.youmotion.repositories.SubscribeRepository;
import com.example.youmotion.repositories.UserRepository;
import com.example.youmotion.repositories.VideoRepository;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@ToString
@RequiredArgsConstructor
public class VideoService {
    private final VideoRepository videoRepository;
    private final UserRepository userRepository;
    private final CommentRepository commentRepository;
    private final SubscribeRepository subscribeRepository;

    public List<Video> listVideos(String title) {
        log.info("infofasdagSDASDadASDasdfasdfasfADSAFASDFA: {}",videoRepository.findByTitleContains(title));
        if (title!=null)
            return videoRepository.findByTitleContains(title);
        return videoRepository.findAll();
    }

    public List<Comment> listComments(){
        return  commentRepository.findAll();
    }

    public void saveVideo(Principal principal, String title, String description, MultipartFile file) throws IOException{
        Video video = new Video();
        video.setTitle(title);
        video.setPreview_image(file.getBytes());
        video.setDescription(description);
        video.setUser(getUserByPrincipal(principal));
        videoRepository.save(video);
    }

    public void saveComment(Long id_video,String comment, String username,Long id_user) {
        Comment comm = new Comment();
        comm.setMessage(comment);
        comm.setUsername(username);
        comm.setId_user(id_user);
        comm.setVid(videoRepository.findById(id_video).get());
        commentRepository.save(comm);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal==null) return new User();
        return userRepository.findByMail(principal.getName());
    }

    public void deleteVideo(Long id_video){
        videoRepository.deleteById(id_video);
    }

    public Video getVideoById(Long id_video){
        return videoRepository.findById(id_video).orElse(null);
    }

    public void UpdateVideo(Long id_video,String title, String description, MultipartFile file) throws IOException {
       Optional<Video> videoOptional = videoRepository.findById(id_video);
       if (videoOptional.isPresent()) {
           Video video = videoOptional.get();
           if (!title.isEmpty())
               video.setTitle(title);
           if (!description.isEmpty())
               video.setDescription(description);
           if (!file.isEmpty())
               video.setPreview_image(file.getBytes());
           videoRepository.save(video);
       }
    }

    public void UpdateViews(Long id_video){
        Optional<Video> videoOptional = videoRepository.findById(id_video);
        if (videoOptional.isPresent()) {
            Video video = videoOptional.get();
            video.setViews(video.getViews() + 1);
            videoRepository.save(video);
        }
    }

    public void saveSubscribe(Long id_video, User user) {
        Subscribe sub = new Subscribe();
        sub.setUsername(getVideoById(id_video).getUser().getChannelname());
        sub.setId_user(getVideoById(id_video).getUser().getId_user());
        sub.setSubname(user.getChannelname());
        sub.setId_sub(user.getId_user());
        subscribeRepository.save(sub);
    }

    public List<Subscribe> listSubscribes() {
        return subscribeRepository.findAll();
    }

    public void deleteSubscribe(Long id_video, User user) {
        Subscribe sub = new Subscribe();
        List<Subscribe> ls = listSubscribes();
        for (Subscribe elem : ls){
            if (elem.getId_user()==videoRepository.findById(id_video).get().getUser().getId_user()&&elem.getId_sub()==user.getId_user())
                sub = elem;
        }
        subscribeRepository.delete(sub);
    }
}
