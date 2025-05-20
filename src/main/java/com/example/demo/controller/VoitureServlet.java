package com.example.demo.controller;

import com.example.demo.entities.Parc;
import com.example.demo.entities.Voiture;
import com.example.demo.model.ModelParc;
import com.example.demo.model.ModelVoiture;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "voiture", value = {"/voiture", "/voiture/add", "/voiture/save", "/voiture/delete", "/voiture/update", "/voiture/updating", "/voiture/list"})
public class VoitureServlet extends HttpServlet {
    private ModelVoiture modelVoiture = new ModelVoiture();
    private ModelParc modelParc = new ModelParc();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Vérification du rôle ADMIN
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (role == null || !role.equals("ADMIN")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès non autorisé. Rôle ADMIN requis.");
            return;
        }

        String path = request.getServletPath();


        if (path == null || path.equals("/voiture")) {
            response.sendRedirect(request.getContextPath() + "/voiture/list");
            return;
        }

        switch (path) {
            case "/voiture/add":
                List<Parc> parcs = modelParc.list();

                request.setAttribute("parcs", parcs);
                request.getRequestDispatcher("/form_add_voiture.jsp").forward(request, response);
                break;
            case "/voiture/save":
                System.out.println(request.getParameter("kilometrage"));
                Voiture voiture_add = new Voiture();
                voiture_add.setMatricule(request.getParameter("matricule"));
                voiture_add.setModele(request.getParameter("modele"));
                voiture_add.setKilometrage(Float.parseFloat(request.getParameter("kilometrage")));
                voiture_add.setMarque(request.getParameter("marque"));
                Parc parc_add = modelParc.getParc(Integer.parseInt(request.getParameter("parc")));

                voiture_add.setParc(parc_add);

                modelVoiture.setVoiture(voiture_add);
                modelVoiture.add();
                request.setAttribute("added", true);
                request.getRequestDispatcher("/voiture/list").forward(request, response);
                break;


            case "/voiture/list":
                List<Voiture> voitures = modelVoiture.list();

                request.setAttribute("voitures", voitures);
                request.getRequestDispatcher("/gestion_voitures.jsp").forward(request, response);
                break;

            case "/voiture/updating":
                int id_update = Integer.parseInt(request.getParameter("id"));
                Voiture voiture_to_update = modelVoiture.getVoiture(id_update);
                List<Parc> parcs_update = modelParc.list();

                request.setAttribute("parcs", parcs_update);
                request.setAttribute("voiture_to_update", voiture_to_update);
                request.getRequestDispatcher("/form_update_voiture.jsp").forward(request, response);
                break;
            case "/voiture/update":
                int id_updated = Integer.parseInt(request.getParameter("id"));


                Voiture voiture_updated = new Voiture();
                voiture_updated.setCode_voiture(id_updated);
                voiture_updated.setMatricule(request.getParameter("matricule"));
                voiture_updated.setModele(request.getParameter("modele"));
                voiture_updated.setKilometrage(Float.parseFloat(request.getParameter("kilometrage")));
                voiture_updated.setMarque(request.getParameter("marque"));
                Parc parc_updated = modelParc.getParc(Integer.parseInt(request.getParameter("parc")));

                voiture_updated.setParc(parc_updated);


                modelVoiture.setVoiture(voiture_updated);
                modelVoiture.update();
                request.setAttribute("updated", true);
                request.getRequestDispatcher("/voiture/list").forward(request, response);
                break;

            case "/voiture/delete":
                int id_delete = Integer.parseInt(request.getParameter("id"));
                Voiture voiture_delete = new Voiture();
                voiture_delete.setCode_voiture(id_delete);
                modelVoiture.setVoiture(voiture_delete);
                modelVoiture.delete();
                request.setAttribute("deleted", true);
                request.getRequestDispatcher("/voiture/list").forward(request, response);
                break;


        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}