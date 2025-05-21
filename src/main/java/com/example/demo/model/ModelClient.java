package com.example.demo.model;

import com.example.demo.dao.IDaoClient;
import com.example.demo.dao.ImpIDaoClient;
import com.example.demo.entities.Client;


import java.util.ArrayList;

public class ModelClient {
    private Client client;
    private IDaoClient daoClient;

    public ModelClient() {
        this.daoClient = new ImpIDaoClient();

    }
    public ArrayList<Client> list() {
        return daoClient.getClients();
    }

    public void add() {
        this.daoClient.ajouterClient(client);
    }

    public void delete() {
        this.daoClient.supprimerClient(client.getId());
    }
    public Client getClient(int id) {
        return daoClient.getClient(id);
    }

    public void update() {
        this.daoClient.modifierClient(client);
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }




}
