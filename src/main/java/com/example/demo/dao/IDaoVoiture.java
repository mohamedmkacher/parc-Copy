package com.example.demo.dao;

import com.example.demo.entities.Voiture;
import java.sql.Date;
import java.util.ArrayList;

public interface IDaoVoiture {
    void ajouterVoiture(Voiture voiture);

    void supprimerVoiture(int id);

    ArrayList<Voiture> getVoitures();

    Voiture getVoiture(int id);

    void modifierVoiture(Voiture voiture);

    ArrayList<Voiture> getVoituresDisponibles(Date dateDebut, Date dateFin);

}
