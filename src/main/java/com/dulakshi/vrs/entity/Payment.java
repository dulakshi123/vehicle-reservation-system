package com.dulakshi.vrs.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "payment")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "reservation_id", nullable = false)
    private Reservation reservation;

    @Column(nullable = false)
    private Double fare;

    @Column(nullable = false)
    private Double tax;

    @Column(nullable = false)
    private Double discount;

    @Enumerated(value = EnumType.ORDINAL)
    @Column(nullable = false)
    private Status status;
}
