package com.example.demo.controller;

import com.example.demo.dao.IDaoVoiture;
import com.example.demo.dao.ImpIDaoVoiture;
import com.example.demo.entities.Voiture;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import com.example.demo.utilitaire.Connexion;

@WebServlet(name = "disponibiliteVoiture", value = {"/voitures"})
public class DisponibiliteVoitureServlet extends HttpServlet {
    private IDaoVoiture daoVoiture = new ImpIDaoVoiture();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Afficher le formulaire de recherche
        request.getRequestDispatcher("recherche_voitures.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Récupérer les dates de début et fin
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");

           // Convertir les String en java.sql.Date
            Date dateDebut = Date.valueOf(dateDebutStr);
            Date dateFin = Date.valueOf(dateFinStr);

            // Utiliser le DAO pour récupérer les voitures disponibles
            ArrayList<Voiture> voituresDisponibles = daoVoiture.getVoituresDisponibles(dateDebut, dateFin);
            System.out.println(voituresDisponibles);

            // Ajouter les résultats à la requête
            request.setAttribute("voitures", voituresDisponibles);
            request.setAttribute("dateDebut", dateDebutStr);
            request.setAttribute("dateFin", dateFinStr);
            
            // Afficher les résultats
            request.getRequestDispatcher("resultats_recherche.jsp").forward(request, response);

        } catch (Exception e) {
           request.setAttribute("erreur", "Une erreur est survenue lors de la recherche : " + e.getMessage());
            request.getRequestDispatcher("recherche_voitures.jsp").forward(request, response);
        }
    }
} 