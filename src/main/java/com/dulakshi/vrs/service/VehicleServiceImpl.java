package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.VehicleDTO;
import com.dulakshi.vrs.entity.Model;
import com.dulakshi.vrs.entity.Status;
import com.dulakshi.vrs.entity.Vehicle;
import com.dulakshi.vrs.repository.VehicleRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class VehicleServiceImpl implements VehicleService {
    private final VehicleRepository vehicleRepository;

    @Override
    public VehicleDTO addNewVehicle(VehicleDTO vehicleDTO) {
        Model vehicleType = Model.getModel(vehicleDTO.getType());

        Vehicle vehicle = new Vehicle();
        vehicle.setVrn(vehicleDTO.getVrn());
        vehicle.setModel(vehicleType);
        vehicle.setStatus(Status.AVAILABLE);
        vehicle.setSeatCount(vehicleType.getPassengerCount());

        Vehicle savedVehicle = vehicleRepository.save(vehicle);

        vehicleDTO.setId(savedVehicle.getId());
        vehicleDTO.setStatus(vehicle.getStatus().name());
        vehicleDTO.setSeatCount(savedVehicle.getSeatCount());
        return vehicleDTO;
    }

    @Override
    public boolean updateVehicleStatus(Long vehicleId, String status) {
        Optional<Vehicle> optionalVehicle = vehicleRepository.findById(vehicleId);

        if(optionalVehicle.isEmpty()) return false;

        Vehicle vehicle = optionalVehicle.get();
        try {
            vehicle.setStatus(Status.getStatus(status));
            vehicleRepository.save(vehicle);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    @Override
    public List<VehicleDTO> getAllVehicles() {
        return vehicleRepository.findAll().stream().map(vehicle -> {
            VehicleDTO vehicleDTO = new VehicleDTO();
            vehicleDTO.setId(vehicle.getId());
            vehicleDTO.setVrn(vehicle.getVrn());
            vehicleDTO.setType(vehicle.getModel().name());
            vehicleDTO.setStatus(vehicle.getStatus().name());
            vehicleDTO.setSeatCount(vehicle.getSeatCount());
            return vehicleDTO;
        }).toList();
    }
}
