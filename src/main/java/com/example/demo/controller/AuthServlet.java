package com.example.demo.controller;

import com.example.demo.entities.User;
import com.example.demo.model.ModelUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {
    private ModelUser modelUser;

    @Override
    public void init() throws ServletException {
        modelUser = new ModelUser();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        System.out.println("GET Path Info: " + pathInfo); // Pour le débogage
        
        if ("/logout".equals(pathInfo)) {
            handleLogout(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        System.out.println("POST Path Info: " + pathInfo); // Pour le débogage
        
        if ("/login".equals(pathInfo)) {
            handleLogin(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("Login attempt - Username: " + username); // Pour le débogage

        User user = modelUser.getUser(username);
        
        if (user != null && user.getPassword().equals(password) && user.isEnabled()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if ("ADMIN".equals(user.getRole())) {
                session.setAttribute("role", "ADMIN");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                session.setAttribute("role", "CLIENT");
                response.sendRedirect(request.getContextPath() + "/client/dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/");
    }
} 