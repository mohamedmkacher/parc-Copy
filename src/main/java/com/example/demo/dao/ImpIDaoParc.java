package com.example.demo.dao;

import com.example.demo.entities.Parc;

import com.example.demo.utilitaire.Connexion;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ImpIDaoParc implements IDaoParc {
    private Connection cnx = Connexion.getConnection();

    @Override
    public void ajouterParc(Parc parc) {
        try {
            PreparedStatement query = this.cnx.prepareStatement("insert into parc values(null,?,?,?)");
            query.setString(1, parc.getLibelle());
            query.setInt(2, parc.getCapacite());
            query.setString(3, parc.getLocalisation());
            query.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void supprimerParc(int code) {
        try {
            PreparedStatement query = this.cnx.prepareStatement("delete from parc where num_Parc=?");
            query.setInt(1, code);
            query.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void modifierParc(Parc parc) {
        try {
            PreparedStatement query = this.cnx.prepareStatement("update parc set libelle=?,capacite=?,localisation=? where num_parc=?");
            query.setString(1, parc.getLibelle());
            query.setInt(2, parc.getCapacite());
            query.setString(3, parc.getLocalisation());
            query.setInt(4, parc.getNum_parc());
            query.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public Parc getParc(int id) {
        try {
            PreparedStatement query = cnx.prepareStatement("select * from parc where num_parc=?");
            query.setInt(1, id);
            ResultSet rs = query.executeQuery();
            if (rs.next()) {
                return new Parc(rs.getInt("num_parc"),rs.getString("libelle"),rs.getInt("capacite"),rs.getString("localisation"));
            } else {
                return null;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public ArrayList<Parc> getParcs() {
        ArrayList<Parc> parcs = new ArrayList<>();

        try (PreparedStatement query = this.cnx.prepareStatement("select * from parc")) {
            ResultSet rs = query.executeQuery();
            while (rs.next()) {
                Parc parc = new Parc();
                parc.setLibelle(rs.getString("libelle"));
                parc.setCapacite(rs.getInt("capacite"));
                parc.setLocalisation(rs.getString("localisation"));
                parc.setNum_parc(rs.getInt("num_parc"));
                parcs.add(parc);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return parcs;
    }
}
