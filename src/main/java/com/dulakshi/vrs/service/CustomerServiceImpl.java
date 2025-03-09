package com.dulakshi.vrs.service;

import com.dulakshi.vrs.dto.CustomerDTO;
import com.dulakshi.vrs.dto.CustomerRegistrationRequestDTO;
import com.dulakshi.vrs.entity.Customer;
import com.dulakshi.vrs.entity.User;
import com.dulakshi.vrs.entity.UserRole;
import com.dulakshi.vrs.repository.CustomerRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class CustomerServiceImpl implements CustomerService {
    private final CustomerRepository customerRepository;
    private final UserService userService;

    @Override
    public boolean addCustomer(CustomerRegistrationRequestDTO customerDTO) {
        User registeredUser = registerUser(customerDTO.getEmail(), customerDTO.getPassword());

        if(registeredUser == null) {
            return false;
        }

        Customer customer = new Customer();
        customer.setName(customerDTO.getName());
        customer.setUser(registeredUser);
        customer.setMobile(customerDTO.getMobile());
        customer.setNic(customerDTO.getNic());
        customer.setAddress(customerDTO.getAddress());
        customer.setRegistrationId(generateRegistrationId());

        customerRepository.save(customer);
        return true;
    }

    private User registerUser(String email, String password) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setUserRole(UserRole.CUSTOMER);
        return userService.register(user);
    }

    private String generateRegistrationId() {
        String registrationId = null;
        Optional<Customer> optionalCustomer = customerRepository.findFirstByOrderByRegistrationIdDesc();

        if(optionalCustomer.isEmpty()) {
            registrationId = "CR-00001";
        } else {
            registrationId = optionalCustomer.get().getRegistrationId();
            int number = Integer.parseInt(registrationId.substring(3));
            number++;
            registrationId = "CR-" + String.format("%05d", number);
        }
        return registrationId;
    }

    @Override
    public CustomerDTO getCustomer(Long userId) {
        Optional<Customer> optionalCustomer = customerRepository.findById(userId);
        return optionalCustomer.map(this::getCustomerDTO).orElse(null);
    }

    @Override
    public List<CustomerDTO> getAllCustomers() {
        return customerRepository.findAll().stream().map(this::getCustomerDTO).toList();
    }

    private CustomerDTO getCustomerDTO(Customer customer) {
        CustomerDTO customerDTO = new CustomerDTO();
        customerDTO.setId(customerDTO.getId());
        customerDTO.setRegId(customer.getRegistrationId());
        customerDTO.setName(customer.getName());
        customerDTO.setMobile(customer.getMobile());
        customerDTO.setEmail(customer.getUser().getEmail());
        customerDTO.setNic(customer.getNic());
        customerDTO.setAddress(customer.getAddress());
        return customerDTO;
    }
}
