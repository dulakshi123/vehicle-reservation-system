package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.DriverDTO;
import com.dulakshi.vrs.entity.Driver;

public interface DriverService {
    DriverDTO addDriver(DriverDTO driverDTO);
    DriverDTO updateDriver(Long id, String name);
    DriverDTO getAllDrivers();
}
