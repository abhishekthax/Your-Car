<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Fleet Control</title>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #0b0b0e;
            --sidebar-color: #121216;
            --card-bg: #18181c;
            --text-light: #f5f5f7;
            --text-dim: #8b8b9c;
            --accent-blue: #4f6ef7;
            --border-color: #27272e;
            --badge-purple: #8b4ff7;
            --badge-red: #f74f4f;
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-light);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* Sidebar View */
        .sidebar {
            width: 260px;
            background-color: var(--sidebar-color);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            padding: 24px 0;
        }

        .nav-list {
            list-style: none;
            margin-top: 30px;
            flex: 1;
        }

        .nav-item {
            padding: 14px 24px;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-dim);
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            cursor: pointer;
            text-transform: uppercase;
            transition: 0.3s ease;
            text-decoration: none;
        }

        .nav-item .icon {
            margin-right: 14px;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .nav-item:hover {
            color: var(--text-light);
        }

        .nav-item.active {
            color: var(--text-light);
            background: linear-gradient(90deg, rgba(79, 110, 247, 0.15) 0%, transparent 100%);
            border-right: 4px solid var(--accent-blue);
            border-radius: 0 8px 8px 0;
        }

        .sidebar-bottom {
            padding: 0 24px;
        }

        .btn-new-rental {
            width: 100%;
            background-color: var(--accent-blue);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .action-link {
            color: var(--text-dim);
            text-decoration: none;
            font-size: 0.8rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .action-link:hover { color: var(--text-light); }

        /* Main Content View */
        .main-content {
            flex: 1;
            padding: 40px 60px;
            overflow-y: auto;
        }

        .top-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 40px;
        }

        .header-title {
            flex: 1;
        }

        .header-subline {
            color: var(--accent-blue);
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .header-title h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            letter-spacing: -1px;
        }

        .header-desc {
            color: var(--text-dim);
            font-size: 1rem;
            line-height: 1.6;
            max-width: 600px;
        }

        .top-stats {
            display: flex;
            gap: 20px;
        }

        .stat-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 20px 24px;
            min-width: 180px;
        }

        .stat-card span {
            display: block;
            color: var(--text-dim);
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin-bottom: 10px;
        }

        .stat-card strong {
            display: block;
            font-size: 2.5rem;
            color: var(--text-light);
            font-weight: 700;
        }

        /* Toolbar View */
        .toolbar {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }

        .tool-select, .tool-btn {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            color: var(--text-dim);
            padding: 10px 16px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            appearance: none;
            cursor: pointer;
        }
        .tool-select {
            padding-right: 35px;
            background-image: url("data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%238b8b9c%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 10px;
        }
        .toolbar-spacer { flex: 1; }
        .tool-btn {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Asset Cards View */
        .asset-list {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .asset-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            display: flex;
            overflow: hidden;
            height: 240px;
        }

        .asset-img {
            width: 320px;
            height: 100%;
            object-fit: cover;
            border-right: 1px solid var(--border-color);
        }

        .asset-details {
            flex: 1;
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .details-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .tag-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .badge {
            background-color: rgba(79, 110, 247, 0.2);
            color: var(--accent-blue);
            font-size: 0.65rem;
            font-weight: 800;
            padding: 4px 10px;
            border-radius: 4px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .badge.returning { background-color: rgba(247, 79, 79, 0.2); color: var(--badge-red); }
        .badge.extended { background-color: rgba(139, 79, 247, 0.2); color: var(--badge-purple); }

        .asset-id {
            color: var(--text-dim);
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .asset-name {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-light);
        }

        .renter-card {
            background-color: var(--bg-color);
            border: 1px solid var(--border-color);
            padding: 10px 16px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .renter-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #27272e;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            font-weight: 700;
            color: #fff;
            overflow: hidden;
        }

        .renter-avatar img { width: 100%; height: 100%; object-fit: cover; }

        .renter-info span {
            display: block;
            font-size: 0.65rem;
            color: var(--text-dim);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 3px;
        }

        .renter-info strong {
            display: block;
            font-size: 0.9rem;
            color: var(--text-light);
        }

        .details-bottom {
            display: flex;
            align-items: flex-end;
            gap: 50px;
        }

        .data-block label {
            display: block;
            font-size: 0.65rem;
            color: var(--text-dim);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .data-block .data-val {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-light);
        }

        .data-block .data-val.blue { color: var(--accent-blue); }
        .data-block .data-val.red { color: var(--badge-red); }
        .data-block .data-val.purple { color: var(--badge-purple); }

        .status-bar {
            width: 120px;
            height: 4px;
            background-color: var(--border-color);
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
        }

        .status-fill {
            height: 100%;
            background-color: var(--accent-blue);
            width: 85%;
        }

        .action-dots {
            margin-left: auto;
            color: var(--text-dim);
            cursor: pointer;
            font-size: 1.5rem;
            line-height: 1;
            padding-bottom: 5px;
        }

        /* Footer View */
        .dashboard-footer {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--text-dim);
            font-size: 0.8rem;
        }

        .pagination {
            display: flex;
            gap: 8px;
        }

        .page-btn {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 6px;
            color: var(--text-light);
            cursor: pointer;
            font-weight: 600;
        }
        .page-btn.active {
            background-color: var(--accent-blue);
            border-color: var(--accent-blue);
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar">
        <ul class="nav-list">
            <a href="${pageContext.request.contextPath}/admin/fleet" class="nav-item">
                <span class="icon">🚘</span> FLEET
            </a>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item active">
                <span class="icon">📅</span> RENTALS
            </a>
            <a href="#" class="nav-item">
                <span class="icon">👥</span> CUSTOMERS
            </a>
            <a href="#" class="nav-item">
                <span class="icon">📊</span> ANALYTICS
            </a>
            <a href="#" class="nav-item">
                <span class="icon">🔧</span> MAINTENANCE
            </a>
        </ul>
        <div class="sidebar-bottom">
            <button class="btn-new-rental">+ New Rental</button>
            <a href="#" class="action-link"><span class="icon">❓</span> SUPPORT</a>
            <a href="${pageContext.request.contextPath}/login?msg=loggedout" class="action-link"><span class="icon">🚪</span> LOGOUT</a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        
        <!-- Header -->
        <header class="top-header">
            <div class="header-title">
                <div class="header-subline">FLEET MANAGEMENT</div>
                <h1>Rented Assets</h1>
                <p class="header-desc">
                    Monitoring ${activeUnits} high-performance vehicles currently deployed across global locations. Track real-time status and telemetry data.
                </p>
            </div>
            <div class="top-stats">
                <div class="stat-card">
                    <span>ACTIVE UNITS</span>
                    <strong>${activeUnits}</strong>
                </div>
                <div class="stat-card">
                    <span>DAILY REVENUE</span>
                    <strong><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="Rs. "/></strong>
                </div>
            </div>
        </header>

        <!-- Toolbar -->
        <div class="toolbar">
            <select class="tool-select"><option>VEHICLE TYPE: All Hypercars</option></select>
            <select class="tool-select"><option>STATUS: Active Rentals</option></select>
            <select class="tool-select"><option>REGION: Nepal</option></select>
            <div class="toolbar-spacer"></div>
            <button class="tool-btn"><span>⚙️</span> Advanced Filters</button>
        </div>

        <!-- Asset List -->
        <div class="asset-list">
            <c:forEach var="rental" items="${allRentals}" varStatus="status">
                <div class="asset-card">
                    <img src="${pageContext.request.contextPath}/images/${rental.carImage}" alt="${rental.carTitle}" class="asset-img" onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png';">
                    
                    <div class="asset-details">
                        <div class="details-top">
                            <div>
                                <div class="tag-row">
                                    <span class="badge ${status.index % 3 == 0 ? 'active' : (status.index % 3 == 1 ? 'returning' : 'extended')}">
                                        ${status.index % 3 == 0 ? 'ACTIVE' : (status.index % 3 == 1 ? 'RETURNING' : 'EXTENDED')}
                                    </span>
                                    <span class="asset-id">ID: VLT-LAM-${rental.id}</span>
                                </div>
                                <div class="asset-name">${rental.carTitle}</div>
                            </div>
                            
                            <div class="renter-card">
                                <div class="renter-avatar">
                                    <c:out value="${rental.renterName.substring(0,1)}"/>
                                </div>
                                <div class="renter-info">
                                    <span>RENTER</span>
                                    <strong>${rental.renterName}</strong>
                                </div>
                            </div>
                        </div>

                        <div class="details-bottom">
                            <div class="data-block">
                                <label>RENTAL PERIOD</label>
                                <div class="data-val">${rental.startDate} — ${rental.endDate}</div>
                            </div>
                            
                            <div class="data-block">
                                <label>BOOKING VALUE</label>
                                <div class="data-val ${status.index % 3 == 0 ? 'blue' : (status.index % 3 == 1 ? 'red' : 'purple')}">
                                    <fmt:formatNumber value="${rental.totalCost}" type="currency" currencySymbol="Rs. "/>
                                </div>
                            </div>

                            <!-- Mock Telemetry specific per card iteration to match mockup -->
                            <c:if test="${status.index % 3 == 0}">
                                <div class="data-block">
                                    <label>FUEL STATUS</label>
                                    <div class="status-bar"><div class="status-fill"></div></div>
                                </div>
                            </c:if>
                            <c:if test="${status.index % 3 == 1}">
                                <div class="data-block">
                                    <label>TIRE PRESSURE</label>
                                    <div class="data-val" style="font-size:0.85rem; font-weight:600;"><span style="color:var(--accent-blue)">✓</span> Optimal</div>
                                </div>
                            </c:if>
                            <c:if test="${status.index % 3 == 2}">
                                <div class="data-block">
                                    <label>SERVICE DUE</label>
                                    <div class="data-val" style="font-size:0.85rem;">1,240 mi</div>
                                </div>
                            </c:if>

                            <div class="action-dots">•••</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty allRentals}">
                <div style="text-align: center; color: var(--text-dim); padding: 40px; border: 1px dashed var(--border-color); border-radius: 12px;">
                    No active rentals deployed across the network.
                </div>
            </c:if>
        </div>

        <div class="dashboard-footer">
            <span>Showing <strong>${activeUnits}</strong> of <strong>${activeUnits}</strong> assets</span>
            <div class="pagination">
                <button class="page-btn">&lt;</button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <button class="page-btn">&gt;</button>
            </div>
        </div>

    </main>

</body>
</html>
