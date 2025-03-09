package com.dulakshi.vrs.service;

import com.dulakshi.vrs.entity.Payment;

public interface PaymentService {
    Payment getPaymentByReservation(Long reservationId);
    void updatePayment(Payment payment);
}
