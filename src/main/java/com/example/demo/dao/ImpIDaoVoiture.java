package com.example.demo.dao;


import com.example.demo.entities.Parc;
import com.example.demo.entities.Voiture;
import com.example.demo.utilitaire.Connexion;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;

public class ImpIDaoVoiture implements IDaoVoiture {
    private Connection cnx = Connexion.getConnection();
    private ImpIDaoParc daoParc = new ImpIDaoParc();

    @Override
    public void ajouterVoiture(Voiture voiture) {
        try {
            PreparedStatement query = cnx.prepareStatement("insert into voiture values(null,?,?,?,?,?,?)");
            query.setString(1, voiture.getMatricule());
            query.setString(2, voiture.getModele());
            query.setString(3, voiture.getMarque());
            query.setFloat(4, voiture.getKilometrage());
            query.setInt(5, voiture.getParc().getNum_parc());
            query.setDouble(6, voiture.getPrixJour());
            query.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);

        }

    }

    @Override
    public void supprimerVoiture(int id) {
        try {
            PreparedStatement query = cnx.prepareStatement("delete from voiture where code_voiture=?");
            query.setInt(1, id);
            query.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public ArrayList<Voiture> getVoitures() {
        ArrayList<Voiture> voitures = new ArrayList<>();
        try {
            PreparedStatement query = cnx.prepareStatement("select * from voiture");
            ResultSet rs = query.executeQuery();
            while (rs.next()) {
                Parc parc = new Parc();
                parc = daoParc.getParc(rs.getInt("num_parc"));
                Voiture voiture = new Voiture();
                voiture.setCode_voiture(rs.getInt("code_voiture"));
                voiture.setMatricule(rs.getString("matricule"));
                voiture.setModele(rs.getString("modele"));
                voiture.setMarque(rs.getString("marque"));
                voiture.setKilometrage(rs.getFloat("kilometrage"));
                voiture.setParc(parc);
                voiture.setPrixJour(rs.getDouble("prix_jour"));
                voitures.add(voiture);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return voitures;
    }

    @Override
    public Voiture getVoiture(int id) {
        
        try {
            PreparedStatement query = cnx.prepareStatement("select * from voiture where code_voiture=?");
            query.setInt(1, id);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {

                Parc parc;
                parc = daoParc.getParc(rs.getInt("num_parc"));


                return new Voiture(rs.getInt("code_voiture"),rs.getString("matricule"),rs.getString("marque"),rs.getString("modele"),rs.getFloat("kilometrage"),parc, rs.getDouble("prix_jour"));
            }else{
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void modifierVoiture(Voiture voiture) {
        try {
            PreparedStatement query = this.cnx.prepareStatement("update voiture set matricule=?,modele=? ,marque=?,kilometrage=? ,num_parc=?, prix_jour=? where code_voiture=?");
            query.setString(1, voiture.getMatricule());
            query.setString(2, voiture.getModele());
            query.setString(3, voiture.getMarque());
            query.setFloat(4, voiture.getKilometrage());
            query.setInt(5, voiture.getParc().getNum_parc());
            query.setDouble(6, voiture.getPrixJour());
            query.setInt(7, voiture.getCode_voiture());
            query.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public ArrayList<Voiture> getVoituresDisponibles(Date dateDebut, Date dateFin) {
        ArrayList<Voiture> voituresDisponibles = new ArrayList<>();
        
        String sql = "SELECT v.* FROM voiture v " +
                    "WHERE v.code_voiture NOT IN (" +
                    "    SELECT l.code_voiture FROM location l " +
                    "    WHERE (l.date_debut <= ? AND l.date_fin >= ?) " + // Chevauchement début
                    "    OR (l.date_debut <= ? AND l.date_fin >= ?) " +    // Chevauchement fin
                    "    OR (l.date_debut >= ? AND l.date_fin <= ?) " +    // Période complètement incluse
                    ")";

        try (PreparedStatement stmt = cnx.prepareStatement(sql)) {
            // Paramètres pour la requête
            stmt.setDate(1, dateFin);
            stmt.setDate(2, dateDebut);
            stmt.setDate(3, dateFin);
            stmt.setDate(4, dateDebut);
            stmt.setDate(5, dateDebut);
            stmt.setDate(6, dateFin);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Voiture voiture = new Voiture();
                voiture.setCode_voiture(rs.getInt("code_voiture"));
                voiture.setMatricule(rs.getString("matricule"));
                voiture.setMarque(rs.getString("marque"));
                voiture.setModele(rs.getString("modele"));
                voiture.setKilometrage(rs.getFloat("kilometrage"));
                // Récupérer le parc associé
                Parc parc = daoParc.getParc(rs.getInt("num_parc"));
                voiture.setParc(parc);
                voiture.setPrixJour(rs.getDouble("prix_jour"));
                voituresDisponibles.add(voiture);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la recherche des voitures disponibles : " + e.getMessage(), e);
        }
        
        return voituresDisponibles;
    }
}
