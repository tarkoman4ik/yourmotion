package com.example.youmotion.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="subscribes")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Subscribe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_subscribe")
    private Long id_subscribe;
    @Column(name="username")
    private String username;
    @Column(name = "id_user")
    private Long id_user;
    @Column(name="subname")
    private String subname;
    @Column(name="id_sub")
    private Long id_sub;

}
