package com.example.demo.model;

import com.example.demo.dao.IDaoParc;
import com.example.demo.dao.ImpIDaoParc;
import com.example.demo.entities.Parc;


import java.util.ArrayList;

public class ModelParc {
    private Parc parc;
    private IDaoParc daoParc;

    public ModelParc() {
        this.daoParc = new ImpIDaoParc();
    }

    public Parc getParc() {
        return parc;
    }

    public void setParc(Parc parc) {
        this.parc = parc;
    }

    public Parc getParc(int code) {
        return this.daoParc.getParc(code);
    }

    public ArrayList<Parc> list() {
        return this.daoParc.getParcs();
    }

    public void add() {
        this.daoParc.ajouterParc(this.parc);
    }

    public void update() {
        this.daoParc.modifierParc(this.parc);
    }

    public void delete() {
        this.daoParc.supprimerParc(this.parc.getNum_parc());
    }
}
