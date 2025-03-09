package com.dulakshi.vrs.service;

import com.dulakshi.vrs.entity.Payment;

public interface PaymentService {
    Payment createPayment(Payment payment);
    Payment getPaymentByReservation(Long reservationId);
    boolean updatePayment(Payment payment);
}
