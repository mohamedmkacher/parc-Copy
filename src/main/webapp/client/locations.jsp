<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.entities.Location" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Locations | AutoLoc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --warning-gradient: linear-gradient(135deg, #f1c40f, #f39c12);
            --success-gradient: linear-gradient(135deg, #2ecc71, #27ae60);
            --info-gradient: linear-gradient(135deg, #3498db, #2980b9);
            --card-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 1rem 1rem;
        }

        .stats-card {
            border-radius: 1rem;
            border: none;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease;
            overflow: hidden;
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .car-image {
            width: 120px;
            height: 80px;
            object-fit: cover;
            border-radius: 0.5rem;
            box-shadow: var(--card-shadow);
        }

        .status-badge {
            padding: 0.5rem 1.5rem;
            border-radius: 2rem;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .table-card {
            background: white;
            border-radius: 1rem;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .custom-table th {
            background: #f8f9fa;
            border-top: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.5px;
        }

        .custom-table td {
            vertical-align: middle;
        }

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: var(--card-shadow);
        }
    </style>
</head>
<body>
<div class="page-header">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center">
            <h1 class="h3 mb-0">
                <i class="fas fa-car me-2"></i>Mes Locations
            </h1>
            <div class="d-flex gap-2">
                <a href="<%= request.getContextPath() %>/voitures" class="btn btn-light btn-action">
                    <i class="fas fa-plus me-2"></i>Nouvelle Location
                </a>
                <a href="<%= request.getContextPath() %>/client/dashboard.jsp" class="btn btn-outline-light btn-action">
                    <i class="fas fa-arrow-left me-2"></i>Dashboard
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid">
    <% if(request.getAttribute("message") != null) { %>
    <div class="alert alert-<%= request.getAttribute("messageType") %> alert-dismissible fade show" role="alert">
        <%= request.getAttribute("message") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <!-- Statistiques -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="stats-card h-100">
                <div class="card-body" style="background: var(--primary-gradient);">
                    <div class="text-white text-center">
                        <i class="fas fa-car-side stats-icon"></i>
                        <h3 class="h2 mb-2"><%= request.getAttribute("locationsActives") %></h3>
                        <p class="mb-0">Locations Actives</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card h-100">
                <div class="card-body" style="background: var(--warning-gradient);">
                    <div class="text-white text-center">
                        <i class="fas fa-clock stats-icon"></i>
                        <h3 class="h2 mb-2"><%= request.getAttribute("locationsEnAttente") %></h3>
                        <p class="mb-0">En Attente</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card h-100">
                <div class="card-body" style="background: var(--info-gradient);">
                    <div class="text-white text-center">
                        <i class="fas fa-history stats-icon"></i>
                        <h3 class="h2 mb-2"><%= request.getAttribute("locationsTerminees") %></h3>
                        <p class="mb-0">Historique</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Liste des locations -->
    <div class="table-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover mb-0">
                <thead>
                <tr>
                    <th>Véhicule</th>
                    <th>Période</th>
                    <th>Montant</th>
                    <th>Statut</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Location> locations = (List<Location>)request.getAttribute("locations");
                    if(locations != null) {
                        for(Location location : locations) {
                %>
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <div>
                                <h6 class="mb-1"><%= location.getVoiture().getMarque() %> <%= location.getVoiture().getModele() %></h6>
                                <small class="text-muted"><%= location.getVoiture().getMatricule() %></small>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="d-flex flex-column">
                            <span>Du: <%= location.getDate_debut() %></span>
                            <small class="text-muted">Au: <%= location.getDate_fin() %></small>
                        </div>
                    </td>
                    <td>
                        <strong><%= location.getMontant() %> €</strong>
                    </td>
                    <td>
                        <%
                            String badgeClass = "";
                            String statut = "";
                            switch(location.getStatut()) {
                                case "EN_ATTENTE":
                                    badgeClass = "bg-warning";
                                    statut = "En attente";
                                    break;
                                case "VALIDE":
                                    badgeClass = "bg-success";
                                    statut = "Validée";
                                    break;
                                case "REFUSE":
                                    badgeClass = "bg-danger";
                                    statut = "Refusée";
                                    break;
                                case "TERMINE":
                                    badgeClass = "bg-info";
                                    statut = "Terminée";
                                    break;
                            }
                        %>
                        <span class="status-badge <%= badgeClass %>"><%= statut %></span>
                    </td>
                    <td>
                        <div class="d-flex gap-2">
                            <% if("VALIDE".equals(location.getStatut())) { %>
                            <form action="<%= request.getContextPath() %>/location/terminate" method="post">
                                <input type="hidden" name="id" value="<%= location.getId() %>">
                                <button type="submit" class="btn btn-info btn-sm btn-action">
                                    <i class="fas fa-flag-checkered me-2"></i>Terminer
                                </button>
                            </form>
                            <% } %>
                            <a href="<%= request.getContextPath() %>/location/details?id=<%= location.getId() %>"
                               class="btn btn-primary btn-sm btn-action">
                                <i class="fas fa-eye me-2"></i>Détails
                            </a>
                        </div>
                    </td>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>