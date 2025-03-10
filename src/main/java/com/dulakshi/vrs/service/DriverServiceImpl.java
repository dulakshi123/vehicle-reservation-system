package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.DriverDTO;
import com.dulakshi.vrs.entity.Driver;
import com.dulakshi.vrs.entity.Status;
import com.dulakshi.vrs.repository.DriverRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class DriverServiceImpl implements DriverService {
    private final DriverRepository driverRepository;

    @Override
    public DriverDTO addDriver(DriverDTO driverDTO) {
        Driver driver = new Driver();
        driver.setName(driverDTO.getName());
        driver.setDln(driverDTO.getDln());
        driver.setMobile(driverDTO.getMobile());
        driver.setRegistrationId(driverDTO.getRegId());
        driver.setStatus(Status.AVAILABLE);
        Driver savedDriver = driverRepository.save(driver);

        driverDTO.setId(savedDriver.getId());
        return driverDTO;
    }

    @Override
    public boolean updateDriverStatus(Long id, String status) {
        Optional<Driver> optionalDriver = driverRepository.findById(id);

        if(optionalDriver.isEmpty()) return false;

        Driver driver = optionalDriver.get();
        try {
            driver.setStatus(Status.getStatus(status));
            driverRepository.save(driver);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    @Override
    public List<DriverDTO> getAllDrivers() {
        return driverRepository.findAll().stream().map(driver -> {
            DriverDTO driverDTO = new DriverDTO();
            driverDTO.setId(driver.getId());
            driverDTO.setName(driver.getName());
            driverDTO.setDln(driver.getDln());
            driverDTO.setMobile(driver.getMobile());
            driverDTO.setRegId(driver.getRegistrationId());
            driverDTO.setStatus(driver.getStatus().name());
            return driverDTO;
        }).toList();
    }

    @Override
    public Driver getDriverById(Long id) {
        return driverRepository.findById(id).orElse(null);
    }
}
