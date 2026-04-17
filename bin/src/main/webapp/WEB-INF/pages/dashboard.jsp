<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Car - Executive Control</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Outfit:ital,wght@0,600;0,700;0,800;1,700&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --blue:   #4f6ef7;
            --red:    #ef4444;
            --green:  #22c55e;
            --amber:  #f59e0b;
            --bg:     #0c0c0f;
            --surface:#13131a;
            --card:   #18181f;
            --border: rgba(255,255,255,0.07);
            --muted:  #52525b;
            --sub:    #a1a1aa;
        }

        body {
            background: var(--bg);
            color: #fff;
            font-family: 'Inter', sans-serif;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* ══════════ SIDEBAR ══════════ */
        .sidebar {
            width: 210px;
            height: 100vh;
            background: var(--surface);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            padding: 24px 14px;
            flex-shrink: 0;
        }

        .brand {
            display: flex; align-items: center; gap: 10px;
            padding: 0 8px; margin-bottom: 36px;
        }

        .brand-icon {
            width: 34px; height: 34px;
            background: linear-gradient(135deg, #4f6ef7, #7c3aed);
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-weight: 900; font-size: 0.9rem; flex-shrink: 0;
        }

        .brand-text h3 {
            font-family: 'Outfit', sans-serif;
            font-size: 0.9rem; letter-spacing: 2px; line-height: 1.1;
        }

        .brand-text span {
            font-size: 0.52rem; color: var(--blue);
            letter-spacing: 2px; text-transform: uppercase;
        }

        .nav { flex: 1; display: flex; flex-direction: column; gap: 3px; }

        .nav-item {
            display: flex; align-items: center; gap: 12px;
            padding: 10px 12px; border-radius: 10px;
            color: var(--sub); text-decoration: none;
            font-size: 0.75rem; font-weight: 600;
            text-transform: uppercase; letter-spacing: 1px;
            transition: all 0.2s; cursor: pointer;
            background: none; border: none; width: 100%; text-align: left;
            position: relative;
        }

        .nav-item:hover { color: #fff; }

        .nav-item.active {
            color: #fff; background: rgba(79,110,247,0.1);
        }

        .nav-item.active::before {
            content: '';
            position: absolute; left: 0; top: 50%;
            transform: translateY(-50%);
            width: 3px; height: 60%;
            background: var(--blue); border-radius: 0 3px 3px 0;
        }

        .nav-item .icon { font-size: 0.9rem; width: 18px; text-align: center; }

        .sidebar-bottom { margin-top: 20px; }

        .add-vehicle-btn {
            display: flex; align-items: center; justify-content: center; gap: 8px;
            padding: 13px; background: linear-gradient(135deg, #4f6ef7, #6366f1);
            border-radius: 12px; color: #fff; font-weight: 700;
            text-decoration: none; font-size: 0.78rem; letter-spacing: 0.5px;
            transition: all 0.3s; margin-bottom: 10px;
        }

        .add-vehicle-btn:hover { filter: brightness(1.15); transform: translateY(-1px); }

        .nav-footer a, .nav-footer button {
            display: flex; align-items: center; gap: 10px;
            color: var(--muted); text-decoration: none;
            font-size: 0.73rem; font-weight: 600;
            text-transform: uppercase; letter-spacing: 1px;
            padding: 8px 12px; border-radius: 8px;
            background: none; border: none; width: 100%; cursor: pointer;
            transition: color 0.2s;
        }

        .nav-footer a:hover, .nav-footer button:hover { color: var(--sub); }

        /* ══════════ MAIN ══════════ */
        .main-wrap {
            flex: 1; display: flex; flex-direction: column; overflow: hidden;
        }

        /* Top bar */
        .topbar {
            display: flex; align-items: center; gap: 16px;
            padding: 16px 32px; border-bottom: 1px solid var(--border);
            background: var(--surface); flex-shrink: 0;
        }

        .search-box {
            flex: 1; max-width: 380px;
            display: flex; align-items: center; gap: 10px;
            background: var(--card); border: 1px solid var(--border);
            border-radius: 10px; padding: 9px 16px;
            color: var(--sub); font-size: 0.8rem;
        }

        .tb-spacer { flex: 1; }
        .tb-actions { display: flex; align-items: center; gap: 10px; }

        .tb-icon {
            width: 36px; height: 36px; background: var(--card);
            border: 1px solid var(--border); border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            color: var(--sub); font-size: 0.95rem; position: relative;
        }

        .tb-icon .dot {
            position: absolute; top: 6px; right: 6px;
            width: 7px; height: 7px; background: var(--red);
            border-radius: 50%; border: 2px solid var(--surface);
        }

        .user-pill {
            display: flex; align-items: center; gap: 10px;
            background: var(--card); border: 1px solid var(--border);
            border-radius: 12px; padding: 5px 12px;
        }

        .up-name { font-size: 0.78rem; font-weight: 700; line-height: 1.2; }
        .up-role { font-size: 0.58rem; color: var(--sub); text-transform: uppercase; letter-spacing: 1px; }

        .up-avatar {
            width: 30px; height: 30px; border-radius: 50%; overflow: hidden;
        }
        .up-avatar img { width: 100%; height: 100%; object-fit: cover; }

        /* ══════════ PANELS ══════════ */
        .panel { display: none; flex: 1; overflow-y: auto; padding: 32px; }
        .panel.active { display: block; }

        .panel::-webkit-scrollbar { width: 4px; }
        .panel::-webkit-scrollbar-track { background: transparent; }
        .panel::-webkit-scrollbar-thumb { background: var(--border); border-radius: 2px; }

        /* ── Welcome ── */
        .welcome-title {
            font-family: 'Outfit', sans-serif;
            font-size: 2.3rem; font-weight: 800; margin-bottom: 5px;
        }

        .welcome-sub { color: var(--sub); font-size: 0.88rem; margin-bottom: 28px; }

        /* ── Hero Row ── */
        .hero-row {
            display: grid; grid-template-columns: 1fr 270px;
            gap: 18px; margin-bottom: 24px;
        }

        .drive-card {
            background: var(--card); border: 1px solid var(--border);
            border-radius: 20px; padding: 30px; position: relative;
            overflow: hidden; min-height: 240px;
            display: flex; flex-direction: column; justify-content: flex-end;
        }

        .drive-car-img {
            position: absolute; right: -4%; top: 50%;
            transform: translateY(-52%); width: 54%;
            filter: drop-shadow(0 10px 40px rgba(0,0,0,0.7));
            pointer-events: none;
        }

        .drive-badge {
            display: inline-block;
            background: rgba(79,110,247,0.15); color: var(--blue);
            font-size: 0.58rem; font-weight: 700; letter-spacing: 2px;
            text-transform: uppercase; padding: 5px 12px;
            border-radius: 100px; border: 1px solid rgba(79,110,247,0.3);
            width: fit-content; margin-bottom: 10px;
        }

        .drive-name {
            font-family: 'Outfit', sans-serif; font-size: 2.2rem;
            font-weight: 800; font-style: italic; line-height: 1;
            margin-bottom: 14px; max-width: 48%; position: relative; z-index: 1;
        }

        .drive-stats { display: flex; gap: 24px; margin-bottom: 18px; position: relative; z-index: 1; }

        .ds label { font-size: 0.58rem; color: var(--sub); text-transform: uppercase; letter-spacing: 1px; display: block; margin-bottom: 3px; }
        .ds .dv { font-size: 1rem; font-weight: 800; }
        .dv.red { color: var(--red); }
        .dv.grn { color: var(--green); }

        .drive-actions { display: flex; gap: 10px; position: relative; z-index: 1; }

        .btn-primary {
            padding: 11px 20px; background: var(--blue); border: none;
            border-radius: 11px; color: #fff; font-weight: 700; font-size: 0.82rem;
            cursor: pointer; font-family: 'Inter', sans-serif;
            text-decoration: none; display: inline-flex; align-items: center; gap: 6px;
            transition: all 0.2s;
        }
        .btn-primary:hover { background: #6366f1; }

        .btn-ghost {
            padding: 11px 20px; background: transparent;
            border: 1px solid var(--border); border-radius: 11px;
            color: #fff; font-weight: 700; font-size: 0.82rem;
            cursor: pointer; font-family: 'Inter', sans-serif; transition: all 0.2s;
        }
        .btn-ghost:hover { background: rgba(255,255,255,0.05); }

        .empty-drive {
            display: flex; flex-direction: column; gap: 10px;
            padding-top: 20px;
        }

        /* Stats col */
        .stats-col { display: flex; flex-direction: column; gap: 16px; }

        .stat-card {
            flex: 1; background: var(--card); border: 1px solid var(--border);
            border-radius: 18px; padding: 22px; position: relative; overflow: hidden;
        }

        .stat-decor {
            position: absolute; right: 16px; top: 50%; transform: translateY(-50%);
            width: 56px; height: 56px; border: 3px solid rgba(255,255,255,0.04);
            border-radius: 50%;
        }

        .stat-lbl { font-size: 0.58rem; color: var(--sub); text-transform: uppercase; letter-spacing: 2px; margin-bottom: 8px; }
        .stat-num { font-family: 'Outfit', sans-serif; font-size: 2.2rem; font-weight: 800; line-height: 1; }
        .stat-delta { font-size: 0.72rem; color: var(--green); margin-top: 5px; font-weight: 600; }
        .stat-sub { font-size: 0.7rem; color: var(--sub); margin-top: 5px; }
        .border-blue { border-top: 3px solid var(--blue); }
        .border-red  { border-top: 3px solid var(--red); }

        /* Section title */
        .sec-head {
            display: flex; align-items: center; gap: 12px;
            font-size: 0.92rem; font-weight: 700; margin-bottom: 14px;
        }
        .sec-head::before { content: ''; width: 26px; height: 2px; background: var(--blue); border-radius: 1px; }

        /* Quick access */
        .quick-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 12px; margin-bottom: 28px; }

        .quick-card {
            background: var(--card); border: 1px solid var(--border);
            border-radius: 14px; padding: 18px;
            display: flex; align-items: center; gap: 14px;
            text-decoration: none; color: #fff; transition: all 0.2s;
        }
        .quick-card:hover { border-color: rgba(79,110,247,0.4); background: rgba(79,110,247,0.06); transform: translateY(-2px); }

        .quick-icon {
            width: 42px; height: 42px; background: rgba(79,110,247,0.12);
            border-radius: 11px; display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem; flex-shrink: 0;
        }
        .quick-info h4 { font-size: 0.87rem; font-weight: 700; margin-bottom: 2px; }
        .quick-info p  { font-size: 0.7rem; color: var(--sub); }

        /* Bottom grid */
        .bottom-grid { display: grid; grid-template-columns: 1.2fr 1fr; gap: 18px; margin-bottom: 28px; }

        .exp-card {
            border-radius: 18px; overflow: hidden; position: relative; min-height: 210px;
        }
        .exp-img { width: 100%; height: 100%; object-fit: cover; display: block; }
        .exp-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to right, rgba(0,0,0,0.88) 45%, transparent);
            display: flex; flex-direction: column; justify-content: flex-end; padding: 26px;
        }
        .exp-date { font-size: 0.6rem; color: var(--blue); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 6px; }
        .exp-name { font-family: 'Outfit', sans-serif; font-size: 1.9rem; font-weight: 800; line-height: 1; margin-bottom: 8px; }
        .exp-desc { font-size: 0.75rem; color: rgba(255,255,255,0.7); line-height: 1.5; max-width: 320px; margin-bottom: 18px; }
        .btn-white { padding: 11px 22px; background: #fff; color: #000; font-weight: 700; font-size: 0.82rem; border: none; border-radius: 11px; cursor: pointer; font-family: 'Inter', sans-serif; transition: all 0.2s; }
        .btn-white:hover { background: #e5e7eb; }

        .arrivals-col { display: flex; flex-direction: column; gap: 12px; }

        .arrival-card {
            background: var(--card); border: 1px solid var(--border);
            border-radius: 12px; padding: 14px;
            display: flex; align-items: center; gap: 14px;
            text-decoration: none; color: #fff; transition: all 0.2s;
        }
        .arrival-card:hover { border-color: rgba(79,110,247,0.4); transform: translateX(3px); }
        .arrival-thumb { width: 100px; height: 64px; border-radius: 8px; overflow: hidden; background: #1a1a22; flex-shrink: 0; }
        .arrival-thumb img { width: 100%; height: 100%; object-fit: cover; display: block; }
        .arr-cat { font-size: 0.55rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: var(--blue); margin-bottom: 3px; }
        .arr-name { font-family: 'Outfit', sans-serif; font-size: 1.1rem; font-weight: 800; font-style: italic; line-height: 1; margin-bottom: 5px; }
        .arr-specs { font-size: 0.68rem; color: var(--sub); }

        /* ══════════ BOOKINGS PANEL ══════════ */
        .bk-header {
            display: flex; align-items: flex-start; justify-content: space-between;
            margin-bottom: 28px;
        }
        .bk-title { font-family: 'Outfit', sans-serif; font-size: 2rem; font-weight: 800; margin-bottom: 4px; }
        .bk-sub { font-size: 0.84rem; color: var(--sub); }

        .bk-summary {
            display: grid; grid-template-columns: repeat(3,1fr); gap: 16px; margin-bottom: 32px;
        }

        .bk-stat {
            background: var(--card); border: 1px solid var(--border);
            border-radius: 16px; padding: 22px;
        }
        .bk-stat .lbl { font-size: 0.6rem; color: var(--sub); text-transform: uppercase; letter-spacing: 2px; margin-bottom: 8px; }
        .bk-stat .num { font-family: 'Outfit', sans-serif; font-size: 2.4rem; font-weight: 800; line-height: 1; }
        .bk-stat .hint { font-size: 0.7rem; color: var(--sub); margin-top: 5px; }
        .bk-stat .num.blue { color: var(--blue); }
        .bk-stat .num.green { color: var(--green); }
        .bk-stat .num.amber { color: var(--amber); }

        .bk-list { display: flex; flex-direction: column; gap: 14px; }

        .bk-item {
            background: var(--card); border: 1px solid var(--border);
            border-radius: 18px; padding: 20px 24px;
            display: grid; grid-template-columns: 90px 1fr auto;
            align-items: center; gap: 20px; transition: all 0.2s;
        }
        .bk-item:hover { border-color: rgba(79,110,247,0.3); }

        .bk-thumb { width: 90px; height: 60px; border-radius: 10px; overflow: hidden; background: #1a1a22; }
        .bk-thumb img { width: 100%; height: 100%; object-fit: cover; display: block; }

        .bk-car { font-family: 'Outfit', sans-serif; font-size: 1.1rem; font-weight: 800; margin-bottom: 4px; }
        .bk-meta { font-size: 0.73rem; color: var(--sub); margin-bottom: 8px; }

        .bk-days-bar { width: 100%; max-width: 220px; }
        .bk-days-label { display: flex; justify-content: space-between; font-size: 0.65rem; color: var(--sub); margin-bottom: 4px; }
        .bk-progress { height: 5px; background: rgba(255,255,255,0.07); border-radius: 3px; overflow: hidden; }
        .bk-progress-fill { height: 100%; background: var(--blue); border-radius: 3px; }

        .bk-cost { font-size: 0.9rem; font-weight: 700; margin-top: 6px; }

        .bk-actions { display: flex; flex-direction: column; gap: 8px; align-items: flex-end; }

        .btn-view {
            padding: 8px 18px; background: rgba(79,110,247,0.12);
            border: 1px solid rgba(79,110,247,0.3); border-radius: 9px;
            color: var(--blue); font-size: 0.75rem; font-weight: 700;
            text-decoration: none; white-space: nowrap;
        }
        .btn-view:hover { background: rgba(79,110,247,0.22); }

        .btn-cancel-sm {
            padding: 8px 18px; background: rgba(239,68,68,0.1);
            border: 1px solid rgba(239,68,68,0.3); border-radius: 9px;
            color: var(--red); font-size: 0.75rem; font-weight: 700;
            cursor: pointer; font-family: 'Inter', sans-serif; white-space: nowrap;
        }
        .btn-cancel-sm:hover { background: rgba(239,68,68,0.2); }

        .status-pill {
            display: inline-block; padding: 3px 10px; border-radius: 100px;
            font-size: 0.62rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px;
        }
        .pill-active { background: rgba(34,197,94,0.12); color: var(--green); border: 1px solid rgba(34,197,94,0.25); }
        .pill-pending{ background: rgba(245,158,11,0.12); color: var(--amber); border: 1px solid rgba(245,158,11,0.25); }

        .empty-state {
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            gap: 14px; padding: 80px 0; color: var(--muted); text-align: center;
        }
        .empty-state .emoji { font-size: 3.5rem; }
        .empty-state h3 { color: #fff; font-size: 1.1rem; }
        .empty-state p { font-size: 0.82rem; }
    </style>
</head>
<body>

    <%-- ══════ SIDEBAR ══════ --%>
    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/home" class="brand" style="text-decoration: none; color: inherit;">
            <div class="brand-icon">Y</div>
            <div class="brand-text">
                <h3>YOUR CAR</h3>
                <span>Executive Control</span>
            </div>
        </a>

        <nav class="nav">
            <button class="nav-item active" onclick="showPanel('fleet', this)">
                <span class="icon">🚗</span> Fleet
            </button>
            <button class="nav-item" onclick="showPanel('bookings', this)">
                <span class="icon">📅</span> Bookings
                <c:if test="${not empty rentals}">
                    <span style="margin-left:auto;background:var(--blue);color:#fff;font-size:0.6rem;font-weight:800;padding:2px 7px;border-radius:100px;">${fn:length(rentals)}</span>
                </c:if>
            </button>
            <button class="nav-item" onclick="showPanel('fleet', this)">
                <span class="icon">👥</span> Customers
            </button>
            <button class="nav-item" onclick="showPanel('fleet', this)">
                <span class="icon">📊</span> Analytics
            </button>
            <button class="nav-item" onclick="showPanel('fleet', this)">
                <span class="icon">🔧</span> Maintenance
            </button>
        </nav>

        <div class="sidebar-bottom">
            <a href="${pageContext.request.contextPath}/home#booking" class="add-vehicle-btn">+ Add New Vehicle</a>
            <div class="nav-footer">
                <a href="#">❓ &nbsp;Support</a>
                <a href="${pageContext.request.contextPath}/logout">🚪 &nbsp;Logout</a>
            </div>
        </div>
    </aside>

    <%-- ══════ MAIN WRAP ══════ --%>
    <div class="main-wrap">

        <%-- Top Bar --%>
        <div class="topbar">
            <div class="search-box">
                <span>🔍</span>
                <span>Search vehicles, bookings, or telemetry…</span>
            </div>
            <div class="tb-spacer"></div>
            <div class="tb-actions">
                <div class="tb-icon">🔔<div class="dot"></div></div>
                <div class="tb-icon">⚙️</div>
                <div class="user-pill">
                    <div>
                        <div class="up-name">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">${sessionScope.user.fullName}</c:when>
                                <c:otherwise>Dominic Toretto</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="up-role">Platinum Member</div>
                    </div>
                    <div class="up-avatar">
                        <c:set var="uname" value="${not empty sessionScope.user ? sessionScope.user.fullName : 'DT'}"/>
                        <img src="https://ui-avatars.com/api/?name=${uname}&background=4f6ef7&color=fff&bold=true" alt="avatar">
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════ FLEET PANEL ══════ --%>
        <div id="panel-fleet" class="panel active">

            <h1 class="welcome-title">
                Welcome back,
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">${fn:split(sessionScope.user.fullName,' ')[0]}.</c:when>
                    <c:otherwise>Driver.</c:otherwise>
                </c:choose>
            </h1>
            <p class="welcome-sub">Your stable is primed and ready for the weekend.</p>

            <%-- Hero Row --%>
            <div class="hero-row">

                <div class="drive-card">
                    <c:choose>
                        <c:when test="${not empty rentals}">
                            <c:set var="r" value="${rentals[0]}"/>
                            <img src="${pageContext.request.contextPath}/images/car_${r.carId}.png"
                                 onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'"
                                 class="drive-car-img" alt="${r.carInfo}">
                            <div class="drive-badge">Current Drive</div>
                            <div class="drive-name">${r.carInfo}</div>
                            <div class="drive-stats">
                                <div class="ds">
                                    <label>Return In</label>
                                    <div class="dv red">${r.endDate}</div>
                                </div>
                                <div class="ds">
                                    <label>Status</label>
                                    <div class="dv grn">${r.status}</div>
                                </div>
                                <div class="ds">
                                    <label>Total Cost</label>
                                    <div class="dv">NPR ${r.totalCost}</div>
                                </div>
                            </div>
                            <div class="drive-actions">
                                <a href="${pageContext.request.contextPath}/booking-detail?id=${r.id}" class="btn-primary">
                                    Manage Booking
                                </a>
                                <form action="${pageContext.request.contextPath}/cancel" method="post" style="margin:0;"
                                      onsubmit="return confirm('Cancel this reservation?');">
                                    <input type="hidden" name="rentalId" value="${r.id}">
                                    <button type="submit" class="btn-ghost">Cancel</button>
                                </form>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-drive">
                                <div class="drive-badge">No Active Drive</div>
                                <div class="drive-name" style="max-width:100%;font-size:1.8rem;color:#52525b;">Garage is empty.</div>
                                <p style="color:#71717a;font-size:0.83rem;">Book a car to get started.</p>
                                <a href="${pageContext.request.contextPath}/home#booking" class="btn-primary" style="width:fit-content;">Browse Fleet →</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="stats-col">
                    <div class="stat-card border-blue">
                        <div class="stat-decor"></div>
                        <div class="stat-lbl">Rental Points</div>
                        <div class="stat-num">12,450</div>
                        <div class="stat-delta">↑ +1,200 this month</div>
                    </div>
                    <div class="stat-card border-red">
                        <div class="stat-decor"></div>
                        <div class="stat-lbl">Miles Driven</div>
                        <div class="stat-num">3,204</div>
                        <div class="stat-sub">Equates to 48 hours of seat time</div>
                    </div>
                </div>
            </div>

            <%-- Quick Access --%>
            <div class="sec-head">Quick Access</div>
            <div class="quick-grid">
                <a href="${pageContext.request.contextPath}/home#booking" class="quick-card">
                    <div class="quick-icon">🔑</div>
                    <div class="quick-info"><h4>Book a Car</h4><p>24 new models available</p></div>
                </a>
                <button class="quick-card" onclick="showPanelById('bookings')" style="cursor:pointer;">
                    <div class="quick-icon">🚘</div>
                    <div class="quick-info"><h4>My Bookings</h4><p>View your drive history</p></div>
                </button>
                <a href="#" class="quick-card">
                    <div class="quick-icon">📞</div>
                    <div class="quick-info"><h4>Concierge Support</h4><p>Direct line to your agent</p></div>
                </a>
            </div>

            <%-- Bottom Grid --%>
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:12px;">
                <div class="sec-head" style="margin-bottom:0;">Upcoming Experiences</div>
                <a href="#" style="font-size:0.75rem;color:var(--blue);text-decoration:none;font-weight:700;letter-spacing:0.5px;">VIEW ALL</a>
                <div style="flex:1;"></div>
                <div class="sec-head" style="margin-bottom:0;">New Arrivals</div>
            </div>
            <div class="bottom-grid">
                <div class="exp-card">
                    <img src="${pageContext.request.contextPath}/images/hcar_2.png"
                         onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'"
                         class="exp-img" alt="Experience">
                    <div class="exp-overlay">
                        <div class="exp-date">📅 September 12–15</div>
                        <div class="exp-name">AMALFI COAST RALLY</div>
                        <p class="exp-desc">Join an exclusive 3-day cruise through the world's most scenic coastal roads with curated stops at Michelin-star destinations.</p>
                        <button class="btn-white">Secure Spot</button>
                    </div>
                </div>
                <div class="arrivals-col">
                    <a href="${pageContext.request.contextPath}/home#booking" class="arrival-card">
                        <div class="arrival-thumb">
                            <img src="${pageContext.request.contextPath}/images/car_2.png"
                                 onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'" alt="Ferrari">
                        </div>
                        <div>
                            <div class="arr-cat">Hybrid Precision</div>
                            <div class="arr-name">FERRARI 296 GTB</div>
                            <div class="arr-specs">818 HP &nbsp;·&nbsp; 2.9s 0-60</div>
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/home#booking" class="arrival-card">
                        <div class="arrival-thumb">
                            <img src="${pageContext.request.contextPath}/images/car_3.png"
                                 onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'" alt="Lamborghini">
                        </div>
                        <div>
                            <div class="arr-cat">Raw Performance</div>
                            <div class="arr-name">LAMBORGHINI TECNICA</div>
                            <div class="arr-specs">V10 Engine &nbsp;·&nbsp; RWD Only</div>
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/home#booking" class="arrival-card">
                        <div class="arrival-thumb">
                            <img src="${pageContext.request.contextPath}/images/hcar_1.png"
                                 onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'" alt="RR">
                        </div>
                        <div>
                            <div class="arr-cat">Ultra Luxury</div>
                            <div class="arr-name">ROLLS ROYCE CULLINAN</div>
                            <div class="arr-specs">563 HP &nbsp;·&nbsp; 6.75L V12</div>
                        </div>
                    </a>
                </div>
            </div>

        </div><%-- /fleet panel --%>

        <%-- ══════ BOOKINGS PANEL ══════ --%>
        <div id="panel-bookings" class="panel">

            <div class="bk-header">
                <div>
                    <div class="bk-title">My Bookings</div>
                    <div class="bk-sub">Manage all your active and past reservations.</div>
                </div>
                <a href="${pageContext.request.contextPath}/home#booking" class="btn-primary" style="margin-top:4px;">+ New Booking</a>
            </div>

            <%-- Summary Cards --%>
            <div class="bk-summary">
                <div class="bk-stat">
                    <div class="lbl">Total Bookings</div>
                    <div class="num blue">${not empty rentals ? fn:length(rentals) : 0}</div>
                    <div class="hint">All time reservations</div>
                </div>
                <div class="bk-stat">
                    <div class="lbl">Active Now</div>
                    <div class="num green">
                        <c:choose>
                            <c:when test="${not empty rentals}">${fn:length(rentals)}</c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="hint">Currently on the road</div>
                </div>
                <div class="bk-stat">
                    <div class="lbl">Days Remaining</div>
                    <div class="num amber">
                        <c:choose>
                            <c:when test="${not empty rentals}">48h</c:when>
                            <c:otherwise>—</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="hint">On nearest booking</div>
                </div>
            </div>

            <%-- Booking List --%>
            <div class="bk-list">
                <c:choose>
                    <c:when test="${not empty rentals}">
                        <c:forEach var="rental" items="${rentals}" varStatus="vs">
                            <div class="bk-item">
                                <div class="bk-thumb">
                                    <img src="${pageContext.request.contextPath}/images/car_${rental.carId}.png"
                                         onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'"
                                         alt="${rental.carInfo}">
                                </div>
                                <div>
                                    <div style="display:flex;align-items:center;gap:10px;margin-bottom:4px;">
                                        <div class="bk-car">${rental.carInfo}</div>
                                        <span class="status-pill pill-active">${rental.status}</span>
                                    </div>
                                    <div class="bk-meta">
                                        Booking #VLT-${rental.id}-S &nbsp;·&nbsp; ${rental.startDate} → ${rental.endDate}
                                    </div>
                                    <div class="bk-days-bar">
                                        <div class="bk-days-label">
                                            <span>Progress</span>
                                            <span>48h remaining</span>
                                        </div>
                                        <div class="bk-progress">
                                            <div class="bk-progress-fill" style="width: 65%;"></div>
                                        </div>
                                    </div>
                                    <div class="bk-cost">NPR ${rental.totalCost}</div>
                                </div>
                                <div class="bk-actions">
                                    <a href="${pageContext.request.contextPath}/booking-detail?id=${rental.id}" class="btn-view">
                                        View Detail
                                    </a>
                                    <a href="${pageContext.request.contextPath}/update?rentalId=${rental.id}" class="btn-view" style="color:var(--amber); border-color: rgba(245,158,11,0.3); background: rgba(245,158,11,0.12); text-align: center;">
                                        Update
                                    </a>
                                    <form action="${pageContext.request.contextPath}/cancel" method="post" style="margin:0;"
                                          onsubmit="return confirm('Cancel booking #VLT-${rental.id}-S?');">
                                        <input type="hidden" name="rentalId" value="${rental.id}">
                                        <button type="submit" class="btn-cancel-sm" style="color:var(--red);">
                                            Cancel
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="emoji">🚗</div>
                            <h3>No bookings yet</h3>
                            <p>Browse our premium fleet and make your first reservation.</p>
                            <a href="${pageContext.request.contextPath}/home#booking" class="btn-primary" style="margin-top:8px;">Browse Fleet →</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div><%-- /bookings panel --%>

    </div><%-- /main-wrap --%>

    <script>
        function showPanel(name, btn) {
            // hide all panels
            document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
            // show target panel
            document.getElementById('panel-' + name).classList.add('active');
            // update nav
            document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
            if (btn) btn.classList.add('active');
        }

        function showPanelById(name) {
            document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
            document.getElementById('panel-' + name).classList.add('active');
            document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
            document.querySelectorAll('.nav-item').forEach(i => {
                const text = i.textContent.trim().toLowerCase();
                if (text.includes(name)) i.classList.add('active');
            });
        }

        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const targetPanel = urlParams.get('panel');
            if (targetPanel) {
                showPanelById(targetPanel);
            }
        };
    </script>
</body>
</html>
