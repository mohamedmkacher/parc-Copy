package com.example.demo.entities;

public class Voiture {
    private int code_voiture;
    private String matricule;
    private String marque;
    private String modele;
    private float kilometrage;
    private Parc parc;

    public Voiture(int code_voiture, String matricule, String marque, String modele, float kilometrage, Parc parc) {
        this.code_voiture = code_voiture;
        this.matricule = matricule;
        this.marque = marque;
        this.modele = modele;
        this.kilometrage = kilometrage;
        this.parc = parc;
    }

    public Voiture() {

    }

    public int getCode_voiture() {
        return code_voiture;
    }

    public void setCode_voiture(int code_voiture) {
        this.code_voiture = code_voiture;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getMarque() {
        return marque;
    }

    public void setMarque(String marque) {
        this.marque = marque;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public float getKilometrage() {
        return kilometrage;
    }

    public void setKilometrage(float kilometrage) {
        this.kilometrage = kilometrage;
    }

    public Parc getParc() {
        return parc;
    }

    public void setParc(Parc parc) {
        this.parc = parc;
    }
}
