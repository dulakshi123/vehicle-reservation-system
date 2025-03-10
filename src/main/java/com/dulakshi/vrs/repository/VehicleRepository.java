package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
    Optional<Vehicle> findVehicleByVrn(String vrn);
    long countAllBy();
}
