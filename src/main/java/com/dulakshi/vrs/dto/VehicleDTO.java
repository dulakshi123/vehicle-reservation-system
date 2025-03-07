package com.dulakshi.vrs.dto;

import lombok.Data;

@Data
public class VehicleDTO {
    private Long id;
    private String vrn;
    private String type;
    private int seatCount;
    private String status;
}
