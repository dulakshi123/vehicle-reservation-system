package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
}
