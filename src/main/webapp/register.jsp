<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription | AutoLoc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #2c3e50, #3498db);
            --box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            --transition: all 0.3s ease;
        }

        body {
            min-height: 100vh;
            background: #f8f9fa;
            display: flex;
            align-items: center;
        }

        .auth-card {
            background: white;
            border-radius: 1rem;
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }

        .auth-header {
            background: var(--primary-gradient);
            padding: 2rem;
            color: white;
            text-align: center;
        }

        .auth-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .form-floating > .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .input-group-text {
            background: transparent;
        }

        .password-toggle {
            cursor: pointer;
            transition: var(--transition);
        }

        .password-toggle:hover {
            color: #3498db;
        }

        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            transition: var(--transition);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--box-shadow);
        }

        .alert {
            border: none;
            border-radius: 0.5rem;
        }

        .password-strength {
            background: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
        }

        .requirement {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 0.25rem;
        }

        .requirement i {
            width: 16px;
            margin-right: 0.5rem;
        }

        .requirement.valid {
            color: #198754;
        }

        .progress-bar {
            transition: width 0.3s ease;
        }

        .progress-bar.weak { background-color: #dc3545; }
        .progress-bar.medium { background-color: #ffc107; }
        .progress-bar.strong { background-color: #198754; }

        .password-feedback {
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6 col-xl-5">
            <div class="auth-card">
                <div class="auth-header">
                    <i class="fas fa-user-plus auth-icon"></i>
                    <h1 class="h3">Créer un compte</h1>
                    <p class="mb-0">Rejoignez AutoLoc dès aujourd'hui</p>
                </div>

                <div class="p-4 p-md-5">
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <%= request.getAttribute("error") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= request.getAttribute("success") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/auth/register" method="post" class="needs-validation" novalidate>
                        <div class="form-floating mb-3">
                            <input type="text"
                                   class="form-control"
                                   id="username"
                                   name="username"
                                   placeholder="Nom d'utilisateur"
                                   required
                                   minlength="3"
                                   maxlength="50"
                                   pattern="[a-zA-Z0-9_]+">
                            <label for="username">
                                <i class="fas fa-user me-2"></i>Nom d'utilisateur
                            </label>
                            <div class="invalid-feedback">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                Le nom d'utilisateur doit contenir entre 3 et 50 caractères
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="email"
                                   class="form-control"
                                   id="email"
                                   name="email"
                                   placeholder="Email"
                                   required>
                            <label for="email">
                                <i class="fas fa-envelope me-2"></i>Email
                            </label>
                            <div class="invalid-feedback">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                Veuillez entrer une adresse email valide
                            </div>
                        </div>

                        <div class="form-floating mb-3">
                            <div class="input-group">
                                <input type="password"
                                       class="form-control"
                                       id="password"
                                       name="password"
                                       placeholder="Mot de passe"
                                       required
                                       pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                                       onkeyup="checkPasswordStrength(this.value)">
                                <span class="input-group-text password-toggle" onclick="togglePassword('password')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                            </div>

                            <div class="password-strength mt-2" id="passwordStrength">
                                <div class="progress" style="height: 5px;">
                                    <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                                </div>
                                <div class="requirements mt-2">
                                    <p class="text-muted small mb-1">Le mot de passe doit contenir :</p>
                                    <div class="requirement" id="length">
                                        <i class="fas fa-circle-xmark text-danger"></i> 8 caractères minimum
                                    </div>
                                    <div class="requirement" id="uppercase">
                                        <i class="fas fa-circle-xmark text-danger"></i> Une majuscule
                                    </div>
                                    <div class="requirement" id="lowercase">
                                        <i class="fas fa-circle-xmark text-danger"></i> Une minuscule
                                    </div>
                                    <div class="requirement" id="number">
                                        <i class="fas fa-circle-xmark text-danger"></i> Un chiffre
                                    </div>
                                    <div class="requirement" id="special">
                                        <i class="fas fa-circle-xmark text-danger"></i> Un caractère spécial
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-floating mb-4">
                            <div class="input-group">
                                <input type="password"
                                       class="form-control"
                                       id="confirmPassword"
                                       placeholder="Confirmer le mot de passe"
                                       required>
                                <span class="input-group-text password-toggle" onclick="togglePassword('confirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </span>
                            </div>

                            <div class="invalid-feedback">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                Les mots de passe ne correspondent pas
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-user-plus me-2"></i>S'inscrire
                            </button>
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light">
                                <i class="fas fa-sign-in-alt me-2"></i>Déjà inscrit ? Connectez-vous
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function checkPasswordStrength(password) {
        const criteria = {
            length: password.length >= 8,
            uppercase: /[A-Z]/.test(password),
            lowercase: /[a-z]/.test(password),
            number: /\d/.test(password),
            special: /[@$!%*?&]/.test(password)
        };

        Object.keys(criteria).forEach(criterion => {
            const element = document.getElementById(criterion);
            const icon = element.querySelector('i');

            if (criteria[criterion]) {
                element.classList.add('valid');
                icon.classList.replace('fa-circle-xmark', 'fa-circle-check');
                icon.classList.replace('text-danger', 'text-success');
            } else {
                element.classList.remove('valid');
                icon.classList.replace('fa-circle-check', 'fa-circle-xmark');
                icon.classList.replace('text-success', 'text-danger');
            }
        });

        const strength = Object.values(criteria).filter(Boolean).length;
        const progressBar = document.querySelector('.progress-bar');

        let strengthClass = '';
        let strengthWidth = '';

        switch(strength) {
            case 0:
            case 1:
                strengthClass = 'weak';
                strengthWidth = '20%';
                break;
            case 2:
            case 3:
                strengthClass = 'medium';
                strengthWidth = '60%';
                break;
            case 4:
            case 5:
                strengthClass = 'strong';
                strengthWidth = '100%';
                break;
        }

        progressBar.className = 'progress-bar ' + strengthClass;
        progressBar.style.width = strengthWidth;

        const passwordInput = document.getElementById('password');
        if (Object.values(criteria).every(Boolean)) {
            passwordInput.setCustomValidity('');
        } else {
            passwordInput.setCustomValidity('Le mot de passe ne répond pas aux critères requis');
        }
    }

    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        const icon = input.nextElementSibling.querySelector('i');

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        confirmPassword.addEventListener('input', function() {
            if (this.value !== password.value) {
                this.setCustomValidity('Les mots de passe ne correspondent pas');
            } else {
                this.setCustomValidity('');
            }
        });

        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Les mots de passe ne correspondent pas');
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        });
    });
</script>
</body>
</html>