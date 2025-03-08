package com.dulakshi.vrs.controller;

import com.dulakshi.vrs.dto.DriverDTO;
import com.dulakshi.vrs.service.DriverService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/driver")
@AllArgsConstructor
public class DriverController {
    private final DriverService driverService;

    @GetMapping("/all")
    public ResponseEntity<List<DriverDTO>> getAllVehicles() {
        return ResponseEntity.ok(driverService.getAllDrivers());
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateVehicle(@RequestParam Long id, @RequestParam String status) {
        boolean isSuccess = driverService.updateDriverStatus(id, status);

        if(isSuccess) {
            return ResponseEntity.ok("Status updated successfully");
        } else {
            return ResponseEntity.badRequest().body("Something went wrong");
        }
    }

    @PostMapping("/add")
    public ResponseEntity<?> addVehicle(@RequestBody DriverDTO driverDTO) {
        DriverDTO addedDriver = driverService.addDriver(driverDTO);

        if(addedDriver == null) {
            return ResponseEntity.badRequest().body("Something went wrong");
        } else {
            return ResponseEntity.ok(addedDriver);
        }
    }
}
