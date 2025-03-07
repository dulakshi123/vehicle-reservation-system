package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.VehicleDTO;

import java.util.List;

public interface VehicleService {
    VehicleDTO addNewVehicle(VehicleDTO vehicleDTO);
    boolean updateVehicleStatus(Long vehicleId, String status);
    List<VehicleDTO> getAllVehicles();
}
