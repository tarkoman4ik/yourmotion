package com.example.youmotion.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Table(name="videos")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Video {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_video")
    private Long id_video;
    @Column(name="title",columnDefinition = "text")
    private String title;
    @Column(name="description", columnDefinition = "text")
    private String description;
    @Column(name="views")
    private int views = 0;
    @Column(name="upload")
    private LocalDateTime upload;
    @ToString.Exclude
    @Basic
    @Column(name="preview_image",nullable = false,columnDefinition ="LONGBLOB")
    private byte[] preview_image;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    @ToString.Exclude
    private User user;

    @PrePersist
    private void init(){
        upload = LocalDateTime.now();
    }
}
