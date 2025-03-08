package com.dulakshi.vrs.controller;

import com.dulakshi.vrs.dto.VehicleDTO;
import com.dulakshi.vrs.service.VehicleService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/vehicle")
@AllArgsConstructor
public class VehicleController {
    private final VehicleService vehicleService;

    @GetMapping("/all")
    public ResponseEntity<List<VehicleDTO>> getAllVehicles() {
        return ResponseEntity.ok(vehicleService.getAllVehicles());
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateVehicle(@RequestParam Long id, @RequestParam String status) {
        boolean isSuccess = vehicleService.updateVehicleStatus(id, status);

        if(isSuccess) {
            return ResponseEntity.ok("Status updated successfully");
        } else {
            return ResponseEntity.badRequest().body("Something went wrong");
        }
    }

    @PostMapping("/add")
    public ResponseEntity<?> addVehicle(@RequestBody VehicleDTO vehicleDTO) {
        VehicleDTO addedVehicle = vehicleService.addNewVehicle(vehicleDTO);

        if(addedVehicle == null) {
            return ResponseEntity.badRequest().body("Something went wrong");
        } else {
            return ResponseEntity.ok(addedVehicle);
        }
    }
}
