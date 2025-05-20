package com.example.demo.model;


import com.example.demo.dao.IDAOUser;
import com.example.demo.dao.UserDAO;
import com.example.demo.entities.User;


import java.util.List;

public class ModelUser {
    private User user;
    private IDAOUser daoUser;

    public ModelUser() {
        this.daoUser = new UserDAO();
    }

    public List<User> list() {
        return daoUser.findAll();
    }

    public void add() {
        this.daoUser.create(user);
    }

    public User getUser(String username) {
        return daoUser.findByUsername(username);
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
} 