<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<!-- [Le head reste identique jusqu'à la navigation] -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoLoc - Location de Voitures</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
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

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 6rem 0;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1511919884226-fd3cad34687c?auto=format&fit=crop&q=80') center/cover;
            opacity: 0.2;
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        /* Feature Cards */
        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 1rem;
        }

        /* Footer */
        footer {
            background: var(--primary-color);
            color: white;
            padding: 3rem 0;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-section h5 {
            color: var(--accent-color);
            margin-bottom: 1.5rem;
        }

        .footer-links {
            list-style: none;
            padding: 0;
        }

        .footer-links li {
            margin-bottom: 0.5rem;
        }

        .footer-links a {
            color: #fff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--accent-color);
        }

        .social-links a {
            color: white;
            margin-right: 1rem;
            font-size: 1.5rem;
            transition: color 0.3s ease;
        }

        .social-links a:hover {
            color: var(--accent-color);
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-car-side"></i> AutoLoc
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-home"></i> Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-car"></i> Véhicules</a>
                </li>

            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container hero-content text-center">
        <h1 class="display-3 fw-bold mb-4">Louez la voiture de vos rêves</h1>
        <p class="lead mb-4">Des véhicules premium pour tous vos besoins de déplacement</p>
        <a href="#" class="btn btn-light btn-lg px-4">Voir nos véhicules</a>
    </div>
</section>

<!-- Features -->
<div class="container">
    <div class="row">
        <div class="col-md-4">
            <div class="feature-card text-center">
                <i class="fas fa-car-side feature-icon"></i>
                <h3>Large Choix</h3>
                <p>Une flotte diversifiée de véhicules pour tous vos besoins.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card text-center">
                <i class="fas fa-clock feature-icon"></i>
                <h3>Réservation Rapide</h3>
                <p>Réservez votre véhicule en quelques clics.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card text-center">
                <i class="fas fa-shield-alt feature-icon"></i>
                <h3>Service Premium</h3>
                <p>Assistance 24/7 et assurance tous risques incluse.</p>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="mt-5">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h5>À propos</h5>
                <p>AutoLoc, votre partenaire de confiance pour la location de véhicules depuis plus de 10 ans.</p>
            </div>
            <div class="footer-section">
                <h5>Liens Rapides</h5>
                <ul class="footer-links">
                    <li><a href="#">Nos véhicules</a></li>
                    <li><a href="#">Réservation</a></li>
                    <li><a href="#">Conditions</a></li>
                    <li><a href="#">FAQ</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h5>Contact</h5>
                <ul class="footer-links">
                    <li><i class="fas fa-phone"></i> +33 1 23 45 67 89</li>
                    <li><i class="fas fa-envelope"></i> contact@autoloc.fr</li>
                    <li><i class="fas fa-map-marker-alt"></i> 123 Rue de Paris, 75000 Paris</li>
                </ul>
            </div>
        </div>
        <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0">&copy; 2024 AutoLoc. Tous droits réservés.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>