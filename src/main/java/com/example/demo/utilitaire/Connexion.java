package com.example.demo.utilitaire;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {
    private static Connection cnx = null;

   private Connexion() {

    }

    public static Connection getConnection() {
        if (cnx == null) {
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                String url = "jdbc:mariadb://localhost:3306/parc_jee";
                String username = "root";
                String password = "";
                cnx = DriverManager.getConnection(url, username, password);
                System.out.println("✅ Database connected!");
            } catch (ClassNotFoundException e) {
                System.err.println("❌ Driver not found: " + e.getMessage());
            } catch (SQLException e) {
                System.err.println("❌ Connection failed: " + e.getMessage());
            }
        }
        return cnx;
    }

    public static void closeConnection() {
        if (cnx != null) {
            try {
                cnx.close();
                cnx = null;
                System.out.println("🔴 Database connection closed.");
            } catch (SQLException e) {
                System.err.println("⚠️ Failed to close connection: " + e.getMessage());
            }
        }
    }
}
