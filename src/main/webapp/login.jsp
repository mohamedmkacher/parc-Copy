<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AutoLoc - Connexion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --light-color: #ecf0f1;
            --text-color: #2c3e50;
            --error-color: #e74c3c;
        }

        body {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            backdrop-filter: blur(10px);
            transform: translateY(0);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
        }

        .login-header {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            padding: 2.5rem 2rem;
            color: white;
            text-align: center;
            position: relative;
        }

        .login-header::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            border-top: 20px solid var(--accent-color);
            border-left: 20px solid transparent;
            border-right: 20px solid transparent;
        }

        .brand-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            display: inline-block;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .login-body {
            padding: 3rem 2rem 2rem;
        }

        .form-floating {
            margin-bottom: 1.5rem;
        }

        .form-control {
            border-radius: 12px;
            border: 2px solid rgba(0, 0, 0, 0.1);
            padding: 1rem 1rem 1rem 3rem;
            height: 3.5rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
        }

        .form-label {
            padding-left: 2.5rem;
            color: var(--text-color);
        }

        .form-icon {
            position: absolute;
            left: 1.2rem;
            top: 1.2rem;
            color: var(--primary-color);
            transition: all 0.3s ease;
            z-index: 2;
        }

        .form-floating:focus-within .form-icon {
            color: var(--accent-color);
        }

        .btn {
            border-radius: 12px;
            padding: 0.8rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
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
            background: var(--light-color);
            border: none;
        }

        .btn-light:hover {
            background: #dde4e6;
            transform: translateY(-2px);
        }

        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            border: none;
            color: var(--error-color);
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }

        .invalid-feedback {
            font-size: 0.875rem;
            color: var(--error-color);
            margin-top: 0.5rem;
        }

        @media (max-width: 576px) {
            .login-container {
                margin: 1rem;
                border-radius: 16px;
            }

            .login-header {
                padding: 2rem 1rem;
            }

            .login-body {
                padding: 2rem 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="login-container">
                <div class="login-header">
                    <i class="fas fa-car-side brand-icon"></i>
                    <h2 class="h3 mb-2">AutoLoc</h2>
                    <p class="mb-0">Accédez à votre espace personnel</p>
                </div>
                <div class="login-body">
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/auth/login" method="post" class="needs-validation" novalidate>
                        <div class="form-floating position-relative">

                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="Nom d'utilisateur" required autofocus>
                            <label for="username">Nom d'utilisateur</label>
                            <div class="invalid-feedback">
                                Veuillez saisir votre nom d'utilisateur
                            </div>
                        </div>

                        <div class="form-floating position-relative">

                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Mot de passe" required>
                            <label for="password">Mot de passe</label>
                            <div class="invalid-feedback">
                                Veuillez saisir votre mot de passe
                            </div>
                        </div>

                        <div class="d-grid gap-3 mt-4">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                            </button>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-light">
                                <i class="fas fa-home me-2"></i>Retour à l'accueil
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
    (function() {
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