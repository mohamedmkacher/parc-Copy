<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoLoc - Tableau de bord</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.0/dist/chart.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
            --danger-color: #e74c3c;
            --success-color: #2ecc71;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        /* Navigation */
        .navbar {
            background: rgba(44, 62, 80, 0.95) !important;
            backdrop-filter: blur(10px);
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff !important;
        }

        .nav-link {
            color: #fff !important;
            font-weight: 500;
            margin: 0 10px;
            position: relative;
            padding: 0.5rem 1rem;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--accent-color);
            transition: width 0.3s ease;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            position: relative;
            border-radius: 15px;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1511919884226-fd3cad34687c?auto=format&fit=crop&q=80') center/cover;
            opacity: 0.1;
        }

        /* Form Card */
        .form-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: none;
            overflow: hidden;
        }

        .form-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .form-floating {
            margin-bottom: 1.5rem;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid rgba(0,0,0,0.1);
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
        }

        .form-icon {
            position: absolute;
            top: 1.15rem;
            left: 1rem;
            color: var(--primary-color);
            transition: all 0.3s ease;
            z-index: 2;
        }

        .form-floating:focus-within .form-icon {
            color: var(--accent-color);
        }

        .form-floating > label {
            padding-left: 2.5rem;
        }

        /* Buttons */
        .btn {
            border-radius: 10px;
            padding: 0.6rem 1.5rem;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-light {
            background: white;
            border: 1px solid rgba(0,0,0,0.1);
        }

        .btn-light:hover {
            background: var(--light-color);
            transform: translateY(-2px);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        /* Footer */
        .footer {
            background: var(--primary-color);
            color: white;
            padding: 3rem 0;
            margin-top: 4rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-section h5 {
            color: var(--accent-color);
            margin-bottom: 1.5rem;
            font-weight: 600;
        }

        .social-links a {
            color: white;
            margin-right: 1rem;
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            color: var(--accent-color);
            transform: translateY(-3px);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade {
            animation: fadeIn 0.5s ease-out;
        }

        .invalid-feedback {
            font-size: 0.875rem;
            color: var(--danger-color);
        }
    </style>
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --success-color: #2ecc71;
            --warning-color: #f1c40f;
            --danger-color: #e74c3c;
            --info-color: #00cec9;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            padding-top: 4.5rem;
        }

        .navbar {
            background: rgba(44, 62, 80, 0.95) !important;
            backdrop-filter: blur(10px);
        }

        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .stat-card::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2));
            transform: skewX(-15deg);
            transition: all 0.5s ease;
        }

        .stat-card:hover::after {
            transform: translateX(200px) skewX(-15deg);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .quick-action {
            border: none;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 1rem;
        }

        .quick-action:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .quick-action i {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--accent-color);
        }

        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }

        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .activity-item {
            padding: 1rem;
            border-left: 4px solid var(--accent-color);
            margin-bottom: 1rem;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 0 10px 10px 0;
            transition: all 0.3s ease;
        }

        .activity-item:hover {
            transform: translateX(5px);
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--accent-color);
            color: white;
        }

        @media (max-width: 768px) {
            .stat-card {
                margin-bottom: 1rem;
            }
        }
    </style>
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f1c40f;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            padding-top: 4.5rem;
        }

        .navbar {
            background: rgba(44, 62, 80, 0.95) !important;
            backdrop-filter: blur(10px);
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--accent-color);
            transition: all 0.3s ease;
        }

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-add {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .table {
            vertical-align: middle;
        }

        .table th {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            padding: 1rem;
        }

        .alert {
            border: none;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .action-buttons .btn {
            width: 35px;
            height: 35px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
            <i class="fas fa-car-side me-2"></i> AutoLoc
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                        <i class="fas fa-home me-2"></i>Accueil
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/client">
                        <i class="fas fa-users me-2"></i>Clients
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/parc">
                        <i class="fas fa-warehouse me-2"></i>Parcs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/voiture">
                        <i class="fas fa-car me-2"></i>Voitures
                    </a>
                </li>
            </ul>
            <div class="d-flex gap-2">
                <a class="btn btn-outline-light" href="">
                    <i class="fas fa-user-plus me-2"></i>Nouveau compte
                </a>
                <a class="btn btn-danger" href="${pageContext.request.contextPath}/auth/logout">
                    <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container mt-5 animate-fade">
    <!-- Dashboard Header -->
    <div class="dashboard-header mb-4">
        <div class="container">
            <h1 class="h3 mb-0">
                <i class="fas fa-tachometer-alt me-2"></i>
                Tableau de bord
            </h1>
            <p class="mb-0 mt-2">Bienvenue dans votre espace d'administration</p>
        </div>
    </div>

    <!-- Stats Row -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-users stat-icon"></i>
                <h3 class="h4">256</h3>
                <p class="mb-0">Clients Total</p>
                <div class="mt-2 text-success">
                    <small><i class="fas fa-arrow-up me-1"></i>12% ce mois</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-car stat-icon"></i>
                <h3 class="h4">124</h3>
                <p class="mb-0">Voitures Actives</p>
                <div class="mt-2 text-info">
                    <small><i class="fas fa-minus me-1"></i>Stable</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-handshake stat-icon"></i>
                <h3 class="h4">75</h3>
                <p class="mb-0">Locations en cours</p>
                <div class="mt-2 text-warning">
                    <small><i class="fas fa-arrow-down me-1"></i>3% cette semaine</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-money-bill-wave stat-icon"></i>
                <h3 class="h4">45.2K €</h3>
                <p class="mb-0">Revenus du mois</p>
                <div class="mt-2 text-success">
                    <small><i class="fas fa-arrow-up me-1"></i>8% vs mois dernier</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions & Charts -->
    <div class="row">
        <!-- Quick Actions -->
        <div class="col-md-4">
            <h4 class="mb-3">Actions rapides</h4>
            <div class="quick-action">
                <i class="fas fa-user-plus"></i>
                <h5>Nouveau Client</h5>
                <a href="/client/add" class="btn btn-primary btn-sm">Ajouter</a>
            </div>
            <div class="quick-action">
                <i class="fas fa-car-side"></i>
                <h5>Nouvelle Location</h5>
                <a href="/location/add" class="btn btn-primary btn-sm">Créer</a>
            </div>
            <div class="quick-action">
                <i class="fas fa-file-alt"></i>
                <h5>Rapport journalier</h5>
                <a href="#" class="btn btn-primary btn-sm">Générer</a>
            </div>
        </div>

        <!-- Charts -->
        <div class="col-md-8">
            <div class="chart-container">
                <h4 class="mb-3">Statistiques des locations</h4>
                <canvas id="locationChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="recent-activity mt-4">
        <h4 class="mb-3">Activités récentes</h4>
        <div class="activity-item">
            <div class="d-flex align-items-center">
                <div class="activity-icon me-3">
                    <i class="fas fa-key"></i>
                </div>
                <div>
                    <h6 class="mb-1">Nouvelle location #12458</h6>
                    <p class="mb-0 text-muted">
                        <small>Il y a 5 minutes - par Admin</small>
                    </p>
                </div>
            </div>
        </div>
        <div class="activity-item">
            <div class="d-flex align-items-center">
                <div class="activity-icon me-3">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div>
                    <h6 class="mb-1">Nouveau client enregistré</h6>
                    <p class="mb-0 text-muted">
                        <small>Il y a 20 minutes - par Admin</small>
                    </p>
                </div>
            </div>
        </div>
        <div class="activity-item">
            <div class="d-flex align-items-center">
                <div class="activity-icon me-3">
                    <i class="fas fa-car"></i>
                </div>
                <div>
                    <h6 class="mb-1">Retour véhicule #A789</h6>
                    <p class="mb-0 text-muted">
                        <small>Il y a 1 heure - par Admin</small>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Chart Configuration
    const ctx = document.getElementById('locationChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin'],
            datasets: [{
                label: 'Locations mensuelles',
                data: [65, 59, 80, 81, 56, 85],
                fill: true,
                borderColor: '#3498db',
                backgroundColor: 'rgba(52, 152, 219, 0.1)',
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>