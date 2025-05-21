package com.example.demo.entities;

import java.sql.Date;

public class Location {
    private int id;
    private Client client;
    private Voiture voiture;
    private java.sql.Date date_debut;
    private java.sql.Date date_fin;
    private boolean valide; // Statut de validation par l'admin
    private double montant; // Montant total de la location
    private String statut; // EN_ATTENTE, VALIDE, REFUSE, TERMINE

    public Location() {
        this.statut = "EN_ATTENTE";
        this.valide = false;
    }

    public Location(Client client, Voiture voiture, Date date_debut, Date date_fin) {
        this();
        this.client = client;
        this.voiture = voiture;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Voiture getVoiture() {
        return voiture;
    }

    public void setVoiture(Voiture voiture) {
        this.voiture = voiture;
    }

    public Date getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(Date date_debut) {
        this.date_debut = date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isValide() {
        return valide;
    }

    public void setValide(boolean valide) {
        this.valide = valide;
        if (valide) {
            this.statut = "VALIDE";
        }
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public void refuser() {
        this.valide = false;
        this.statut = "REFUSE";
    }

    public void terminer() {
        this.statut = "TERMINE";
    }
}
