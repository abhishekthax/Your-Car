<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 Internal Error - DriveLux</title>
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
            color: #ff4444;
            line-height: 1;
            margin-bottom: 1rem;
            text-shadow: 0 0 30px rgba(255, 68, 68, 0.4);
        }
        .error-message {
            font-size: 1.5rem;
            color: var(--text-muted);
            margin-bottom: 3rem;
            max-width: 600px;
        }
    </style>
</head>
<body>
    <div class="error-section">
        <div class="error-code">500</div>
        <h2 style="font-size: 3rem; margin-bottom: 1rem;">System Overload</h2>
        <p class="error-message">Our servers encountered an unexpected error. Please try again later or contact our support team.</p>
        <div style="display: flex; gap: 1rem;">
            <a href="${pageContext.request.contextPath}/home" class="btn-primary large">Return to Home</a>
            <a href="mailto:support@pulse.com" class="btn-secondary large">Contact Support</a>
        </div>
    </div>
</body>
</html>
