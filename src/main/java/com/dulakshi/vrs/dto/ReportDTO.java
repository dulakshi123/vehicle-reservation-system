package com.dulakshi.vrs.dto;

import lombok.Data;

@Data
public class ReportDTO {
    private Long driverCount;
    private Long vehicleCount;
    private Long reservationCount;
    private Double totalIncome;
}
