package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<Customer, Long> {
}
