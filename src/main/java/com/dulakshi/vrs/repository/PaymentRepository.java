package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
}
