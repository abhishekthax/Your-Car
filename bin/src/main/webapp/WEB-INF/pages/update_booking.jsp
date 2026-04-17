<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Booking | Nepal Rentals</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --blue:   #4f6ef7;
            --bg:     #0c0c0f;
            --surface:#13131a;
            --card:   #18181f;
            --border: rgba(255,255,255,0.07);
            --sub:    #a1a1aa;
        }
        body { background: var(--bg); color: #fff; font-family: 'Inter', sans-serif; padding: 40px; }
        .container { max-width: 1000px; margin: 0 auto; }
        .header { margin-bottom: 30px; display: flex; align-items: center; justify-content: space-between; }
        .title h1 { font-family: 'Outfit', sans-serif; font-size: 2rem; margin-bottom: 5px; }
        .title p { color: var(--sub); font-size: 0.9rem; }
        .back-btn { color: var(--sub); text-decoration: none; font-size: 0.9rem; display: flex; align-items: center; gap: 8px; }
        .back-btn:hover { color: #fff; }

        .current-selection {
            background: rgba(79, 110, 247, 0.05); border: 1px solid rgba(79, 110, 247, 0.2);
            border-radius: 16px; padding: 20px; margin-bottom: 40px;
            display: flex; align-items: center; gap: 20px;
        }
        .current-selection h3 { font-size: 0.8rem; color: var(--blue); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px; }
        .current-selection .car-name { font-size: 1.2rem; font-weight: 700; }

        .fleet-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .car-card {
            background: var(--card); border: 1px solid var(--border); border-radius: 20px;
            padding: 24px; transition: all 0.3s; position: relative; overflow: hidden;
        }
        .car-card:hover { border-color: var(--blue); transform: translateY(-5px); background: rgba(79, 110, 247, 0.03); }
        .car-img { width: 100%; height: 160px; object-fit: contain; margin-bottom: 20px; filter: drop-shadow(0 10px 20px rgba(0,0,0,0.5)); }
        .car-info h2 { font-family: 'Outfit', sans-serif; font-size: 1.3rem; margin-bottom: 5px; }
        .car-info p { color: var(--sub); font-size: 0.8rem; margin-bottom: 15px; }
        .car-footer { display: flex; justify-content: space-between; align-items: center; padding-top: 15px; border-top: 1px solid var(--border); }
        .price { font-weight: 800; font-size: 1.1rem; }
        .price span { font-size: 0.7rem; color: var(--sub); font-weight: 400; }
        
        .update-btn {
            background: var(--blue); color: #fff; border: none; padding: 10px 20px; border-radius: 10px;
            font-weight: 700; font-size: 0.85rem; cursor: pointer; transition: all 0.2s;
        }
        .update-btn:hover { background: #6366f1; }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <div class="title">
                <h1>Change Your Vehicle</h1>
                <p>Select a new car to update your booking <span>#VLT-${rental.id}-S</span></p>
            </div>
            <a href="dashboard" class="back-btn">← Back to Dashboard</a>
        </header>

        <div class="current-selection">
            <div style="font-size: 2rem;">🚗</div>
            <div>
                <h3>Currently Booked</h3>
                <div class="car-name">${rental.carInfo}</div>
            </div>
        </div>

        <div class="fleet-grid">
            <c:forEach var="car" items="${fleet}">
                <c:if test="${car.id != rental.carId}">
                    <div class="car-card">
                        <img src="${pageContext.request.contextPath}/images/car_${car.id}.png" 
                             onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'" 
                             class="car-img" alt="${car.make}">
                        <div class="car-info">
                            <h2>${car.make} ${car.model}</h2>
                            <p>${car.type} &nbsp;·&nbsp; ${car.transmission} &nbsp;·&nbsp; ${car.hp} HP</p>
                        </div>
                        <div class="car-footer">
                            <div class="price">NPR ${car.pricePerDay}<span>/day</span></div>
                            <form action="update" method="post">
                                <input type="hidden" name="rentalId" value="${rental.id}">
                                <input type="hidden" name="newCarId" value="${car.id}">
                                <button type="submit" class="update-btn" onclick="return confirm('Update your booking to ${car.make} ${car.model}?')">
                                    Switch Vehicle
                                </button>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</body>
</html>
