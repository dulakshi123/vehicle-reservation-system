package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.DriverDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DriverServiceImpl implements DriverService {
    @Override
    public DriverDTO addDriver(DriverDTO driverDTO) {
        return null;
    }

    @Override
    public boolean updateDriverStatus(Long id, String status) {
        return false;
    }

    @Override
    public List<DriverDTO> getAllDrivers() {
        return List.of();
    }
}
