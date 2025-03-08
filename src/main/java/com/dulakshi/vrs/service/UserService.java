package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.LoginRequestDTO;
import com.dulakshi.vrs.entity.User;

public interface UserService {
    User register(User user);
    User login(LoginRequestDTO loginRequest);
}
