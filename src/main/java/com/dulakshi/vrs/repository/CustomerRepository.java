package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CustomerRepository extends JpaRepository<Customer, Long> {
    Optional<Customer> findFirstByOrderByRegistrationIdDesc();
}
