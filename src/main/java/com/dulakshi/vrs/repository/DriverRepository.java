package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Driver;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DriverRepository extends JpaRepository<Driver, Long> {
    long countAllBy();
}
