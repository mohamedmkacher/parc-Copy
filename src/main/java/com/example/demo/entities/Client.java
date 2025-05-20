package com.example.demo.entities;

public class Client {
    private int code_client;
    private String num_cin;
    private String num_permis;
    private String nom;
    private String prenom;
    private int age;
    private String adresse;
    private String tel;
    private String email;

    @Override
    public String toString() {
        return "Client{" +
                "code_client=" + code_client +
                ", num_cin='" + num_cin + '\'' +
                ", num_permis='" + num_permis + '\'' +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", age=" + age +
                ", adresse='" + adresse + '\'' +
                ", tel='" + tel + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
    public Client() {}

    public Client(int code_client, String num_cin, String num_permis, String nom, String prenom, int age, String adresse, String tel, String email) {
        this.code_client = code_client;
        this.num_cin = num_cin;
        this.num_permis = num_permis;
        this.nom = nom;
        this.prenom = prenom;
        this.age = age;
        this.adresse = adresse;
        this.tel = tel;
        this.email = email;
    }

    public int getCode_client() {
        return code_client;
    }

    public void setCode_client(int code_client) {
        this.code_client = code_client;
    }

    public String getNum_cin() {
        return num_cin;
    }

    public void setNum_cin(String num_cin) {
        this.num_cin = num_cin;
    }

    public String getNum_permis() {
        return num_permis;
    }

    public void setNum_permis(String num_permis) {
        this.num_permis = num_permis;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}

