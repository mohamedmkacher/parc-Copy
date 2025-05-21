package com.example.demo.dao;

import com.example.demo.entities.Client;
import com.example.demo.utilitaire.Connexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ImpIDaoClient implements IDaoClient {
    private Connection cnx = Connexion.getConnection();

    @Override
    public void ajouterClient(Client client) {
        try {
            PreparedStatement query = cnx.prepareStatement(
                "INSERT INTO users (num_cin, nom, prenom, age, adresse, num_permis, email, tel, password, role) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'CLIENT')"
            );
            query.setString(1, client.getNum_cin());
            query.setString(2, client.getNom());
            query.setString(3, client.getPrenom());
            query.setInt(4, client.getAge());
            query.setString(5, client.getAdresse());
            query.setString(6, client.getNum_permis());
            query.setString(7, client.getEmail());
            query.setString(8, client.getTel());
            query.setString(9, "defaultPassword"); // À modifier selon votre logique de mot de passe
            query.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de l'ajout du client : " + e.getMessage(), e);
        }
    }

    @Override
    public void supprimerClient(int id) {
        try {
            PreparedStatement query = cnx.prepareStatement("DELETE FROM users WHERE id = ?");
            query.setInt(1, id);
            query.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la suppression du client : " + e.getMessage(), e);
        }
    }

    @Override
    public void modifierClient(Client client) {
        try {
            PreparedStatement query = cnx.prepareStatement(
                "UPDATE users SET " +
                "num_cin = ?, nom = ?, prenom = ?, age = ?, " +
                "adresse = ?, num_permis = ?, email = ?, tel = ? " +
                "WHERE id = ?"
            );
            query.setString(1, client.getNum_cin());
            query.setString(2, client.getNom());
            query.setString(3, client.getPrenom());
            query.setInt(4, client.getAge());
            query.setString(5, client.getAdresse());
            query.setString(6, client.getNum_permis());
            query.setString(7, client.getEmail());
            query.setString(8, client.getTel());
            query.setInt(9, client.getId());
            System.out.println(query.toString());
            query.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la modification du client : " + e.getMessage(), e);
        }
    }

    @Override
    public Client getClient(int id) {
        try {
            PreparedStatement query = cnx.prepareStatement(
                "SELECT * FROM users WHERE id = ? AND role = 'CLIENT'"
            );
            query.setInt(1, id);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                return mapResultSetToClient(rs);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la récupération du client : " + e.getMessage(), e);
        }
    }

    @Override
    public ArrayList<Client> getClients() {
        ArrayList<Client> clients = new ArrayList<>();
        try {
            PreparedStatement query = cnx.prepareStatement(
                "SELECT * FROM users WHERE role = 'CLIENT'"
            );
            ResultSet rs = query.executeQuery();
            while (rs.next()) {
                clients.add(mapResultSetToClient(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la récupération des clients : " + e.getMessage(), e);
        }
        return clients;
    }

    @Override
    public Client rechercheByNumCIN(String numCIN) {
        try {
            PreparedStatement query = cnx.prepareStatement(
                "SELECT * FROM users WHERE num_cin = ? AND role = 'CLIENT'"
            );
            query.setString(1, numCIN);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                return mapResultSetToClient(rs);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la recherche par CIN : " + e.getMessage(), e);
        }
    }

    @Override
    public Client rechercheByNom(String nom) {
        try {
            PreparedStatement query = cnx.prepareStatement(
                "SELECT * FROM users WHERE nom = ? AND role = 'CLIENT'"
            );
            query.setString(1, nom);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                return mapResultSetToClient(rs);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la recherche par nom : " + e.getMessage(), e);
        }
    }

    // Méthode utilitaire pour mapper un ResultSet vers un objet Client
    private Client mapResultSetToClient(ResultSet rs) throws SQLException {
        Client client = new Client();
        client.setId(rs.getInt("id"));
        client.setNum_cin(rs.getString("num_cin"));
        client.setNom(rs.getString("nom"));
        client.setPrenom(rs.getString("prenom"));
        client.setAge(rs.getInt("age"));
        client.setAdresse(rs.getString("adresse"));
        client.setNum_permis(rs.getString("num_permis"));
        client.setEmail(rs.getString("email"));
        client.setTel(rs.getString("tel"));
        return client;
    }
}
