package com.dulakshi.vrs.controller;

import com.dulakshi.vrs.dto.CustomerRegistrationRequestDTO;
import com.dulakshi.vrs.dto.DriverDTO;
import com.dulakshi.vrs.dto.LoginRequestDTO;
import com.dulakshi.vrs.entity.User;
import com.dulakshi.vrs.service.CustomerService;
import com.dulakshi.vrs.service.DriverService;
import com.dulakshi.vrs.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
@AllArgsConstructor
public class UserController {
    private final UserService userService;
    private final DriverService driverService;
    private final CustomerService customerService;

    @PostMapping("/register/customer")
    public ResponseEntity<String> register(@RequestBody CustomerRegistrationRequestDTO customer) {
        try {
            boolean isSuccess = customerService.addCustomer(customer);

            if(isSuccess) {
                return ResponseEntity.ok("Customer registration successfully completed");
            } else {
                return ResponseEntity.badRequest().body("Something went wrong");
            }
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/register/driver")
    public ResponseEntity<DriverDTO> register(@RequestBody DriverDTO driver) {
        DriverDTO driverDTO = driverService.addDriver(driver);
        return ResponseEntity.ok().body(driverDTO);
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequestDTO loginRequest, HttpServletRequest request) {
        try {
            User loggedInUser = userService.login(loginRequest);

            request.getSession().setAttribute("_user_", loggedInUser);

            return ResponseEntity.ok().body("User logged in successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/logout")
    public ResponseEntity<String> logout(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("_user_");

        if(user != null) {
            request.getSession().removeAttribute("_user_");
        }

        return ResponseEntity.ok("Successfully logged out");
    }
}
