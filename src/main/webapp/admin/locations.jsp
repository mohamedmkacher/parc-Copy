<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="fr">
<head>
    <title>Gestion des Locations - Admin</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">

    <style th:inline="css">
        /* Mêmes styles CSS qu'avant */
        .sidebar {
            min-height: 100vh;
            background: #343a40;
            color: white;
        }
        /* ... autres styles ... */
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar p-0">
            <div class="d-flex flex-column">
                <div class="p-3 text-center">
                    <h4>Admin Panel</h4>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link" th:href="@{/admin/dashboard}">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                    <a class="nav-link active" th:href="@{/location/list}">
                        <i class="fas fa-car me-2"></i> Locations
                    </a>
                    <a class="nav-link" th:href="@{/voitures}">
                        <i class="fas fa-car-side me-2"></i> Voitures
                    </a>
                    <a class="nav-link" th:href="@{/clients}">
                        <i class="fas fa-users me-2"></i> Clients
                    </a>
                    <a class="nav-link" th:href="@{/logout}">
                        <i class="fas fa-sign-out-alt me-2"></i> Déconnexion
                    </a>
                </nav>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 main-content">
            <!-- Titre et boutons -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-car me-2"></i>Gestion des Locations</h2>
                <div class="btn-group">
                    <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#filterModal">
                        <i class="fas fa-filter me-2"></i>Filtrer
                    </button>
                    <button class="btn btn-outline-success" onclick="exportToExcel()">
                        <i class="fas fa-file-excel me-2"></i>Exporter
                    </button>
                </div>
            </div>

            <!-- Alert Messages -->
            <div th:if="${message}" th:class="'alert alert-' + ${messageType} + ' alert-dismissible fade show'" role="alert">
                <span th:text="${message}"></span>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card stat-card bg-primary text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title">Total Locations</h6>
                                    <h2 class="mb-0" th:text="${totalLocations}">0</h2>
                                </div>
                                <i class="fas fa-car fa-2x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Autres cartes de statistiques similaires -->
            </div>

            <!-- Table des locations -->
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="locationsTable" class="table table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Client</th>
                                <th>Voiture</th>
                                <th>Date Début</th>
                                <th>Date Fin</th>
                                <th>Montant</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr th:each="location : ${locations}">
                                <td th:text="${location.id}">0</td>
                                <td>
                                    <div class="d-flex flex-column">
                                        <span th:text="${location.client.nom + ' ' + location.client.prenom}">Nom Client</span>
                                        <small class="text-muted" th:text="${location.client.tel}">Téléphone</small>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex flex-column">
                                        <span th:text="${location.voiture.marque + ' ' + location.voiture.modele}">Marque Modèle</span>
                                        <small class="text-muted" th:text="${location.voiture.immatriculation}">Immatriculation</small>
                                    </div>
                                </td>
                                <td th:text="${temporals.format(location.date_debut, 'dd/MM/yyyy')}">01/01/2024</td>
                                <td th:text="${temporals.format(location.date_fin, 'dd/MM/yyyy')}">02/01/2024</td>
                                <td th:text="${location.montant + ' €'}">0 €</td>
                                <td>
                                            <span th:class="'status-badge ' + ${location.statut == 'EN_ATTENTE' ? 'bg-warning text-dark' :
                                                                              location.statut == 'VALIDE' ? 'bg-success text-white' :
                                                                              location.statut == 'REFUSE' ? 'bg-danger text-white' :
                                                                              'bg-info text-white'}"
                                                  th:text="${location.statut == 'EN_ATTENTE' ? 'En attente' :
                                                           location.statut == 'VALIDE' ? 'Validée' :
                                                           location.statut == 'REFUSE' ? 'Refusée' :
                                                           'Terminée'}">Statut</span>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <form th:if="${location.statut == 'EN_ATTENTE'}" th:action="@{/location/validate}" method="post" class="d-inline">
                                            <input type="hidden" name="id" th:value="${location.id}">
                                            <button type="submit" class="btn btn-success btn-sm action-btn" title="Valider">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </form>
                                        <!-- Autres boutons d'action -->
                                        <a th:href="@{/location/details(id=${location.id})}"
                                           class="btn btn-primary btn-sm action-btn" title="Détails">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal de filtrage -->
<div class="modal fade" id="filterModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Filtrer les locations</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form th:action="@{/location/list}" method="get">
                <!-- Contenu du modal -->
            </form>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script th:inline="javascript">
    $(document).ready(function() {
        $('#locationsTable').DataTable({
            language: {
                url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/fr-FR.json'
            },
            order: [[0, 'desc']],
            pageLength: 10,
            responsive: true
        });
    });

    function exportToExcel() {
        alert('Fonctionnalité d\'export en cours de développement');
    }
</script>
</body>
</html>