package com.dulakshi.vrs.repository;

import com.dulakshi.vrs.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
}
