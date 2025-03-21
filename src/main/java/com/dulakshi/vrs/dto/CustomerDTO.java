package com.dulakshi.vrs.dto;

import lombok.Data;

@Data
public class CustomerDTO {
    private Long id;
    private String regId;
    private String name;
    private String email;
    private String mobile;
    private String nic;
    private String address;
}
