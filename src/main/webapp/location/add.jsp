<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvelle Location</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .car-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .car-card.selected {
            border-color: #0d6efd;
            background-color: #f8f9fa;
        }
        .car-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
        }
        .price-tag {
            font-size: 1.2rem;
            color: #198754;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2 class="text-center mb-4">
                <i class="fas fa-car"></i> Nouvelle Location
            </h2>

            <form action="${pageContext.request.contextPath}/location/save" method="post" class="needs-validation" novalidate>
                <div class="mb-4">
                    <h4 class="mb-3">1. Choisir une voiture</h4>
                    <div class="row" id="carList">
                        <c:forEach items="${voitures}" var="voiture">
                            <div class="col-md-6 mb-3">
                                <div class="car-card" data-id="${voiture.id}" data-prix="${voiture.prixJour}">
                                    <img src="${voiture.image}" alt="${voiture.marque} ${voiture.modele}" class="car-image mb-3">
                                    <h5>${voiture.marque} ${voiture.modele}</h5>
                                    <p class="text-muted">
                                        <i class="fas fa-cog"></i> ${voiture.transmission}<br>
                                        <i class="fas fa-gas-pump"></i> ${voiture.carburant}<br>
                                        <i class="fas fa-car"></i> ${voiture.categorie}
                                    </p>
                                    <p class="price-tag">
                                        <i class="fas fa-tag"></i> ${voiture.prixJour} € / jour
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <input type="hidden" name="voitureId" id="voitureId" required>
                    <div class="invalid-feedback">Veuillez sélectionner une voiture</div>
                </div>

                <div class="mb-4">
                    <h4 class="mb-3">2. Choisir les dates</h4>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="dateDebut" class="form-label">Date de début</label>
                            <input type="date" class="form-control" id="dateDebut" name="dateDebut" 
                                   min="${minDate}" required>
                            <div class="invalid-feedback">Veuillez choisir une date de début</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="dateFin" class="form-label">Date de fin</label>
                            <input type="date" class="form-control" id="dateFin" name="dateFin" 
                                   min="${minDate}" required>
                            <div class="invalid-feedback">Veuillez choisir une date de fin</div>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <h4 class="mb-3">3. Récapitulatif</h4>
                    <div class="card">
                        <div class="card-body">
                            <div id="recapVoiture" class="mb-2">
                                <strong>Voiture sélectionnée :</strong> <span id="recapVoitureNom">-</span>
                            </div>
                            <div id="recapDates" class="mb-2">
                                <strong>Période :</strong> <span id="recapDatesPeriode">-</span>
                            </div>
                            <div id="recapMontant" class="mb-2">
                                <strong>Montant total :</strong> <span id="recapMontantTotal" class="price-tag">-</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-check"></i> Confirmer la location
                    </button>
                    <a href="${pageContext.request.contextPath}/location/list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à mes locations
                    </a>
                </div>
            </form>
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
        })()

        // Gestion de la sélection des voitures
        document.querySelectorAll('.car-card').forEach(card => {
            card.addEventListener('click', function() {
                // Désélectionner toutes les cartes
                document.querySelectorAll('.car-card').forEach(c => c.classList.remove('selected'));
                // Sélectionner la carte cliquée
                this.classList.add('selected');
                // Mettre à jour l'input hidden
                document.getElementById('voitureId').value = this.dataset.id;
                // Mettre à jour le récapitulatif
                updateRecap();
            });
        });

        // Gestion des dates
        document.getElementById('dateDebut').addEventListener('change', updateRecap);
        document.getElementById('dateFin').addEventListener('change', updateRecap);

        function updateRecap() {
            const selectedCar = document.querySelector('.car-card.selected');
            const dateDebut = document.getElementById('dateDebut').value;
            const dateFin = document.getElementById('dateFin').value;

            // Mise à jour du récapitulatif voiture
            if (selectedCar) {
                const carName = selectedCar.querySelector('h5').textContent;
                document.getElementById('recapVoitureNom').textContent = carName;
            }

            // Mise à jour du récapitulatif dates
            if (dateDebut && dateFin) {
                document.getElementById('recapDatesPeriode').textContent = 
                    `${formatDate(dateDebut)} au ${formatDate(dateFin)}`;
            }

            // Calcul et mise à jour du montant
            if (selectedCar && dateDebut && dateFin) {
                const prixJour = parseFloat(selectedCar.dataset.prix);
                const jours = calculateDays(dateDebut, dateFin);
                const montant = prixJour * jours;
                document.getElementById('recapMontantTotal').textContent = 
                    `${montant.toFixed(2)} € (${jours} jours)`;
            }
        }

        function formatDate(dateStr) {
            const date = new Date(dateStr);
            return date.toLocaleDateString('fr-FR', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric'
            });
        }

        function calculateDays(dateDebut, dateFin) {
            const debut = new Date(dateDebut);
            const fin = new Date(dateFin);
            const diffTime = Math.abs(fin - debut);
            return Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
        }
    </script>
</body>
</html> 