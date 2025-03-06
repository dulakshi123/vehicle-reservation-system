package com.dulakshi.vrs.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "driver")
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Driver {

    @Id
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "reg_id", nullable = false, unique = true, length = 20)
    private String registrationId;

    @Column(name = "name", nullable = false, length = 30)
    private String name;

    @Column(nullable = false, length = 10)
    private String mobile;

    @Column(name = "dln", nullable = false, length = 10)
    private String dln; // Driving License Number

    @Enumerated(value = EnumType.ORDINAL)
    @Column(nullable = false)
    private Status status;
}
