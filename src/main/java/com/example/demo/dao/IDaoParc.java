package com.example.demo.dao;



import com.example.demo.entities.Parc;

import java.util.ArrayList;

public interface IDaoParc {
    void ajouterParc(Parc parc);
    void supprimerParc(int code);
    void modifierParc(Parc parc);
    Parc getParc(int id);
    ArrayList<Parc> getParcs();

}
