package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.LoginRequestDTO;
import com.dulakshi.vrs.entity.User;
import com.dulakshi.vrs.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    @Override
    public User register(User user) {
        Optional<User> userByMobile = userRepository.findUserByEmail(user.getEmail());

        if(userByMobile.isPresent()) {
            throw new RuntimeException("User already exists");
        }

        user.setPassword(user.getPassword());

        return userRepository.save(user);
    }

    @Override
    public User login(LoginRequestDTO loginRequest) {
        User user = userRepository
                .findUserByEmail(loginRequest.getUsername())
                .orElseThrow(() -> new RuntimeException("Username or password is incorrect"));

        if(!loginRequest.getPassword().equalsIgnoreCase(user.getPassword())) {
            throw new RuntimeException("Username or password is incorrect");
        }

        return user;
    }
}
