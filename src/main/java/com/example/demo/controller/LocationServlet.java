package com.example.demo.controller;

import com.example.demo.entities.Client;
import com.example.demo.entities.Location;
import com.example.demo.entities.User;
import com.example.demo.entities.Voiture;
import com.example.demo.model.ModelClient;
import com.example.demo.model.ModelLocation;
import com.example.demo.model.ModelVoiture;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "location", value = {
        "/location",
        "/location/add",
        "/location/save",
        "/location/list",
        "/location/validate",
        "/location/refuse",
        "/location/terminate",
        "/location/details",
        "/location/check-info"
})
public class LocationServlet extends HttpServlet {
    private ModelLocation modelLocation = new ModelLocation();
    private ModelClient modelClient = new ModelClient();
    private ModelVoiture modelVoiture = new ModelVoiture();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        } else {
            int id = user.getId();
            Client client = modelClient.getClient(id);
            if (client.getNum_permis() == null) {
                request.getRequestDispatcher("/client/complete-info.jsp").forward(request, response);
                return;
            }

            switch (path) {
                case "/location/add":
                    // Vérifier si le client a toutes les informations requises
                    if (!clientHasRequiredInfo(client)) {
                        request.setAttribute("client", client);
                        request.getRequestDispatcher("/client/complete-info.jsp").forward(request, response);
                        return;
                    }
                    // Afficher le formulaire de location
                    request.getRequestDispatcher("/location/add.jsp").forward(request, response);
                    break;

                case "/location/list":
                    if (isAdmin(session)) {
                        // Liste des locations pour l'admin
                        List<Location> locations = modelLocation.list();
                        request.setAttribute("locations", locations);

                        // Calcul des statistiques
                        int totalLocations = locations.size();
                        int locationsEnAttente = 0;
                        int locationsValidees = 0;
                        int locationsTerminees = 0;

                        for (Location loc : locations) {
                            switch (loc.getStatut()) {
                                case "EN_ATTENTE":
                                    locationsEnAttente++;
                                    break;
                                case "VALIDE":
                                    locationsValidees++;
                                    break;
                                case "TERMINE":
                                    locationsTerminees++;
                                    break;
                            }
                        }

                        request.setAttribute("totalLocations", totalLocations);
                        request.setAttribute("locationsEnAttente", locationsEnAttente);
                        request.setAttribute("locationsValidees", locationsValidees);
                        request.setAttribute("locationsTerminees", locationsTerminees);

                        request.getRequestDispatcher("/admin/locations.jsp").forward(request, response);
                    } else {
                        // Liste des locations du client
                        List<Location> clientLocations = new java.util.ArrayList<>();
                        for (Location loc : modelLocation.list()) {
                            if (loc.getClient().getId() == client.getId()) {
                                clientLocations.add(loc);
                            }
                        }
                        request.setAttribute("locations", clientLocations);
                        request.getRequestDispatcher("/client/locations.jsp").forward(request, response);
                    }
                    break;

                case "/location/details":
                    int locationId = Integer.parseInt(request.getParameter("id"));
                    Location location = modelLocation.getLocation(locationId);
                    if (location != null && (isAdmin(session) || location.getClient().getId() == client.getId())) {
                        request.setAttribute("location", location);
                        request.getRequestDispatcher("/location/details.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/location/list");
                    }
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/location/list");
                    break;
            }
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        } else {
            int id = user.getId();
            Client client = modelClient.getClient(id);
            System.out.println(client);
            if (client.getNum_permis() == null) {
                session.setAttribute("client", client);
                request.getRequestDispatcher("/client/complete-info.jsp").forward(request, response);
                return;
            }


            switch (path) {
                case "/location/save":
                    // Créer une nouvelle location
                    int voitureId = Integer.parseInt(request.getParameter("voitureId"));
                    Date dateDebut = Date.valueOf(request.getParameter("dateDebut"));
                    Date dateFin = Date.valueOf(request.getParameter("dateFin"));

                    Voiture voiture = modelVoiture.getVoiture(voitureId);
                    if (voiture != null) {
                        Location location = new Location(client, voiture, dateDebut, dateFin);
                        double mnt = (Double) session.getAttribute("mnt");
                        voiture.setPrixJour(mnt);
                        double montant1 = calculerMontant(voiture, dateDebut, dateFin);
                        location.setMontant(montant1);
                        modelLocation.setLocation(location);
                        System.out.println(location);
                        modelLocation.add();


                    }
                    response.sendRedirect(request.getContextPath() + "/location/list");
                    break;

                case "/location/validate":
                    if (isAdmin(session)) {
                        int locationId = Integer.parseInt(request.getParameter("id"));
                        Location location = modelLocation.getLocation(locationId);
                        if (location != null) {
                            modelLocation.setLocation(location);
                            modelLocation.validate();
                            session.setAttribute("message", "Location validée avec succès");
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/location/list");
                    break;

                case "/location/refuse":
                    if (isAdmin(session)) {
                        int locationId = Integer.parseInt(request.getParameter("id"));
                        Location location = modelLocation.getLocation(locationId);
                        if (location != null) {
                            modelLocation.setLocation(location);
                            modelLocation.refuse();
                            // Remettre la voiture en disponibilité
                            Voiture v = location.getVoiture();


                            session.setAttribute("message", "Location refusée");
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/location/list");
                    break;

                case "/location/terminate":
                    int locationId = Integer.parseInt(request.getParameter("id"));
                    Location location = modelLocation.getLocation(locationId);
                    if (location != null && (isAdmin(session) || location.getClient().getId() == client.getId())) {
                        modelLocation.setLocation(location);
                        modelLocation.terminate();
                        // Remettre la voiture en disponibilité
                        Voiture v = location.getVoiture();


                        session.setAttribute("message", "Location terminée");
                    }
                    response.sendRedirect(request.getContextPath() + "/location/list");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/location/list");
                    break;
            }

        }

    }

    private boolean clientHasRequiredInfo(Client client) {
        return client != null &&
                client.getNum_cin() != null && !client.getNum_cin().isEmpty() &&
                client.getNum_permis() != null && !client.getNum_permis().isEmpty() &&
                client.getNom() != null && !client.getNom().isEmpty() &&
                client.getPrenom() != null && !client.getPrenom().isEmpty() &&
                client.getAge() > 0 &&
                client.getAdresse() != null && !client.getAdresse().isEmpty() &&
                client.getTel() != null && !client.getTel().isEmpty();
    }

    private boolean isAdmin(HttpSession session) {
        return session.getAttribute("role") != null &&
                session.getAttribute("role").equals("admin");
    }

    private double calculerMontant(Voiture voiture, Date dateDebut, Date dateFin) {
        long diffInMillies = dateFin.getTime() - dateDebut.getTime();
        long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
        return voiture.getPrixJour() * diffInDays;
    }
} 