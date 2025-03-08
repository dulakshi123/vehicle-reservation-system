package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.CustomerDTO;
import com.dulakshi.vrs.dto.CustomerRegistrationRequestDTO;

import java.util.List;

public interface CustomerService {
    boolean addCustomer(CustomerRegistrationRequestDTO customerDTO);
    CustomerDTO getCustomer(Long userId);
    List<CustomerDTO> getAllCustomers();
}
