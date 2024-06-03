package com.example.youmotion.repositories;

import com.example.youmotion.models.Subscribe;
import com.example.youmotion.models.Video;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubscribeRepository extends JpaRepository<Subscribe,Long> {
}
