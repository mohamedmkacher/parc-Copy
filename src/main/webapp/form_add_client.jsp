<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoLoc - Gestion Clients</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
</head>
<body>

<!-- Navigation -->
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

<!-- Main Content -->
<div class="container" style="margin-top: 6rem;">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Header -->
            <div class="page-header mb-4 animate-fade">
                <div class="container position-relative">
                    <div class="d-flex justify-content-between align-items-center">
                        <h1 class="h3 mb-0">
                            <i class="fa-solid fa-user-plus me-2"></i>
                            Ajouter un nouveau client
                        </h1>
                        <a href="/client" class="btn btn-light">
                            <i class="fas fa-arrow-left me-2"></i>Retour à la liste
                        </a>
                    </div>
                </div>
            </div>

            <!-- Form Card -->
            <div class="form-card animate-fade">
                <div class="card-body p-4">
                    <form action="/client/save" method="post" class="needs-validation" novalidate>
                        <div class="row g-3">
                            <!-- Identification -->
                            <div class="col-md-6">
                                <div class="form-floating position-relative">

                                    <input type="text" id="num_cin" class="form-control" placeholder="Entrez votre CIN"
                                           name="num_cin" required>
                                    <label for="num_cin"><i class="fa-solid fa-id-card form-icon"></i> Numéro CIN</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir un numéro CIN valide.
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating position-relative">
                                    <input type="text" id="num_permis" class="form-control"
                                           placeholder="Entrez votre numéro permis" name="num_permis" required>

                                    <label for="num_permis"><i class="fa-solid fa-id-card form-icon"></i> Numéro permis</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir un numéro de permis valide.
                                    </div>
                                </div>
                            </div>

                            <!-- Informations personnelles -->
                            <div class="col-md-6">
                                <div class="form-floating position-relative">

                                    <input type="text" id="nom" class="form-control" placeholder="Entrez votre nom"
                                           name="nom" required>
                                    <label for="nom"><i class="fa-solid fa-user form-icon"></i> Nom</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir un nom.
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating position-relative">

                                    <input type="text" id="prenom" class="form-control" placeholder="Entrez votre prénom"
                                           name="prenom" required>
                                    <label for="prenom"><i class="fa-solid fa-user form-icon"></i> Prénom</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir un prénom.
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating position-relative">

                                    <input type="number" id="age" class="form-control" placeholder="Entrez votre age"
                                           name="age" min="18" max="120" required>
                                    <label for="age"><i class="fa-solid fa-calendar form-icon"></i> Age</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir un âge valide (18-120).
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating position-relative">

                                    <input type="tel" id="tel" class="form-control" placeholder="Entrez votre téléphone"
                                           name="tel" pattern="[0-9]{8,}" required>
                                    <label for="tel"><i class="fa-solid fa-phone form-icon"></i> Téléphone</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir un numéro de téléphone valide.
                                    </div>
                                </div>
                            </div>

                            <!-- Contact -->
                            <div class="col-12">
                                <div class="form-floating position-relative">

                                    <input type="email" id="email" class="form-control"
                                           placeholder="Entrez votre adresse email" name="email" required>
                                    <label for="email"><i class="fas fa-envelope form-icon"></i> Adresse email</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir une adresse email valide.
                                    </div>
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="form-floating position-relative">

                                    <input type="text" id="adresse" class="form-control"
                                           placeholder="Entrez votre adresse" name="adresse" required>
                                    <label for="adresse"> <i class="fa-solid fa-location-dot form-icon"></i> Adresse</label>
                                    <div class="invalid-feedback">
                                        Veuillez saisir une adresse.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Buttons -->
                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <a href="/client" class="btn btn-light">
                                <i class="fas fa-times me-2"></i>Annuler
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Enregistrer
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h5>À propos</h5>
                <p>AutoLoc, votre partenaire de confiance pour la location de véhicules depuis plus de 10 ans.</p>
            </div>
            <div class="footer-section">
                <h5>Contact</h5>
                <ul class="list-unstyled">
                    <li><i class="fas fa-phone me-2"></i>+33 1 23 45 67 89</li>
                    <li><i class="fas fa-envelope me-2"></i>contact@autoloc.fr</li>
                    <li><i class="fas fa-map-marker-alt me-2"></i>123 Rue de Paris, 75000 Paris</li>
                </ul>
            </div>
            <div class="footer-section">
                <h5>Suivez-nous</h5>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
        </div>
        <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0">&copy; <%= new java.util.Date().getYear() + 1900 %> AutoLoc. Tous droits réservés.</p>
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
<script>
    // Form validation
    (function () {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>