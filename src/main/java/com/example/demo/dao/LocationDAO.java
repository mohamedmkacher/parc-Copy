package com.example.demo.dao;

import com.example.demo.entities.Location;
import com.example.demo.model.ModelClient;
import com.example.demo.model.ModelVoiture;
import com.example.demo.utilitaire.Connexion;

import java.sql.*;
import java.util.ArrayList;

public class LocationDAO implements IDaoLocation {
    private Connection connection;

    public LocationDAO() {
        connection = Connexion.getConnection();
    }

    @Override
    public Location save(Location location) {
        String query = "INSERT INTO location (code_client, code_voiture, date_debut, date_fin, montant, valide, statut) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, location.getClient().getId());
            ps.setInt(2, location.getVoiture().getCode_voiture());
            ps.setDate(3, location.getDate_debut());
            ps.setDate(4, location.getDate_fin());
            ps.setDouble(5, location.getMontant());
            ps.setBoolean(6, location.isValide());
            ps.setString(7, location.getStatut());

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    location.setId(rs.getInt(1));
                    return location;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Location update(Location location) {
        String query = "UPDATE location SET code_client=?, code_voiture=?, date_debut=?, date_fin=?, montant=?, valide=?, statut=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, location.getClient().getId());
            ps.setInt(2, location.getVoiture().getCode_voiture());
            ps.setDate(3, location.getDate_debut());
            ps.setDate(4, location.getDate_fin());
            ps.setDouble(5, location.getMontant());
            ps.setBoolean(6, location.isValide());
            ps.setString(7, location.getStatut());
            ps.setInt(8, location.getId());

            if (ps.executeUpdate() > 0) {
                return location;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean delete(int id) {
        String query = "DELETE FROM location WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Location findById(int id) {
        String query = "SELECT * FROM location WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractLocationFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public ArrayList<Location> findAll() {
        ArrayList<Location> locations = new ArrayList<>();
        String query = "SELECT * FROM location ORDER BY date_debut DESC";
        try (Statement st = connection.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                locations.add(extractLocationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }

    @Override
    public ArrayList<Location> findByClient(int clientId) {
        ArrayList<Location> locations = new ArrayList<>();
        String query = "SELECT * FROM location WHERE code_client=? ORDER BY date_debut DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, clientId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                locations.add(extractLocationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }

    @Override
    public ArrayList<Location> findByVoiture(int voitureId) {
        ArrayList<Location> locations = new ArrayList<>();
        String query = "SELECT * FROM location WHERE code_voiture=? ORDER BY date_debut DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, voitureId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                locations.add(extractLocationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }

    @Override
    public ArrayList<Location> findByStatut(String statut) {
        ArrayList<Location> locations = new ArrayList<>();
        String query = "SELECT * FROM location WHERE statut=? ORDER BY date_debut DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, statut);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                locations.add(extractLocationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }

    @Override
    public ArrayList<Location> findByDateRange(java.sql.Date dateDebut, Date dateFin) {
        ArrayList<Location> locations = new ArrayList<>();
        String query = "SELECT * FROM location WHERE date_debut >= ? AND date_fin <= ? ORDER BY date_debut DESC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setDate(1, dateDebut);
            ps.setDate(2, dateFin);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                locations.add(extractLocationFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }

    @Override
    public void validerLocation(int id) {
        String query = "UPDATE location SET valide=true, statut='VALIDE' WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void refuserLocation(int id) {
        String query = "UPDATE location SET valide=false, statut='REFUSE' WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void terminerLocation(int id) {
        String query = "UPDATE location SET statut='TERMINE' WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Location extractLocationFromResultSet(ResultSet rs) throws SQLException {
        Location location = new Location();
        location.setId(rs.getInt("id"));

        // Récupérer le client
        ModelClient modelClient = new ModelClient();
        location.setClient(modelClient.getClient(rs.getInt("code_client")));

        // Récupérer la voiture
        ModelVoiture modelVoiture = new ModelVoiture();
        location.setVoiture(modelVoiture.getVoiture(rs.getInt("code_voiture")));

        location.setDate_debut(rs.getDate("date_debut"));
        location.setDate_fin(rs.getDate("date_fin"));
        location.setMontant(rs.getDouble("montant"));
        location.setValide(rs.getBoolean("valide"));
        location.setStatut(rs.getString("statut"));

        return location;
    }
}
