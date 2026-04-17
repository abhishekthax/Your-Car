<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Detail | Nepal Rentals</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --blue: #3b82f6;
            --red: #ef4444;
            --green: #10b981;
            --bg: #0d0d10;
            --card: rgba(255,255,255,0.04);
            --border: rgba(255,255,255,0.08);
            --muted: #71717a;
            --sub: #a1a1aa;
        }

        body {
            background: var(--bg);
            color: #fff;
            font-family: 'Inter', sans-serif;
            display: flex;
            min-height: 100vh;
        }

        /* ── Sidebar ── */
        .sidebar {
            width: 240px;
            min-height: 100vh;
            background: rgba(0,0,0,0.6);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            padding: 32px 16px;
            flex-shrink: 0;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 48px;
            padding: 0 8px;
        }

        .brand-badge {
            width: 36px; height: 36px;
            background: var(--blue);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-weight: 800; font-size: 1rem;
        }

        .brand-info h3 {
            font-family: 'Outfit', sans-serif;
            font-size: 1rem;
            letter-spacing: 2px;
        }

        .brand-info span {
            font-size: 0.6rem;
            color: var(--sub);
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .nav { flex: 1; display: flex; flex-direction: column; gap: 4px; }

        .nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            border-radius: 12px;
            color: var(--sub);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.2s;
        }

        .nav a:hover { color: #fff; background: var(--card); }
        .nav a.active { color: #fff; background: var(--card); border: 1px solid var(--border); }
        .nav a .icon { font-size: 1rem; width: 20px; }

        .nav-divider { height: 1px; background: var(--border); margin: 12px 0; }

        .new-booking-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 14px;
            background: linear-gradient(135deg, #3b82f6, #6366f1);
            border-radius: 14px;
            color: #fff;
            font-weight: 700;
            text-decoration: none;
            font-size: 0.9rem;
            margin-bottom: 24px;
            transition: all 0.3s;
        }

        .new-booking-btn:hover { transform: translateY(-2px); filter: brightness(1.1); }

        /* ── Main ── */
        .main {
            flex: 1;
            padding: 32px 40px;
            overflow-y: auto;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .topbar-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .back-btn {
            width: 40px; height: 40px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            color: #fff;
            text-decoration: none;
            font-size: 1.1rem;
            transition: background 0.2s;
        }

        .back-btn:hover { background: rgba(255,255,255,0.08); }

        .page-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #fff;
        }

        .page-title span { color: var(--blue); }

        .topbar-right { display: flex; align-items: center; gap: 16px; }

        .icon-btn {
            width: 40px; height: 40px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            color: var(--sub);
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
        }

        /* ── Hero ── */
        .hero {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 24px;
            margin-bottom: 24px;
        }

        .hero-card {
            background: linear-gradient(135deg, rgba(59,130,246,0.08), rgba(99,102,241,0.05));
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 36px;
            position: relative;
            overflow: hidden;
            min-height: 340px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }

        .hero-car-img {
            position: absolute;
            right: -5%;
            top: 50%;
            transform: translateY(-55%);
            width: 65%;
            filter: drop-shadow(0 20px 60px rgba(0,0,0,0.6));
            pointer-events: none;
        }

        .hero-badge {
            display: inline-block;
            background: rgba(59,130,246,0.15);
            color: var(--blue);
            font-size: 0.65rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            padding: 6px 14px;
            border-radius: 100px;
            border: 1px solid rgba(59,130,246,0.3);
            margin-bottom: 12px;
            width: fit-content;
        }

        .hero-car-name {
            font-family: 'Outfit', sans-serif;
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1;
            margin-bottom: 28px;
            position: relative;
            z-index: 1;
        }

        .hero-specs {
            display: flex;
            gap: 36px;
            position: relative;
            z-index: 1;
        }

        .spec-item label {
            display: block;
            font-size: 0.6rem;
            color: var(--sub);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 4px;
        }

        .spec-item .spec-val {
            font-family: 'Outfit', sans-serif;
            font-size: 1.4rem;
            font-weight: 700;
        }

        .spec-item .spec-val small {
            font-size: 0.7rem;
            font-weight: 500;
            color: var(--sub);
        }

        /* Reservation Details Card */
        .res-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 28px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .res-card-title {
            font-size: 0.65rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: var(--sub);
            margin-bottom: 4px;
        }

        .res-row {
            display: flex;
            align-items: center;
            gap: 14px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border);
        }

        .res-row:last-of-type { border-bottom: none; padding-bottom: 0; }

        .res-icon {
            width: 36px; height: 36px;
            background: rgba(255,255,255,0.05);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .res-key {
            font-size: 0.8rem;
            color: var(--sub);
            margin-bottom: 2px;
        }

        .res-val {
            font-size: 1rem;
            font-weight: 700;
        }

        .res-val.green { color: var(--green); }

        .status-section { margin-top: 8px; }

        .status-label {
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
            margin-bottom: 8px;
        }

        .status-label .confirmed {
            color: var(--blue);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .status-label .confirmed::before {
            content: '';
            width: 8px; height: 8px;
            background: var(--blue);
            border-radius: 50%;
            display: inline-block;
        }

        .progress-bar {
            height: 6px;
            background: rgba(255,255,255,0.08);
            border-radius: 100px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: var(--blue);
            border-radius: 100px;
            width: 72%;
        }

        .pickup-note {
            font-size: 0.65rem;
            color: var(--muted);
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 8px;
        }

        /* ── Info Cards ── */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 20px;
            margin-bottom: 24px;
        }

        .info-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 24px;
        }

        .info-card-label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.65rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: var(--blue);
            margin-bottom: 20px;
        }

        .pickup-title {
            font-family: 'Outfit', sans-serif;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .pickup-addr {
            font-size: 0.82rem;
            color: var(--sub);
            line-height: 1.6;
            margin-bottom: 16px;
        }

        .map-link {
            color: var(--blue);
            text-decoration: none;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .period-dates {
            display: flex;
            justify-content: space-between;
            margin-bottom: 16px;
        }

        .date-col label {
            display: block;
            font-size: 0.6rem;
            color: var(--sub);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 6px;
        }

        .date-col .date-val {
            font-family: 'Outfit', sans-serif;
            font-size: 1.6rem;
            font-weight: 700;
            line-height: 1;
        }

        .date-col .time-val {
            font-size: 0.85rem;
            color: var(--sub);
            margin-top: 4px;
        }

        .duration-badge {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.05);
            border-radius: 12px;
            padding: 10px 14px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .config-grid {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .config-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
        }

        .config-key { color: var(--sub); }
        .config-val { font-weight: 600; display: flex; align-items: center; gap: 6px; }
        .config-dot { width: 10px; height: 10px; border-radius: 50%; }

        /* ── Action Bar ── */
        .action-bar {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 20px 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .lock-info { display: flex; flex-direction: column; gap: 4px; }

        .lock-label {
            font-size: 0.6rem;
            color: var(--muted);
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .lock-status {
            color: var(--blue);
            font-size: 0.8rem;
            font-weight: 600;
        }

        .action-btns { display: flex; gap: 12px; }

        .btn-update {
            display: flex; align-items: center; gap: 8px;
            padding: 14px 24px;
            background: rgba(255,255,255,0.07);
            border: 1px solid var(--border);
            border-radius: 12px;
            color: #fff;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            transition: all 0.2s;
        }

        .btn-update:hover { background: rgba(255,255,255,0.12); }

        .btn-cancel {
            display: flex; align-items: center; gap: 8px;
            padding: 14px 24px;
            background: var(--red);
            border: none;
            border-radius: 12px;
            color: #fff;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            transition: all 0.2s;
        }

        .btn-cancel:hover { background: #dc2626; }

        footer.page-footer {
            text-align: center;
            padding: 40px 0 20px;
            color: var(--muted);
            font-size: 0.7rem;
            letter-spacing: 1px;
        }

        footer.page-footer a {
            color: var(--muted);
            text-decoration: none;
            margin: 0 12px;
        }

        footer.page-footer a:hover { color: var(--sub); }
    </style>
</head>
<body>

    <%-- ════════════════ SIDEBAR ════════════════ --%>
    <aside class="sidebar">
        <div class="brand">
            <div class="brand-badge">V</div>
            <div class="brand-info">
                <h3>YOUR CAR</h3>
                <span>Precision Fleet</span>
            </div>
        </div>

        <nav class="nav">
            <a href="${pageContext.request.contextPath}/home" class="nav-item">
                <span class="icon">🚘</span> Fleet
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item active">
                <span class="icon">📁</span> Bookings
            </a>
            <a href="#" class="nav-item">
                <span class="icon">👥</span> Customers
            </a>
            <a href="#" class="nav-item">
                <span class="icon">📊</span> Analytics
            </a>
            <a href="#" class="nav-item">
                <span class="icon">🔧</span> Maintenance
            </a>

            <div class="nav-divider"></div>

            <a href="#" class="nav-item">
                <span class="icon">❓</span> Support
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                <span class="icon">🚪</span> Logout
            </a>
        </nav>

        <a href="${pageContext.request.contextPath}/home#booking" class="new-booking-btn">
            + New Booking
        </a>
    </aside>

    <%-- ════════════════ MAIN ════════════════ --%>
    <main class="main">

        <%-- Guard: if no rental or car, show a clean error instead of 500 --%>
        <c:if test="${empty rental or empty car}">
            <div style="display:flex;flex-direction:column;align-items:center;justify-content:center;height:80vh;gap:16px;color:#71717a;">
                <span style="font-size:4rem;">🚫</span>
                <h2 style="color:#fff;font-family:'Outfit',sans-serif;">Booking Not Found</h2>
                <p>This reservation doesn't exist or doesn't belong to your account.</p>
                <a href="${pageContext.request.contextPath}/dashboard" style="background:var(--blue,#3b82f6);color:#fff;padding:12px 28px;border-radius:12px;text-decoration:none;font-weight:600;margin-top:8px;">← Back to Dashboard</a>
            </div>
        </c:if>

        <c:if test="${not empty rental and not empty car}">

        <%-- Top Bar --%>
        <div class="topbar">
            <div class="topbar-left">
                <a href="${pageContext.request.contextPath}/dashboard" class="back-btn">←</a>
                <div class="page-title">
                    Booking Detail: <span>#VLT-${rental.id}-${rental.carId}</span>
                </div>
            </div>
            <div class="topbar-right">
                <a href="#" class="icon-btn">🔍</a>
                <a href="#" class="icon-btn">⚙️</a>
                <a href="${pageContext.request.contextPath}/dashboard" class="icon-btn">👤</a>
            </div>
        </div>

        <%-- Hero Row --%>
        <div class="hero">
            <%-- Left: Car Hero --%>
            <div class="hero-card">
                <img
                    src="${pageContext.request.contextPath}/images/car_${rental.carId}.png"
                    onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'"
                    class="hero-car-img"
                    alt="${car.make} ${car.model}">

                <div class="hero-badge">Active Reservation</div>
                <h1 class="hero-car-name">${car.make} ${car.model}</h1>

                <div class="hero-specs">
                    <div class="spec-item">
                        <label>Acceleration</label>
                        <div class="spec-val">
                            <c:choose>
                                <c:when test="${car.accel060 != null and car.accel060 != 'N/A' and car.accel060 != ''}">
                                    ${car.accel060}
                                </c:when>
                                <c:otherwise>3.6s</c:otherwise>
                            </c:choose>
                            <small>&nbsp;0-60</small>
                        </div>
                    </div>
                    <div class="spec-item">
                        <label>Max Power</label>
                        <div class="spec-val">
                            <c:choose>
                                <c:when test="${car.hp > 0}">${car.hp}</c:when>
                                <c:otherwise>500</c:otherwise>
                            </c:choose>
                            <small>&nbsp;HP</small>
                        </div>
                    </div>
                    <div class="spec-item">
                        <label>Configuration</label>
                        <div class="spec-val">${car.type}</div>
                    </div>
                </div>
            </div>

            <%-- Right: Reservation Details --%>
            <div class="res-card">
                <div class="res-card-title">Reservation Details</div>

                <div class="res-row">
                    <div class="res-icon">🔖</div>
                    <div>
                        <div class="res-key">Booking ID</div>
                        <div class="res-val">VLT-${rental.id}-S</div>
                    </div>
                </div>

                <div class="res-row">
                    <div class="res-icon">💳</div>
                    <div>
                        <div class="res-key">Total Value</div>
                        <div class="res-val">NPR ${rental.totalCost}</div>
                    </div>
                </div>

                <div class="res-row">
                    <div class="res-icon">🛡️</div>
                    <div>
                        <div class="res-key">Insurance</div>
                        <div class="res-val green">Platinum Plus</div>
                    </div>
                </div>

                <div class="status-section">
                    <div class="status-label">
                        <span>Status</span>
                        <span class="confirmed">Confirmed</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill"></div>
                    </div>
                    <div class="pickup-note">Ready for pickup in 2 days</div>
                </div>
            </div>
        </div>

        <%-- Info Cards Row --%>
        <div class="info-grid">
            <%-- Pickup Point --%>
            <div class="info-card">
                <div class="info-card-label">📍 Pickup Point</div>
                <div class="pickup-title">City Executive Lounge</div>
                <div class="pickup-addr">
                    42 Executive Way, Private Hangar 7B<br>
                    Miami International Airport, FL
                </div>
                <a href="#" class="map-link">View on Map ↗</a>
            </div>

            <%-- Rental Period --%>
            <div class="info-card">
                <div class="info-card-label">⏱ Rental Period</div>
                <div class="period-dates">
                    <div class="date-col">
                        <label>Pick Up</label>
                        <div class="date-val">${rental.startDate}</div>
                        <div class="time-val">09:00</div>
                    </div>
                    <div style="color:#71717a;padding-top:20px;">→</div>
                    <div class="date-col">
                        <label>Drop Off</label>
                        <div class="date-val">${rental.endDate}</div>
                        <div class="time-val">18:00</div>
                    </div>
                </div>
                <div class="duration-badge">
                    📅&nbsp; 48 Hour Duration &nbsp;·&nbsp; Unlimited Mileage Included
                </div>
            </div>

            <%-- Configuration --%>
            <div class="info-card">
                <div class="info-card-label">⚙️ Configuration</div>
                <div class="config-grid">
                    <div class="config-row">
                        <span class="config-key">Make</span>
                        <span class="config-val">${car.make}</span>
                    </div>
                    <div class="config-row">
                        <span class="config-key">Model</span>
                        <span class="config-val">${car.model}</span>
                    </div>
                    <div class="config-row">
                        <span class="config-key">Type</span>
                        <span class="config-val">${car.type}</span>
                    </div>
                    <div class="config-row">
                        <span class="config-key">Transmission</span>
                        <span class="config-val">${car.transmission}</span>
                    </div>
                    <div class="config-row">
                        <span class="config-key">Status</span>
                        <span class="config-val" style="color:#ef4444;">${rental.status}</span>
                    </div>
                </div>
            </div>
        </div>

        <%-- Action Bar --%>
        <div class="action-bar">
            <div class="lock-info">
                <div class="lock-label">Reservation Lock</div>
                <div class="lock-status">🔒 Secure Transaction Active</div>
            </div>
            <div class="action-btns">
                <button class="btn-update" onclick="alert('Update feature coming soon!')">
                    📋 Update Booking
                </button>
                <form action="${pageContext.request.contextPath}/cancel" method="post" style="margin:0;"
                      onsubmit="return confirm('Are you sure you want to cancel this reservation?');">
                    <input type="hidden" name="rentalId" value="${rental.id}">
                    <button type="submit" class="btn-cancel">
                        ✕ Cancel Reservation
                    </button>
                </form>
            </div>
        </div>

        <footer class="page-footer">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Fleet Guidelines</a>
            <br><br>
            © 2024 Vehicle Rent in Nepal. All Rights Reserved.
        </footer>

        </c:if>
    </main>
</body>
</html>
