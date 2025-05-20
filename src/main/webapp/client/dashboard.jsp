<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.entities.Location" %>
<%@ page import="com.example.demo.entities.Client" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord Client</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .container { margin-top: 30px; }
        .card { margin-bottom: 20px; }
        .card-header { font-weight: bold; }
        .stats-card {
            background: linear-gradient(45deg, #4CAF50, #45a049);
            color: white;
            border: none;
        }
        .stats-card .card-body {
            padding: 1.5rem;
        }
        .stats-card i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .stats-card h3 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        .stats-card p {
            font-size: 1.1rem;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row mb-4">
        <div class="col">
            <h2>Tableau de Bord Client</h2>
            <%
                Client client = (Client)session.getAttribute("client");
                if(client != null) {
            %>
            <p class="text-muted">Bienvenue, <%= client.getNom() %> <%= client.getPrenom() %></p>
            <% } %>
        </div>
    </div>

    <!-- Statistiques -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card stats-card">
                <div class="card-body text-center">
                    <i class="fas fa-car"></i>
                    <h3><%= request.getAttribute("nombreLocations") %></h3>
                    <p>Locations Actives</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stats-card">
                <div class="card-body text-center">
                    <i class="fas fa-clock"></i>
                    <h3><%= request.getAttribute("locationsEnAttente") %></h3>
                    <p>Locations en Attente</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stats-card">
                <div class="card-body text-center">
                    <i class="fas fa-history"></i>
                    <h3><%= request.getAttribute("locationsTerminees") %></h3>
                    <p>Locations Terminées</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions Rapides -->
    <div class="row mb-4">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-bolt"></i> Actions Rapides
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <a href="<%= request.getContextPath() %>/location/add" class="btn btn-primary btn-lg w-100 mb-2">
                                <i class="fas fa-plus"></i> Nouvelle Location
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="<%= request.getContextPath() %>/location/list" class="btn btn-info btn-lg w-100 mb-2">
                                <i class="fas fa-list"></i> Mes Locations
                            </a>
                        </div>
                        <div class="col-md-4">
                            <a href="<%= request.getContextPath() %>/voiture/list" class="btn btn-success btn-lg w-100 mb-2">
                                <i class="fas fa-car"></i> Voir les Voitures
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Dernières Locations -->
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-history"></i> Dernières Locations
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>Voiture</th>
                                <th>Date Début</th>
                                <th>Date Fin</th>
                                <th>Statut</th>
                                <th>Montant</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                List<Location> dernieresLocations = (List<Location>)request.getAttribute("dernieresLocations");
                                if(dernieresLocations != null) {
                                    for(Location location : dernieresLocations) {
                            %>
                            <tr>
                                <td><%= location.getVoiture().getMarque() %> <%= location.getVoiture().getModele() %></td>
                                <td><%= location.getDateDebut() %></td>
                                <td><%= location.getDateFin() %></td>
                                <td>
                                        <span class="badge <%= location.isApprouvee() ? "bg-success" : "bg-warning" %>">
                                            <%= location.isApprouvee() ? "Approuvée" : "En attente" %>
                                        </span>
                                </td>
                                <td><%= location.getMontant() %> €</td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>