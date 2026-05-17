<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fleet Management | Admin</title>
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
            --badge-green: #4ff78b;
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

        /* Sidebar */
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

        .nav-item:hover { color: var(--text-light); }

        .nav-item.active {
            color: var(--text-light);
            background: linear-gradient(90deg, rgba(79, 110, 247, 0.15) 0%, transparent 100%);
            border-right: 4px solid var(--accent-blue);
        }

        /* Main Content */
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

        .header-title h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .btn-add-car {
            background-color: var(--accent-blue);
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-add-car:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(79, 110, 247, 0.4); }

        /* Fleet Grid */
        .fleet-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 24px;
        }

        .car-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .car-img-wrapper {
            position: relative;
            height: 200px;
        }

        .car-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 800;
            text-transform: uppercase;
        }

        .status-available { background-color: rgba(79, 247, 139, 0.2); color: var(--badge-green); }
        .status-rented { background-color: rgba(247, 79, 79, 0.2); color: var(--badge-red); }

        .car-info {
            padding: 20px;
            flex: 1;
        }

        .car-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .car-specs {
            display: flex;
            gap: 15px;
            color: var(--text-dim);
            font-size: 0.8rem;
            margin-bottom: 15px;
        }

        .car-price {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--accent-blue);
        }

        .car-actions {
            display: flex;
            border-top: 1px solid var(--border-color);
        }

        .action-btn {
            flex: 1;
            padding: 15px;
            background: none;
            border: none;
            color: var(--text-dim);
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
            text-decoration: none;
            text-align: center;
        }

        .action-btn:hover { background-color: rgba(255, 255, 255, 0.05); color: var(--text-light); }
        .action-btn.delete:hover { color: var(--badge-red); }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.8);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: 20px;
            width: 500px;
            border: 1px solid var(--border-color);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-dim);
            font-size: 0.8rem;
            text-transform: uppercase;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            background-color: var(--bg-color);
            border: 1px solid var(--border-color);
            color: var(--text-light);
            border-radius: 8px;
        }

        .modal-footer {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn-submit {
            flex: 1;
            background-color: var(--accent-blue);
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-cancel {
            flex: 1;
            background: none;
            border: 1px solid var(--border-color);
            color: var(--text-dim);
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <aside class="sidebar">
        <ul class="nav-list">
            <a href="${pageContext.request.contextPath}/admin/fleet" class="nav-item active">
                <span class="icon">🚘</span> FLEET
            </a>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                <span class="icon">📅</span> RENTALS
            </a>
            <a href="#" class="nav-item">
                <span class="icon">👥</span> CUSTOMERS
            </a>
            <a href="${pageContext.request.contextPath}/login?msg=loggedout" class="nav-item" style="margin-top: auto;">
                <span class="icon">🚪</span> LOGOUT
            </a>
        </ul>
    </aside>

    <main class="main-content">
        <header class="top-header">
            <div class="header-title">
                <h1>Fleet Control</h1>
                <p style="color: var(--text-dim)">Manage your elite vehicle inventory and status.</p>
            </div>
            <button class="btn-add-car" onclick="openModal()">+ Add New Vehicle</button>
        </header>

        <div class="fleet-grid">
            <c:forEach var="car" items="${fleet}">
                <div class="car-card">
                    <div class="car-img-wrapper">
                        <img src="${pageContext.request.contextPath}/images/${car.imageUrl}" class="car-img" onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'">
                        <span class="status-badge ${car.status == 'Available' ? 'status-available' : 'status-rented'}">
                            ${car.status}
                        </span>
                    </div>
                    <div class="car-info">
                        <div class="car-title">${car.make} ${car.model}</div>
                        <div class="car-specs">
                            <span>${car.type}</span> • <span>${car.transmission}</span> • <span>${car.hp} HP</span>
                        </div>
                        <div class="car-price">Rs. <fmt:formatNumber value="${car.pricePerDay}"/> / Day</div>
                    </div>
                    <div class="car-actions">
                        <button class="action-btn" onclick='editCar(${car.id}, "${car.make}", "${car.model}", "${car.type}", "${car.transmission}", ${car.pricePerDay}, "${car.imageUrl}", "${car.status}", ${car.hp}, "${car.accel060}")'>Edit</button>
                        <form action="${pageContext.request.contextPath}/admin/fleet/delete" method="POST" style="flex: 1;" onsubmit="return confirm('Are you sure you want to delete this vehicle?')">
                            <input type="hidden" name="id" value="${car.id}">
                            <button type="submit" class="action-btn delete" style="width: 100%;">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <!-- Modal -->
    <div id="carModal" class="modal">
        <div class="modal-content">
            <h2 id="modalTitle" style="margin-bottom: 25px;">Add New Vehicle</h2>
            <form id="carForm" action="${pageContext.request.contextPath}/admin/fleet/add" method="POST">
                <input type="hidden" name="id" id="carId">
                <div style="display: flex; gap: 15px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Make</label>
                        <input type="text" name="make" id="make" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>Model</label>
                        <input type="text" name="model" id="model" required>
                    </div>
                </div>
                <div style="display: flex; gap: 15px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Type</label>
                        <select name="type" id="type">
                            <option value="Performance">Performance</option>
                            <option value="Luxury">Luxury</option>
                            <option value="SUV">SUV</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>Transmission</label>
                        <select name="transmission" id="transmission">
                            <option value="Auto">Auto</option>
                            <option value="Manual">Manual</option>
                        </select>
                    </div>
                </div>
                <div style="display: flex; gap: 15px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Price / Day</label>
                        <input type="number" name="pricePerDay" id="pricePerDay" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>Status</label>
                        <select name="status" id="status">
                            <option value="Available">Available</option>
                            <option value="Rented">Rented</option>
                            <option value="Maintenance">Maintenance</option>
                        </select>
                    </div>
                </div>
                <div style="display: flex; gap: 15px;">
                    <div class="form-group" style="flex: 1;">
                        <label>HP</label>
                        <input type="number" name="hp" id="hp">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>0-60 Time</label>
                        <input type="text" name="accel060" id="accel060">
                    </div>
                </div>
                <div class="form-group">
                    <label>Image Filename (in /images/)</label>
                    <input type="text" name="imageUrl" id="imageUrl" placeholder="car_hero.png">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn-submit">Save Vehicle</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal() {
            document.getElementById('modalTitle').innerText = 'Add New Vehicle';
            document.getElementById('carForm').action = '${pageContext.request.contextPath}/admin/fleet/add';
            document.getElementById('carId').value = '';
            document.getElementById('carForm').reset();
            document.getElementById('carModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('carModal').style.display = 'none';
        }

        function editCar(id, make, model, type, transmission, price, image, status, hp, accel) {
            document.getElementById('modalTitle').innerText = 'Edit Vehicle';
            document.getElementById('carForm').action = '${pageContext.request.contextPath}/admin/fleet/update';
            document.getElementById('carId').value = id;
            document.getElementById('make').value = make;
            document.getElementById('model').value = model;
            document.getElementById('type').value = type;
            document.getElementById('transmission').value = transmission;
            document.getElementById('pricePerDay').value = price;
            document.getElementById('imageUrl').value = image;
            document.getElementById('status').value = status;
            document.getElementById('hp').value = hp;
            document.getElementById('accel060').value = accel;
            document.getElementById('carModal').style.display = 'flex';
        }

        window.onclick = function(event) {
            if (event.target == document.getElementById('carModal')) {
                closeModal();
            }
        }
    </script>
</body>
</html>
