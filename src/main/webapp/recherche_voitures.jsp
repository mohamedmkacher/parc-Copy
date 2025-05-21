<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche de Voitures Disponibles</title>
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
    <style>
        .search-container {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            padding: 3rem 0;
            margin-bottom: 2rem;
            color: white;
        }
        .search-form {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: 500;
            color: #2c3e50;
        }
        .btn-search {
            background: #3498db;
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 500;
        }
        .btn-search:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
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
                    <a class="nav-link" href="/voitures"><i class="fas fa-car"></i> Véhicules</a>
                </li>  <li class="nav-item">
                <a class="nav-link" href="register.jsp"><i class="fa-solid fa-user-plus"></i></i> S'inscrire</a>
            </li> <li class="nav-item">
                <a class="nav-link" href="login.jsp"><i class="fa-solid fa-right-to-bracket"></i> Connexion</a>
            </li>

            </ul>
        </div>
    </div>
</nav>


<div class="search-container mt-5">
        <div class="container">
            <h1 class="text-center mb-4">Rechercher une Voiture Disponible</h1>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="search-form">
                        <% if (request.getAttribute("erreur") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("erreur") %>
                            </div>
                        <% } %>
                        <form action="${pageContext.request.contextPath}/voitures" method="post" class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="dateDebut" class="form-label">
                                        <i class="fas fa-calendar-alt me-2"></i>Date de début
                                    </label>
                                    <input type="date" class="form-control" id="dateDebut" name="dateDebut" 
                                           required min="<%= java.time.LocalDate.now() %>">
                                    <div class="invalid-feedback">
                                        Veuillez sélectionner une date de début valide
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="dateFin" class="form-label">
                                        <i class="fas fa-calendar-alt me-2"></i>Date de fin
                                    </label>
                                    <input type="date" class="form-control" id="dateFin" name="dateFin" required>
                                    <div class="invalid-feedback">
                                        Veuillez sélectionner une date de fin valide
                                    </div>
                                </div>
                            </div>
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-primary btn-search">
                                    <i class="fas fa-search me-2"></i>Rechercher
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validation du formulaire
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })

            // Validation des dates
            const dateDebut = document.getElementById('dateDebut');
            const dateFin = document.getElementById('dateFin');

            dateDebut.addEventListener('change', function() {
                dateFin.min = this.value;
                if (dateFin.value && dateFin.value < this.value) {
                    dateFin.value = this.value;
                }
            });
        })()
    </script>
</body>
</html> 