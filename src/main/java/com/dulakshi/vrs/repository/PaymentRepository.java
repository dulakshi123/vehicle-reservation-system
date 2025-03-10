package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    Optional<Payment> findPaymentByReservation_Id(Long reservationId);

    @Query("SELECT SUM(p.fare - p.tax - p.discount) FROM Payment p")
    Double getTotalIncome();
}
