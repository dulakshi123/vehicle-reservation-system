package com.dulakshi.vrs.controller;

import com.dulakshi.vrs.dto.ReservationRequestDTO;
import com.dulakshi.vrs.entity.User;
import com.dulakshi.vrs.service.ReservationService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/reservation")
@RequiredArgsConstructor
public class ReservationController {
    private final ReservationService reservationService;

    @PostMapping("/admin/add")
    public ResponseEntity<String> addReservation(@RequestBody ReservationRequestDTO reservationDTO, HttpServletRequest request) {
        try {
            User user = (User) request.getSession().getAttribute("_user_");

            boolean isSuccess = reservationService.addReservation(reservationDTO, user);

            if(isSuccess) {
                return ResponseEntity.ok("Successfully reserved your vehicle");
            } else {
                return ResponseEntity.badRequest().body("Something went wrong");
            }
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/admin/update")
    public ResponseEntity<String> updateReservation(@RequestBody ReservationRequestDTO reservationDTO) {
        try {
            boolean isSuccess = reservationService.updateReservation(reservationDTO);

            if(isSuccess) {
                return ResponseEntity.ok("Successfully updated your reservation");
            } else {
                return ResponseEntity.badRequest().body("Something went wrong");
            }
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/customer/cancel")
    public ResponseEntity<String> cancelReservation(@RequestParam Long reservationId) {
        try {
            boolean isSuccess = reservationService.requestCancellation(reservationId);

            if(isSuccess) {
                return ResponseEntity.ok("Successfully cancelled your reservation");
            } else {
                return ResponseEntity.badRequest().body("Something went wrong");
            }
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/customer/get")
    public ResponseEntity<List<ReservationRequestDTO>> getReservations(@RequestParam Long reservationId, HttpServletRequest request) {
        List<ReservationRequestDTO> reservationList = null;
        try {
            User user = (User) request.getSession().getAttribute("_user_");
            reservationList = reservationService.getReservationsByUserId(user.getId());
        } catch (Exception e) {
            reservationList = new ArrayList<>();
        }

        return ResponseEntity.ok(reservationList);
    }

    @GetMapping("/admin/all")
    public ResponseEntity<List<ReservationRequestDTO>> getAllReservations() {
        return ResponseEntity.ok(reservationService.getAllReservation());
    }
}
