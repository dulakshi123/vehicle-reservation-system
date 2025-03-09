package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    Optional<Payment> findPaymentByReservation_Id(Long reservationId);
}
