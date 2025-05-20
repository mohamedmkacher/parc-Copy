package com.example.demo.entities;

import java.util.Date;

public class Location {
    private Client client;
    private Voiture voiture;
    private Date date_debut;
    private Date date_fin;

    public Location(Client client, Voiture voiture, Date date_debut, Date date_fin) {
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
}
