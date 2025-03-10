package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.ReportDTO;
import com.dulakshi.vrs.repository.DriverRepository;
import com.dulakshi.vrs.repository.PaymentRepository;
import com.dulakshi.vrs.repository.ReservationRepository;
import com.dulakshi.vrs.repository.VehicleRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
public class ReportServiceImpl implements ReportService {
    private final VehicleRepository vehicleRepository;
    private final DriverRepository driverRepository;
    private final ReservationRepository reservationRepository;
    private final PaymentRepository paymentRepository;

    @Override
    public ReportDTO fetchReport() {
        ReportDTO reportDTO = new ReportDTO();
        reportDTO.setDriverCount(driverRepository.countAllBy());
        reportDTO.setVehicleCount(vehicleRepository.countAllBy());
        reportDTO.setReservationCount(reservationRepository.countAllBy());
        reportDTO.setTotalIncome(Optional.ofNullable(paymentRepository.getTotalIncome()).orElse(0.0));
        return reportDTO;
    }
}
