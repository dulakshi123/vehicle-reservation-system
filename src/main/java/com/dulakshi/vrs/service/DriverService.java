package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.DriverDTO;
import com.dulakshi.vrs.entity.Driver;

import java.util.List;

public interface DriverService {
    DriverDTO addDriver(DriverDTO driverDTO);
    boolean updateDriverStatus(Long id, String status);
    List<DriverDTO> getAllDrivers();
}
