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
            PreparedStatement query = cnx.prepareStatement("insert into client values (null,?,?,?,?,?,?,?,?)");
            query.setString(1, client.getNum_cin());
            query.setString(2, client.getNom());
            query.setString(3, client.getPrenom());
            query.setInt(4, client.getAge());
            query.setString(5, client.getAdresse());
            query.setString(6, client.getNum_permis());
            query.setString(7, client.getEmail());
            query.setString(8, client.getTel());
            query.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void supprimerClient(int id) {
        try {
            PreparedStatement query = cnx.prepareStatement("delete from client where code_client=?");
            query.setInt(1, id);
            query.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    public void modifierClient(Client client) {
        try {
            PreparedStatement query = cnx.prepareStatement("update client set num_cin=?,nom=?, prenom=?,age=?,adresse=?,num_permis=?,email=?, tel=? where code_client=?");
            query.setString(1, client.getNum_cin());
            query.setString(2, client.getNom());
            query.setString(3, client.getPrenom());
            query.setInt(4, client.getAge());
            query.setString(5, client.getAdresse());
            query.setString(6, client.getNum_permis());
            query.setString(7, client.getEmail());
            query.setString(8, client.getTel());
            query.setInt(9, client.getCode_client());

            query.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public Client getClient(int id) {

        try {
            PreparedStatement query = cnx.prepareStatement("select * from client where code_client=?");
            query.setInt(1, id);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                return new Client(rs.getInt("code_client"),
                        rs.getString("num_cin"),
                        rs.getString("num_permis"),
                        rs.getString("nom"),
                        rs.getString("prenom"),
                        rs.getInt("age"),
                        rs.getString("adresse"),
                        rs.getString("tel"),
                        rs.getString("email"));
            } else {
                return null;
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    public ArrayList<Client> getClients() {

        ArrayList<Client> clients = new ArrayList<>();
        try {
            PreparedStatement query = cnx.prepareStatement("select * from client");
            ResultSet rs = query.executeQuery();
            while (rs.next()) {
                clients.add(new Client(rs.getInt("code_client"), rs.getString("num_cin"), rs.getString("num_permis"), rs.getString("nom"), rs.getString("prenom"), rs.getInt("age"), rs.getString("adresse"), rs.getString("tel"), rs.getString("email")));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return clients;
    }

    @Override
    public Client rechercheByNumCIN(String numCIN) {
        Client client = new Client();
        try {
            PreparedStatement query = cnx.prepareStatement("select * from client where num_cin=?");
            query.setString(1, numCIN);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {

                client.setNum_cin(rs.getString("num_cin"));
                client.setNom(rs.getString("nom"));
                client.setPrenom(rs.getString("prenom"));
                client.setAge(rs.getInt("age"));
                client.setAdresse(rs.getString("adresse"));
                client.setNum_permis(rs.getString("num_permis"));
                client.setEmail(rs.getString("email"));
                client.setTel(rs.getString("tel"));
                client.setCode_client(rs.getInt("code_client"));

            }
            return client;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Client rechercheByNom(String nom) {
        Client client = new Client();
        try {
            PreparedStatement query = cnx.prepareStatement("select * from client where nom=?");
            query.setString(1, nom);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                client.setNum_cin(rs.getString("num_cin"));
                client.setNom(rs.getString("nom"));
                client.setPrenom(rs.getString("prenom"));
                client.setAge(rs.getInt("age"));
                client.setAdresse(rs.getString("adresse"));
                client.setNum_permis(rs.getString("num_permis"));
                client.setEmail(rs.getString("email"));
                client.setTel(rs.getString("tel"));
                client.setCode_client(rs.getInt("code_client"));

            }
            return client;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
