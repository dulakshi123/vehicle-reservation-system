package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.VehicleDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VehicleServiceImpl implements VehicleService {
    @Override
    public VehicleDTO addNewVehicle(VehicleDTO vehicleDTO) {
        return null;
    }

    @Override
    public boolean updateVehicleStatus(Long vehicleId, String status) {
        return false;
    }

    @Override
    public List<VehicleDTO> getAllVehicles() {
        return List.of();
    }
}
