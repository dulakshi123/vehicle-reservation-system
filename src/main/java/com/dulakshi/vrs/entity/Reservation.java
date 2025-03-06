package com.dulakshi.vrs.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "customer_user_id", nullable = false)
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "driver_user_id", nullable = false)
    private Driver driver;

    @ManyToOne
    @JoinColumn(name = "vehicle_id", nullable = false)
    private Vehicle vehicle;

    @Column(nullable = false, length = 100)
    private String pickupLocation;

    @Column(name = "dropoff_location", nullable = false, length = 100)
    private String dropOffLocation;

    @Column(nullable = false)
    private LocalDateTime datetime;

    @Column(nullable = false)
    private Integer passengerCount;

    @Enumerated(value = EnumType.ORDINAL)
    @Column(nullable = false)
    private Status status;
}
