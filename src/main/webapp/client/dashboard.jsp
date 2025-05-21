<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.entities.Location" %>
<%@ page import="com.example.demo.entities.Client" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | AutoLoc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/animate.css@4.1.1/animate.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --success-gradient: linear-gradient(135deg, #2ecc71, #27ae60);
            --warning-gradient: linear-gradient(135deg, #f1c40f, #f39c12);
            --danger-gradient: linear-gradient(135deg, #e74c3c, #c0392b);
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .dashboard-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 1rem 1rem;
        }

        .stats-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            overflow: hidden;
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .stats-header {
            padding: 1.5rem;
            color: white;
        }

        .stats-body {
            padding: 1.5rem;
        }

        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .stats-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .quick-action {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        .quick-action:hover {
            transform: translateY(-5px);
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.15);
        }

        .quick-action i {
            font-size: 2rem;
        }

        .table-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .table-card .card-header {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1.5rem;
        }

        .custom-table {
            margin: 0;
        }

        .custom-table th {
            border-top: none;
            font-weight: 600;
        }

        .custom-table td {
            vertical-align: middle;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-weight: 500;
        }

        .status-approved {
            background: var(--success-gradient);
            color: white;
        }

        .status-pending {
            background: var(--warning-gradient);
            color: white;
        }

        @media (max-width: 768px) {
            .stats-card {
                margin-bottom: 1rem;
            }

            .quick-action {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/client/dashboard.jsp">
            <i class="fas fa-car-side me-2"></i> AutoLoc
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/client/dashboard.jsp">
                        <i class="fas fa-home me-2"></i>Accueil
                    </a>
                </li>

            </ul>
            <div class="d-flex gap-2">

                <a class="btn btn-danger" href="${pageContext.request.contextPath}/auth/logout">
                    <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>

<%
    Client client = (Client)session.getAttribute("client");
%>
<div class="dashboard-header animate__animated animate__fadeIn">
    <div class="container">
        <h1 class="display-5 fw-bold">Tableau de bord</h1>
        <% if(client != null) { %>
        <p class="lead mb-0">Bienvenue, <%= client.getPrenom() %> <%= client.getNom() %></p>
        <% } %>
    </div>
</div>

<div class="container">
    <!-- Statistiques -->
    <div class="row g-4 mb-4 animate__animated animate__fadeInUp">
        <div class="col-md-4">
            <div class="stats-card">
                <div class="stats-header" style="background: var(--primary-gradient)">
                    <i class="fas fa-car-side stats-icon"></i>
                    <div class="stats-number"><%= request.getAttribute("nombreLocations") %></div>
                    <div class="stats-label">Locations Actives</div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <div class="stats-header" style="background: var(--warning-gradient)">
                    <i class="fas fa-clock stats-icon"></i>
                    <div class="stats-number"><%= request.getAttribute("locationsEnAttente") %></div>
                    <div class="stats-label">En Attente</div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <div class="stats-header" style="background: var(--success-gradient)">
                    <i class="fas fa-check-circle stats-icon"></i>
                    <div class="stats-number"><%= request.getAttribute("locationsTerminees") %></div>
                    <div class="stats-label">Terminées</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions Rapides -->
    <div class="row g-4 mb-4 animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/voitures" class="quick-action">
                <i class="fas fa-plus-circle text-primary"></i>
                <div>
                    <h5 class="mb-1">Nouvelle Location</h5>
                    <p class="mb-0 text-muted">Réserver un véhicule</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/location/list" class="quick-action">
                <i class="fas fa-list text-info"></i>
                <div>
                    <h5 class="mb-1">Mes Locations</h5>
                    <p class="mb-0 text-muted">Historique complet</p>
                </div>
            </a>
        </div>

    </div>


</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>