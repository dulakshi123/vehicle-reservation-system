package com.dulakshi.vrs.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "vehicle")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "plate_number", nullable = false, length = 10)
    private String vrn; // Vehicle Registration Number

    @Enumerated(value = EnumType.ORDINAL)
    @Column(nullable = false)
    private Model model;

    @Column(nullable = false)
    private Integer seatCount;

    @Enumerated(value = EnumType.ORDINAL)
    @Column(nullable = false)
    private Status status;
}
