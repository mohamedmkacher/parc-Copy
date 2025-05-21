package com.example.demo.model;

import com.example.demo.dao.*;
import com.example.demo.entities.Location;

import java.util.ArrayList;

public class ModelLocation {
    private IDaoLocation daoLocation;
    private IDaoVoiture daoVoiture;
    private IDaoClient daoClient;

    private Location location;

    public ModelLocation() {
        this.daoLocation = new LocationDAO();
        this.daoVoiture = new ImpIDaoVoiture();
        this.daoClient = new ImpIDaoClient();
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public ArrayList<Location> list() {
        return daoLocation.findAll();
    }

    public void add() {
        daoLocation.save(location);
    }


    public void delete() {
        daoLocation.delete(location.getId());
    }

    public Location getLocation(int id) {
        return daoLocation.findById(id);
    }


    public void update() {
        daoLocation.update(location);
    }

    public void validate() {
        daoLocation.validerLocation(location.getId());
    }


    public void refuse() {
        daoLocation.refuserLocation(location.getId());
    }

    public void terminate() {
        daoLocation.terminerLocation(location.getId());
    }








}