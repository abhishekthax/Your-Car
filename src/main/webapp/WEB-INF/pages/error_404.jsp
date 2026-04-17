<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 Not Found - DriveLux</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <style>
        .error-section {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 2rem;
        }
        .error-code {
            font-size: 8rem;
            font-family: 'Outfit', sans-serif;
            font-weight: 800;
            color: var(--primary);
            line-height: 1;
            margin-bottom: 1rem;
            text-shadow: 0 0 30px var(--primary-dim);
        }
        .error-message {
            font-size: 1.5rem;
            color: var(--text-muted);
            margin-bottom: 3rem;
        }
    </style>
</head>
<body>
    <div class="error-section">
        <div class="error-code">404</div>
        <h2 style="font-size: 3rem; margin-bottom: 1rem;">Out of Bounds</h2>
        <p class="error-message">The page you are looking for has been moved or doesn't exist.</p>
        <a href="${pageContext.request.contextPath}/home" class="btn-primary large">Return to Home</a>
    </div>
</body>
</html>
