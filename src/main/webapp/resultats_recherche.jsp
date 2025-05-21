<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.entities.Voiture" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voitures Disponibles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .results-header {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            padding: 2rem 0;
            margin-bottom: 2rem;
            color: white;
        }
        .car-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .car-card:hover {
            transform: translateY(-5px);
        }
        .car-icon {
            font-size: 2rem;
            color: #3498db;
            margin-bottom: 1rem;
        }
        .car-details {
            color: #666;
            font-size: 0.9rem;
        }
        .btn-reserve {
            background: #3498db;
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 500;
            width: 100%;
        }
        .btn-reserve:hover {
            background: #2980b9;
        }
    </style>
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
<body><nav class="navbar navbar-expand-lg fixed-top mb-5">
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
    <div class="results-header mt-5">
        <div class="container mt-5">
            <h1 class="text-center mb-3">Voitures Disponibles</h1>
            <p class="text-center mb-0">
                Pour la période du <%= request.getAttribute("dateDebut") %> au <%= request.getAttribute("dateFin") %>
            </p>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <% 
            List<Voiture> voitures = (List<Voiture>) request.getAttribute("voitures");
                System.out.println(voitures);
            if (voitures != null && !voitures.isEmpty()) {
                for (Voiture voiture : voitures) {
            %>
                <div class="col-md-4">
                    <div class="car-card">
                        <div class="text-center">
                            <i class="fas fa-car car-icon"></i>
                            <h3 class="h4 mb-3"><%= voiture.getMarque() %> <%= voiture.getModele() %></h3>
                            <h4 class="h5 mb-3"><%= voiture.getPrixJour() %>/jour</h4>
                        </div>
                        <div class="car-details mb-4">
                            <p><i class="fas fa-hashtag me-2"></i>Matricule: <%= voiture.getMatricule() %></p>
                            <p><i class="fas fa-tachometer-alt me-2"></i>Kilométrage: <%= voiture.getKilometrage() %> km</p>
                            <p><i class="fas fa-warehouse me-2"></i>Parc: <%= voiture.getParc().getLibelle()+"-"+voiture.getParc().getLocalisation() %></p>
                        </div>
                        <form action="/location/save" method="post">
                            <% session.setAttribute("mnt",voiture.getPrixJour());%>


                            <input type="hidden" name="voitureId" value="<%= voiture.getCode_voiture() %>">
                            <input type="hidden" name="dateDebut" value="<%= request.getAttribute("dateDebut") %>">
                            <input type="hidden" name="dateFin" value="<%= request.getAttribute("dateFin") %>">
                            <button type="submit" class="btn btn-primary btn-reserve">
                                <i class="fas fa-check-circle me-2"></i>Réserver
                            </button>
                        </form>
                    </div>
                </div>
            <% 
                }
            } else {
            %>
                <div class="col-12">
                    <div class="alert alert-info text-center" role="alert">
                        <i class="fas fa-info-circle me-2"></i>
                        Aucune voiture disponible pour la période sélectionnée.
                    </div>
                </div>
            <% } %>
        </div>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/voitures" class="btn btn-outline-primary">
                <i class="fas fa-search me-2"></i>Nouvelle recherche
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 