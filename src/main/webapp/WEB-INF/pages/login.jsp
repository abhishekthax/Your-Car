<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Your Car</title>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body class="split-body">
    <div class="split-layout">
        
        <!-- Left Hero Side -->
        <div class="hero-side">
            <div class="hero-img-container">
                <img src="${pageContext.request.contextPath}/images/car_hero.png" alt="Performance Car">
            </div>
            <div class="hero-content">
                <div class="brand">
                    <a href="home" class="logo-link">
                        <span class="logo-text">YOUR CAR</span>
                        <span class="logo-tag">PRECISION CONTROL</span>
                    </a>
                </div>
                
                <div class="hero-text-block">
                    <h1>Experience the<br><span class="zenith">Zenith</span> of<br>Performance.</h1>
                    <p>Access our exclusive fleet of precision-engineered vehicles. Your journey into high-performance automotive art begins here.</p>
                </div>

                <div class="hero-footer">
                    <p>&copy; 2024 YOUR CAR.</p>
                    <a href="#">PRIVACY POLICY</a>
                    <a href="#">TERMS OF SERVICE</a>
                </div>
            </div>
        </div>

        <!-- Right Form Side -->
        <div class="form-side">
            <div class="form-container">
                <div class="form-header">
                    <h2>Welcome Back</h2>
                    <p>Sign in to your member account.</p>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-msg"><%= request.getAttribute("error") %></div>
                <% } %>
                <% if ("loggedout".equals(request.getParameter("msg"))) { %>
                    <div class="info-msg" style="background: rgba(79, 110, 247, 0.1); color: #4f6ef7; padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 0.85rem; border: 1px solid rgba(79, 110, 247, 0.2); text-align: center;">
                        Successfully logged out. Please sign in again.
                    </div>
                <% } %>

                <div class="social-login">
                    <button class="btn btn-social">
                        <span class="icon google-g">G</span>
                        GOOGLE
                    </button>
                </div>

                <div class="divider">
                    <span>OR EMAIL</span>
                </div>

                <form action="login" method="post" class="auth-form">
                    <div class="form-group">
                        <label for="email">EMAIL ADDRESS</label>
                        <div class="input-wrapper">
                            <span class="icon-prefix">@</span>
                            <input type="email" id="email" name="email" required placeholder="driver@yourcar.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="label-row">
                            <label for="password">PASSWORD</label>
                            <a href="#" class="forgot-link">Forgot Access?</a>
                        </div>
                        <div class="input-wrapper">
                            <span class="icon-prefix">🔒</span>
                            <input type="password" id="password" name="password" required placeholder="••••••••">
                        </div>
                    </div>

                    <div class="form-options">
                        <label class="checkbox-label">
                            <input type="checkbox" name="remember">
                            <span class="checkmark"></span>
                            Remember this cockpit configuration
                        </label>
                    </div>

                    <button type="submit" class="btn btn-submit">
                        Sign In
                    </button>
                </form>

                <div class="auth-switch">
                    Don't have a garage yet? <a href="register">Create Account</a>
                </div>
                
                <div class="auth-switch" style="margin-top: 15px;">
                    <a href="#" onclick="document.getElementById('email').value='admin@gmail.com'; document.getElementById('password').value='admin123'; document.querySelector('.auth-form').submit(); return false;" style="color: var(--blue); font-size: 0.85rem;">Sign in as Admin</a>
                </div>
            </div>
            
            <button class="help-bubble">?</button>
        </div>
    </div>
</body>
</html>
