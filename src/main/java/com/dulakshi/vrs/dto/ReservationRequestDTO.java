package com.dulakshi.vrs.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ReservationRequestDTO {
    private Long id;
    private String customer;
    private String customerMobile;
    private String driver;
    private String driverMobile;
    private String vehicle;
    private Integer seatCount;
    private String pickupLocation;
    private String dropOffLocation;
    private String datetime;
    private Integer passengerCount;
    private String vehicleType;
    private Double fareAmount;
    private Double taxAmount;
    private Double discount;
    private Double payment;
    private String status;
    private String paymentStatus;
}
