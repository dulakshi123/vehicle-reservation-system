package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Customer;
import com.dulakshi.vrs.entity.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    Optional<Reservation> findReservationByCustomerAndDatetime(Customer customer, LocalDateTime dateTime);

    List<Reservation> findReservationsByCustomer(Customer customer);
}
