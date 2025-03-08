package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
}
