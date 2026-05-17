<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - Ride Nepal</title>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body class="split-body">
    
    <div class="split-wrapper">
        <!-- Left Hero Side -->
        <div class="hero-side">
            <div class="hero-img-container">
                <img src="${pageContext.request.contextPath}/images/car_2.png" alt="Sleek Dark Car">
            </div>
            
            <div class="hero-text-block">
                <a href="home" class="logo-link">
                    <h1>RIDE NEPAL</h1>
                </a>
                <p>Unlock access to the world's most sophisticated automotive fleet. Precision engineering meets seamless digital control.</p>
            </div>
        </div>

        <!-- Right Form Side -->
        <div class="form-side">
            <div class="form-container">
                
                <div class="verification-header">
                    <div class="header-titles">
                        <span class="subtext">IDENTITY VERIFICATION</span>
                        <h2>Create Account</h2>
                    </div>
                    <div class="step-indicator">
                        <span class="step-text">Step 01 / 02</span>
                        <div class="progress-bar">
                            <div class="progress-fill"></div>
                        </div>
                    </div>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-msg"><%= request.getAttribute("error") %></div>
                <% } %>

                <form action="register" method="post" class="auth-form">
                    
                    <div class="form-group-full">
                        <label for="fullName">FULL NAME</label>
                        <div class="input-wrapper">
                            <input type="text" id="fullName" name="fullName" required placeholder="e.g., Alexander Sterling">
                        </div>
                    </div>

                    <div class="form-group-full">
                        <label for="email">EMAIL ADDRESS</label>
                        <div class="input-wrapper">
                            <input type="email" id="email" name="email" required placeholder="Enter your email">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group-half">
                            <label for="phone">LICENSE NUMBER</label>
                            <div class="input-wrapper">
                                <input type="text" id="phone" name="phone" required placeholder="DL - 8829 - QX">
                            </div>
                        </div>

                        <div class="form-group-half">
                            <label for="password">PASSWORD</label>
                            <div class="input-wrapper">
                                <input type="password" id="password" name="password" required minlength="6" placeholder="Enter your password">
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-submit">
                        Sign Up
                    </button>
                </form>

                <div class="auth-switch">
                    Already a member? <a href="login">Sign In</a>
                </div>

                <div class="legal-disclaimer">
                    <p>BY PROCEEDING, YOU AGREE TO THE RIDE NEPAL TERMS OF SERVICE AND OUR MACHINE-LEARNING DATA PRIVACY PROTOCOLS.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Full Bleed Footer -->
    <footer class="split-footer">
        <div class="f-logo">RIDE NEPAL</div>
        <div class="f-links">
            <a href="#">PRIVACY POLICY</a>
            <a href="#">TERMS OF SERVICE</a>
            <a href="#">FLEET MANAGEMENT</a>
            <a href="#">CAREERS</a>
        </div>
        <p class="f-copy">&copy; 2024 RIDE NEPAL. ALL RIGHTS RESERVED.</p>
    </footer>

</body>
</html>