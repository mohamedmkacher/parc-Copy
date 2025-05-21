package com.example.demo.dao;

import com.example.demo.entities.Location;

import java.sql.Date;
import java.util.ArrayList;

public interface IDaoLocation {
    Location save(Location location);
    Location update(Location location);
    boolean delete(int id);
    Location findById(int id);
    ArrayList<Location> findAll();
    ArrayList<Location> findByClient(int clientId);
    ArrayList<Location> findByVoiture(int voitureId);
    ArrayList<Location> findByStatut(String statut);
    ArrayList<Location> findByDateRange(java.sql.Date dateDebut, Date dateFin);
    void validerLocation(int id);
    void refuserLocation(int id);
    void terminerLocation(int id);
}
