package com.dulakshi.vrs.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "customer")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Customer {

    @Id
    private Long userId;

    @OneToOne
    @MapsId
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "reg_id", nullable = false, length = 20)
    private String registrationId;

    @Column(name = "name", nullable = false, length = 30)
    private String name;

    @Column(nullable = false, length = 10)
    private String mobile;

    @Column(nullable = false, length = 15)
    private String nic;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String address;
}
