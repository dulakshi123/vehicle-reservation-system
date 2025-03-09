package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.ReservationRequestDTO;
import com.dulakshi.vrs.entity.User;

import java.util.List;

public interface ReservationService {
    boolean addReservation(ReservationRequestDTO reservationDTO, User user);
    boolean updateReservation(ReservationRequestDTO reservationDTO);
    boolean requestCancellation(Long reservationId);
    List<ReservationRequestDTO> getReservationsByUserId(Long userId);
    List<ReservationRequestDTO> getAllReservation();
}
