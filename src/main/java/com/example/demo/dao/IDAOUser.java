package com.example.demo.dao;

import com.example.demo.entities.User;
import java.util.List;

public interface IDAOUser {
    User findByUsername(String username);
    boolean create(User user);
    List<User> findAll();
}
