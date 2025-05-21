<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.entities.Parc" %>
<%@ page import="com.example.demo.entities.Voiture" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier une Voiture | AutoLoc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --success-color: #2ecc71;
            --warning-color: #f1c40f;
            --danger-color: #e74c3c;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
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

        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 15px;
            position: relative;
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

        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .form-card, .car-card, .stats-card, .stat-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: none;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-card:hover, .car-card:hover, .stats-card:hover, .stat-card:hover {
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

        .form-section {
            border-bottom: 1px solid rgba(0,0,0,0.1);
            padding-bottom: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-section:last-child {
            border-bottom: none;
        }

        .form-label {
            font-weight: 500;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
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

        .form-floating {
            margin-bottom: 1.5rem;
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

        .input-group-text {
            border-radius: 10px 0 0 10px;
            border: none;
            background: rgba(52, 152, 219, 0.1);
            color: var(--accent-color);
        }

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

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
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

        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .table th {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            padding: 1rem;
        }

        .alert {
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: none;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from { transform: translateY(-100%); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

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

        @media (max-width: 768px) {
            .stat-card {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body class="bg-light">
<%
    List<Parc> parcs = (List<Parc>) request.getAttribute("parcs");
    Voiture voiture = (Voiture) request.getAttribute("voiture_to_update");
%>
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

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="page-header mb-4">
                <div class="container position-relative">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="h3 mb-0">
                                <i class="fas fa-car-side me-2"></i>
                                Mise à jour Véhicule
                            </h1>
                            <p class="mb-0 mt-2">Modifier les informations du vehicule</p>
                        </div>
                        <a href="/voiture" class="btn btn-light">
                            <i class="fas fa-arrow-left me-2"></i>Retour à la liste
                        </a>
                    </div>
                </div>
            </div>

            <div class="form-card">
                <div class="card-body p-4">
                    <form action="/voiture/update?id=<%=voiture.getCode_voiture()%>
" method="post" class="needs-validation" novalidate>
                        <!-- Informations principales -->
                        <div class="form-section">
                            <h5 class="mb-3">Informations principales</h5>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">

                                        <input type="text" class="form-control" id="matricule" name="matricule"
                                               placeholder="Matricule" required pattern="[A-Z0-9-]+" value="<%=voiture.getMatricule()%>"
                                        >
                                        <label for="matricule"> <i class="fas fa-hashtag form-icon"></i>Matricule</label>
                                        <div class="invalid-feedback">
                                            Veuillez saisir un matricule valide
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">

                                        <input type="text" class="form-control" id="marque" name="marque"
                                               placeholder="Marque" value="<%=voiture.getMarque()%>"
                                               required>
                                        <label for="marque"><i class="fas fa-trademark form-icon"></i>Marque</label>
                                        <div class="invalid-feedback">
                                            Veuillez saisir la marque
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">

                                        <input type="text" class="form-control" id="modele" name="modele"
                                               value="<%=voiture.getModele()%>"
                                               placeholder="Modèle" required>
                                        <label for="modele"><i class="fas fa-car form-icon"></i>Modèle</label>
                                        <div class="invalid-feedback">
                                            Veuillez saisir le modèle
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">

                                        <input type="number" class="form-control" id="kilometrage" name="kilometrage"
                                               value="<%=voiture.getKilometrage()%>"
                                               placeholder="Kilométrage" required min="0">
                                        <label for="kilometrage"><i class="fas fa-tachometer-alt form-icon"></i>Kilométrage</label>
                                        <div class="invalid-feedback">
                                            Veuillez saisir un kilométrage valide
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="number" step="0.01" class="form-control" id="prixJour" name="prixJour" value="<%=voiture.getPrixJour()%>" placeholder="Prix par jour" required min="0">
                                        <label for="prixJour"><i class="fas fa-euro-sign form-icon"></i>Prix par jour</label>
                                        <div class="invalid-feedback">
                                            Veuillez saisir le prix par jour
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Affectation -->
                        <div class="form-section">
                            <label for="parc" class="form-label">Parc d'affectation</label>
                            <div class="invalid-feedback">
                                Veuillez sélectionner un parc
                            </div>
                            <div class="mb-3 position-relative">
                                <i class="fas fa-warehouse form-icon"></i>
                                <select class="form-select form-control" id="parc1" name="parc" required>
                                    <option value="" selected disabled>Sélectionnez un parc</option>
                                    <%
                                        if(parcs != null) {
                                            for(Parc p : parcs) { %>
                                    <option value="<%=p.getNum_parc()%>"
                                            <%= p.getNum_parc() == voiture.getParc().getNum_parc() ? "selected" : "" %>>
                                        <%= p.getLibelle() %> - <%= p.getLocalisation() %>
                                    </option>

                                    <% }
                                    } %>
                                </select>

                            </div>
                        </div>


                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <a href="/voiture" class="btn btn-light">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    (() => {
        'use strict'

        // Select2 initialization
        $(document).ready(function() {
            $('#parc').select2({
                theme: 'bootstrap-5',
                placeholder: 'Sélectionnez un parc'
            });
        });

        // Form validation
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