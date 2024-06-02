package com.example.youmotion.repositories;

import com.example.youmotion.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Long> {
    User findByMail(String mail);
}
