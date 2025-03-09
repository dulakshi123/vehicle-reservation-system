package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.ReservationRequestDTO;
import com.dulakshi.vrs.entity.*;
import com.dulakshi.vrs.repository.CustomerRepository;
import com.dulakshi.vrs.repository.ReservationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class ReservationServiceImpl implements ReservationService {
    private final ReservationRepository reservationRepository;
    private final PaymentService paymentService;
    private final CustomerRepository customerRepository;

    @Override
    public boolean addReservation(ReservationRequestDTO reservationDTO, User user) {
        Customer customer = customerRepository.findById(user.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        LocalDateTime dateTime = getDateTimeObject(reservationDTO.getDatetime());

        Optional<Reservation> existingReservation = reservationRepository
                .findReservationByCustomerAndDatetime(customer, dateTime);

        if(existingReservation.isPresent()) {
            throw new RuntimeException("You have already added a reservation at the same time");
        }

        Reservation reservation = new Reservation();
        reservation.setCustomer(customer);
        reservation.setDatetime(dateTime);
        reservation.setStatus(Status.BOOKED);
        reservation.setPickupLocation(reservationDTO.getPickupLocation());
        reservation.setDropOffLocation(reservationDTO.getDropOffLocation());
        reservation.setPassengerCount(reservationDTO.getPassengerCount());

        reservationRepository.save(reservation);
        return true;
    }

    @Override
    public boolean updateReservation(ReservationRequestDTO reservationDTO) {
        return false;
    }

    @Override
    public boolean requestCancellation(Long reservationId) {
        return false;
    }

    @Override
    public List<ReservationRequestDTO> getReservationsByUserId(Long userId) {
        Customer customer = customerRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        return reservationRepository.findReservationsByCustomer(customer).stream().map(reservation -> {
            Payment thisPayment = paymentService.getPaymentByReservation(reservation.getId());

            return getReservationRequestDTOBuilder(reservation, customer)
                    .status(getRealStatus(Optional.ofNullable(thisPayment).map(Payment::getStatus).orElse(Status.PENDING)))
                    .build();
        }).toList();
    }

    @Override
    public List<ReservationRequestDTO> getAllReservation() {
        return reservationRepository.findAll().stream().map(reservation -> {
            Customer thisCustomer = reservation.getCustomer();
            Vehicle thisVehicle = reservation.getVehicle();
            Payment thisPayment = paymentService.getPaymentByReservation(reservation.getId());

            return getReservationRequestDTOBuilder(reservation, thisCustomer)
                    .seatCount(Optional.ofNullable(thisVehicle).map(Vehicle::getSeatCount).orElse(0))
                    .status(reservation.getStatus().name())
                    .paymentStatus(Optional.ofNullable(thisPayment).map(Payment::getStatus).orElse(Status.PENDING).name())
                    .build();
        }).toList();
    }

    private LocalDateTime getDateTimeObject(String datetime) {
        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
        return LocalDateTime.parse(datetime, formatter);
    }

    private String getDateTimeString(LocalDateTime datetime) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return datetime.format(formatter);
    }

    private String getRealStatus(Status paymentStatus) {
        return paymentStatus.equals(Status.PAID) ? "Completed" : "Pending";
    }

    private ReservationRequestDTO.ReservationRequestDTOBuilder
    getReservationRequestDTOBuilder(Reservation reservation, Customer customer) {
        Driver thisDriver = reservation.getDriver();
        Vehicle thisVehicle = reservation.getVehicle();
        Payment thisPayment = paymentService.getPaymentByReservation(reservation.getId());

        return ReservationRequestDTO.builder()
                .id(reservation.getId())
                .customer(customer.getName())
                .customerMobile(customer.getMobile())
                .driver(Optional.ofNullable(thisDriver).map(Driver::getName).orElse("N/A"))
                .driverMobile(Optional.ofNullable(thisDriver).map(Driver::getMobile).orElse("N/A"))
                .vehicle(Optional.ofNullable(thisVehicle).map(Vehicle::getVrn).orElse("N/A"))
                .vehicleType(Optional.ofNullable(thisVehicle)
                        .map(vehicle -> vehicle.getModel().name()).orElse("N/A"))
                .pickupLocation(reservation.getPickupLocation())
                .dropOffLocation(reservation.getDropOffLocation())
                .datetime(getDateTimeString(reservation.getDatetime()))
                .passengerCount(reservation.getPassengerCount())
                .fareAmount(Optional.ofNullable(thisPayment).map(Payment::getFare).orElse(0.0))
                .taxAmount(Optional.ofNullable(thisPayment).map(Payment::getTax).orElse(0.0))
                .discount(Optional.ofNullable(thisPayment).map(Payment::getDiscount).orElse(0.0))
                .payment(Optional.ofNullable(thisPayment)
                        .map(payment -> {
                            return payment.getFare() + payment.getTax() - payment.getDiscount();
                        }).orElse(0.0))
                .status(getRealStatus(Optional.ofNullable(thisPayment).map(Payment::getStatus).orElse(Status.PENDING)));
    }
}
