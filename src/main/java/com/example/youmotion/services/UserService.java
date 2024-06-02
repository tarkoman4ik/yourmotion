package com.example.youmotion.services;

import com.example.youmotion.models.User;
import com.example.youmotion.models.enums.Role;
import com.example.youmotion.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public boolean createUser(User user) throws IOException {
        if (userRepository.findByMail(user.getMail())!=null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        log.info("Saving new User with",user.getMail());
        user.setImage(Files.readAllBytes(Paths.get("src/main/resources/static/images/userprofile.png")));
        userRepository.save(user);
        return true;
    }

    public User getUserById(Long id_user) {
        return  userRepository.findById(id_user).orElse(null);
    }

    public void deleteUser(Long id_user) {
        userRepository.delete(getUserById(id_user));
    }

    public void UpdateUser(Long id_user, String channelname, String name, String surname, String description, String country, MultipartFile file) throws IOException {
        Optional<User> userOptional = userRepository.findById(id_user);
        if (userOptional.isPresent()){
            User user = userOptional.get();
            if (!channelname.isEmpty()){
                user.setChannelname(channelname);
            }
            if (!name.isEmpty()){
                user.setName(name);
            }
            if (!surname.isEmpty()){
                user.setSurname(surname);
            }
            if (!description.isEmpty()){
                user.setDescription(description);
            }
            if (!country.isEmpty()){
                user.setCountry(country);
            }
            if (!file.isEmpty()){
                user.setImage(file.getBytes());
            }
            userRepository.save(user);
        }
    }
}
