package com.dulakshi.vrs.dto;

import lombok.Data;

@Data
public class CustomerRegistrationRequestDTO {
    private String name;
    private String email;
    private String password;
    private String mobile;
    private String nic;
    private String address;
}
