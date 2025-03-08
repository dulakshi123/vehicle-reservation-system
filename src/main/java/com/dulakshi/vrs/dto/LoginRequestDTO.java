package com.dulakshi.vrs.dto;

import lombok.Data;

@Data
public class LoginRequestDTO {
    private String username;
    private String password;
    private String userRole;
}
