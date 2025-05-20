package com.example.demo.controller;

import com.example.demo.entities.Parc;
import com.example.demo.model.ModelParc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;

@WebServlet(name = "parc", value = {"/parc", "/parc/add", "/parc/save", "/parc/delete", "/parc/update", "/parc/updating", "/parc/list"})
public class ParcServlet extends HttpServlet {
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


        if (path == null || path.equals("/parc")) {
            response.sendRedirect(request.getContextPath() + "/parc/list");
            return;
        }

        switch (path) {
            case "/parc/add":
                request.getRequestDispatcher("/form_add_parc.jsp").forward(request, response);
                break;
            case "/parc/save":
                Parc parc_add = new Parc();
                parc_add.setCapacite(Integer.parseInt(request.getParameter("capacite")));
                parc_add.setLocalisation(request.getParameter("localisation"));
                parc_add.setLibelle(request.getParameter("libelle"));
                modelParc.setParc(parc_add);
                modelParc.add();
                request.setAttribute("added", true);
                request.getRequestDispatcher("/parc/list").forward(request, response);
                break;


            case "/parc/list":
                List<Parc> parcs = modelParc.list();

                request.setAttribute("parcs", parcs);
                request.getRequestDispatcher("/gestion_parcs.jsp").forward(request, response);
                break;

            case "/parc/updating":
                int id_update = Integer.parseInt(request.getParameter("id"));
                Parc parc_to_update = modelParc.getParc(id_update);
                request.setAttribute("parc_to_update", parc_to_update);
                System.out.println(parc_to_update);
                request.getRequestDispatcher("/form_update_parc.jsp").forward(request, response);
                break;
            case "/parc/update":
                int id_updated = Integer.parseInt(request.getParameter("id"));
                Parc parc_updated = new Parc();
                parc_updated.setNum_parc(id_updated);
                parc_updated.setLibelle(request.getParameter("libelle"));
                parc_updated.setCapacite(Integer.parseInt(request.getParameter("capacite")));
                parc_updated.setLocalisation(request.getParameter("localisation"));
                modelParc.setParc(parc_updated);
                modelParc.update();
                request.setAttribute("updated", true);
                request.getRequestDispatcher("/parc/list").forward(request, response);
                break;

            case "/parc/delete":
                int id_delete = Integer.parseInt(request.getParameter("id"));
                Parc parc_delete = new Parc();
                parc_delete.setNum_parc(id_delete);
                modelParc.setParc(parc_delete);
                modelParc.delete();
                request.setAttribute("deleted", true);
                request.getRequestDispatcher("/parc/list").forward(request, response);
                break;


        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}