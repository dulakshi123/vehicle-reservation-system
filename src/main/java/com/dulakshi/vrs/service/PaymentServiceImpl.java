package com.dulakshi.vrs.service;

import com.dulakshi.vrs.entity.Payment;
import com.dulakshi.vrs.repository.PaymentRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class PaymentServiceImpl implements PaymentService {
    private final PaymentRepository paymentRepository;

    @Override
    public Payment getPaymentByReservation(Long reservationId) {
        return paymentRepository.findPaymentByReservation_Id(reservationId).orElse(null);
    }

    @Override
    public void updatePayment(Payment payment) {
        paymentRepository.save(payment);
    }
}
