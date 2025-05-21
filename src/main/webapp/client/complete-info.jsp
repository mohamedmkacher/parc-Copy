<%@ page import="com.example.demo.entities.Client" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil | AutoLoc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --form-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .profile-header {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 2rem 2rem;
        }

        .form-card {
            background: white;
            border-radius: 1rem;
            box-shadow: var(--form-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .form-floating > .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-label.required::after {
            content: "*";
            color: #e74c3c;
            margin-left: 0.25rem;
        }

        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--form-shadow);
        }

        .input-group-text {
            background: transparent;
            border-left: none;
        }

        .form-control {
            border-right: none;
        }

        .form-control:focus {
            border-color: #3498db;
            box-shadow: none;
        }

        .alert {
            border-radius: 1rem;
            border: none;
        }

        .info-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<div class="profile-header text-center">
    <i class="fas fa-user-circle info-icon"></i>
    <h1 class="display-6">Complétez votre profil</h1>
    <p class="lead mb-0">Pour accéder à nos services de location</p>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="alert alert-info mb-4">
                <div class="d-flex align-items-center">
                    <i class="fas fa-info-circle fs-4 me-3"></i>
                    <div>
                        <h6 class="mb-0 fw-bold">Information importante</h6>
                        <p class="mb-0">Ces informations sont nécessaires pour la validation de votre location.</p>
                    </div>
                </div>
            </div>

            <div class="form-card">
                <form action="<%= request.getContextPath() %>/profil/update" method="post" class="needs-validation" novalidate>
                    <% session.setAttribute("id",((Client)session.getAttribute("client")).getId()); %>


                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text"
                                       class="form-control"
                                       id="nom"
                                       name="nom"
                                       placeholder="Nom"
                                       value="<%= request.getAttribute("nom") != null ? request.getAttribute("nom") : "" %>"
                                       required>
                                <label for="nom">
                                    <i class="fas fa-user me-2"></i>Nom
                                </label>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-2"></i>Veuillez saisir votre nom
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text"
                                       class="form-control"
                                       id="prenom"
                                       name="prenom"
                                       placeholder="Prénom"
                                       value="<%= request.getAttribute("prenom") != null ? request.getAttribute("prenom") : "" %>"
                                       required>
                                <label for="prenom">
                                    <i class="fas fa-user me-2"></i>Prénom
                                </label>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-2"></i>Veuillez saisir votre prénom
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text"
                                       class="form-control"
                                       id="numCin"
                                       name="numCin"
                                       placeholder="Numéro CIN"
                                       value="<%= request.getAttribute("numCin") != null ? request.getAttribute("numCin") : "" %>"
                                       pattern="[0-9]{8}"
                                       required>
                                <label for="numCin">
                                    <i class="fas fa-id-card me-2"></i>Numéro CIN
                                </label>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-2"></i>Veuillez saisir un numéro CIN valide (8 chiffres)
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text"
                                       class="form-control"
                                       id="numPermis"
                                       name="numPermis"
                                       placeholder="Numéro Permis"
                                       value="<%= request.getAttribute("numPermis") != null ? request.getAttribute("numPermis") : "" %>"
                                       required>
                                <label for="numPermis">
                                    <i class="fas fa-car me-2"></i>Numéro Permis
                                </label>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-2"></i>Veuillez saisir votre numéro de permis
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="number"
                                       class="form-control"
                                       id="age"
                                       name="age"
                                       placeholder="Âge"
                                       value="<%= request.getAttribute("age") != null ? request.getAttribute("age") : "" %>"
                                       min="18"
                                       required>
                                <label for="age">
                                    <i class="fas fa-birthday-cake me-2"></i>Âge
                                </label>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-2"></i>Vous devez avoir au moins 18 ans
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="tel"
                                       class="form-control"
                                       id="tel"
                                       name="tel"
                                       placeholder="Téléphone"
                                       value="<%= request.getAttribute("tel") != null ? request.getAttribute("tel") : "" %>"
                                       pattern="[0-9]{8}"
                                       required>
                                <label for="tel">
                                    <i class="fas fa-phone me-2"></i>Téléphone
                                </label>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-2"></i>Veuillez saisir un numéro valide
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="form-floating">
                                    <textarea class="form-control"
                                              id="adresse"
                                              name="adresse"
                                              placeholder="Adresse"
                                              style="height: 100px"
                                              required><%= request.getAttribute("adresse") != null ? request.getAttribute("adresse") : "" %></textarea>
                                <label for="adresse">
                                    <i class="fas fa-map-marker-alt me-2"></i>Adresse
                                </label>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-2"></i>Veuillez saisir votre adresse
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-grid gap-3 mt-4">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="fas fa-save me-2"></i>Enregistrer
                        </button>
                        <a href="<%= request.getContextPath() %>/location/add" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Retour
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')

        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
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