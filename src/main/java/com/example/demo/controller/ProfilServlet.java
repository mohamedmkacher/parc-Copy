package com.example.demo.controller;

import com.example.demo.entities.Client;
import com.example.demo.model.ModelClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "profil", value = "/profil/update")
public class ProfilServlet extends HttpServlet {
    private final ModelClient modelClient = new ModelClient();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);



        Client client = (Client) session.getAttribute("client");

        if (client == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("client", client);
        response.sendRedirect(request.getContextPath() + "/voitures");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Client client = (Client) session.getAttribute("client");


        try {
            int clientId = client.getId();

            System.out.println(client);
            if (client == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Mise à jour des informations du client
            client.setNom(request.getParameter("nom"));
            client.setPrenom(request.getParameter("prenom"));
            client.setEmail(request.getParameter("email"));
            client.setTel(request.getParameter("tel"));
            client.setAdresse(request.getParameter("adresse"));

            if (request.getParameter("numCin") != null) {
                client.setNum_cin(request.getParameter("numCin"));
            }

            if (request.getParameter("numPermis") != null) {
                client.setNum_permis(request.getParameter("numPermis"));
            }

            if (request.getParameter("age") != null) {
                try {
                    client.setAge(Integer.parseInt(request.getParameter("age")));
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "L'âge doit être un nombre valide");
                    request.getRequestDispatcher("/WEB-INF/views/profil.jsp").forward(request, response);
                    return;
                }
            }
            modelClient.setClient(client);
            System.out.println(client);
            modelClient.update();

            // Ajouter un message de succès
            session.setAttribute("message", "Profil mis à jour avec succès");
            session.setAttribute("messageType", "success");

            // Rediriger vers le dashboard
            response.sendRedirect(request.getContextPath() + "/voitures");

        } catch (Exception e) {
            // Log l'erreur
            getServletContext().log("Erreur lors de la mise à jour du profil", e);

            // Ajouter un message d'erreur
            request.setAttribute("error", "Une erreur est survenue lors de la mise à jour du profil");

        }
    }
}