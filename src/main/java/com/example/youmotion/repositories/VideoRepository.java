package com.example.youmotion.repositories;

import com.example.youmotion.models.Video;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface VideoRepository extends JpaRepository<Video,Long> {
    List<Video> findByTitleContains(String title);
}
