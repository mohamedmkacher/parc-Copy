package com.example.demo.dao;

import com.example.demo.entities.Client;


import java.util.ArrayList;

public interface IDaoClient {
    void ajouterClient(Client client);

    void supprimerClient(int id);

    void modifierClient(Client client);

    Client getClient(int id);

    ArrayList<Client> getClients();
    Client rechercheByNumCIN(String numCIN);
    Client rechercheByNom(String nom);

}
