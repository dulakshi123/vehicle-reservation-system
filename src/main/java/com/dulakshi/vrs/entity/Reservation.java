package com.dulakshi.vrs.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "reservation")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "customer_user_id", nullable = false)
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "driver_user_id", nullable = true)
    private Driver driver;

    @ManyToOne
    @JoinColumn(name = "vehicle_id", nullable = true)
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
