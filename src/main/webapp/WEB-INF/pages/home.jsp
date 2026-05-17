<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en" class="dark-landing">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Vehicle Rent in Nepal - Rental Service</title>
            <!-- Fonts -->
            <link
                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:ital,wght@0,600;0,700;0,800;1,700;1,800&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
        </head>

        <body class="landing-body">
            <!-- Top Nav -->
            <nav class="top-nav">
                <div class="nav-brand">
                    <span class="logo-text">RIDE NEPAL</span>
                </div>
                <div class="nav-links">
                    <a href="#" class="active">Home</a>
                    <a href="#services">Services</a>
                    <a href="#booking">Booking</a>
                    <a href="#contact">Contact</a>
                </div>
                <div class="nav-actions">
                    <div class="nav-search-container">
                        <form action="search" method="get" class="search-form-nav">
                            <input type="text" id="navSearchInput" name="query" placeholder="Search Ride Nepal.." class="nav-search-input" autocomplete="off">
                            <button type="submit" class="nav-search-btn">🔍</button>
                        </form>
                        <div id="navSearchResults" class="live-search-panel nav-results"></div>
                    </div>
                    <a href="login" class="btn-signin">Sign In</a>
                </div>
            </nav>

            <!-- Hero Section -->
            <section class="hero-section">
                <div class="hero-bg">
                    <img src="${pageContext.request.contextPath}/images/car_hero.png" alt="Hero Car">
                    <div class="hero-overlay"></div>
                </div>
                <div class="hero-content centered">
                    <h1 class="hero-title">
                        FERRARI PUROSANGUE
                        <span>HANDLING SPECIALE</span>
                    </h1>
                    <a href="#booking" class="btn-discover-circular">
                        <span>DISCOVER</span>
                        <div class="circle-arrow">
                            <span class="chevron"></span>
                        </div>
                    </a>
                </div>

                <!-- Original Booking Widget preserved but repositioned at the bottom for "neat and tidy" look -->
                <div class="booking-widget" style="margin-top: 4rem; position: relative; z-index: 20;">
                    <div class="widget-field">
                        <label>PICK-UP LOCATION</label>
                        <div class="widget-input">
                            <span class="icon">📍</span>
                            <input type="text" value="Kathmandu, Nepal" readonly>
                        </div>
                    </div>
                    <div class="widget-field">
                        <label>FLEET SELECTION</label>
                        <div class="widget-input">
                            <span class="icon">🚗</span>
                            <select>
                                <option>Performance</option>
                                <option>Luxury</option>
                            </select>
                        </div>
                    </div>
                    <div class="widget-field">
                        <label>DURATION</label>
                        <div class="widget-input">
                            <span class="icon">📅</span>
                            <input type="text" value="24 C" readonly>
                        </div>
                    </div>
                    <form action="book" method="post" style="width:auto;">
                        <input type="hidden" name="carId" value="1">
                        <button type="submit" class="widget-btn">Find Fleet</button>
                    </form>
                </div>

                <!-- Search Results Section -->
                <c:if test="${not empty searchResult}">
                    <div class="search-result-overlay" id="searchResult">
                        <div class="result-card">
                            <button class="close-btn" onclick="this.parentElement.parentElement.remove()">×</button>
                            <div class="result-badge">1 Search Found</div>
                            <div class="result-content">
                                <img src="${pageContext.request.contextPath}/images/car_${searchResult.id}.png" 
                                     onerror="this.src='${pageContext.request.contextPath}/images/car_hero.png'" alt="${searchResult.model}">
                                <div class="result-info">
                                    <h3>${searchResult.make} ${searchResult.model}</h3>
                                    <p>${searchResult.type} · ${searchResult.hp} HP</p>
                                    <div class="price">NPR ${searchResult.pricePerDay}/day</div>
                                    <form action="book" method="post">
                                        <input type="hidden" name="carId" value="${searchResult.id}">
                                        <button type="submit" class="book-link">Book This Model &rarr;</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty searchError}">
                    <div class="search-error-msg">
                        ${searchError}
                    </div>
                </c:if>
            </section>

            <!-- Curated Collections -->
            <section class="collections">
                <div class="section-header">
                    <div>
                        <h2>CURATED COLLECTIONS</h2>
                        <p>Performance categories designed for the discerning driver.</p>
                    </div>
                    <div class="carousel-nav">
                        <button class="nav-circle">&lt;</button>
                        <button class="nav-circle active">&gt;</button>
                    </div>
                </div>
                <div class="collection-grid">
                    <div class="collection-card">
                        <img src="${pageContext.request.contextPath}/images/car_3.png" alt="Luxury">
                        <div class="card-overlay">
                            <span class="cat-num">CATEGORY 01</span>
                            <h3>LUXURY</h3>
                        </div>
                    </div>
                    <div class="collection-card">
                        <img src="${pageContext.request.contextPath}/images/car_2.png" alt="Sport">
                        <div class="card-overlay">
                            <span class="cat-num">CATEGORY 02</span>
                            <h3>SPORT</h3>
                        </div>
                    </div>
                    <div class="collection-card">
                        <img src="${pageContext.request.contextPath}/images/car_1.png" alt="Electric">
                        <div class="card-overlay">
                            <span class="cat-num">CATEGORY 03</span>
                            <h3>ELECTRIC</h3>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Latest Arrivals -->
            <section class="arrivals" id="booking">
                <div class="section-header center">
                    <h2>LATEST ARRIVALS</h2>
                    <div class="title-underline"></div>
                </div>
                <div class="arrival-grid">
                    <!-- Card 1: BMW M8 Competition -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/hcar_1.png" alt="BMW M8 Competition">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>BMW M8 Competition</h3>
                                <span class="badge">NEW ARRIVAL</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>617 HP</span>
                                </div>
                                <div class="spec">
                                    <label>0-100 KM/H</label>
                                    <span>3.2s</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 28,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="1">
                                    <button type="submit" class="book-link"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Card 2: Aston Martin DBX707 -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/hcar_2.png" alt="Aston Martin DBX707">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>Aston Martin DBX707</h3>
                                <span class="badge danger">FLASH DEAL</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>707 HP</span>
                                </div>
                                <div class="spec">
                                    <label>TOP SPEED</label>
                                    <span>310 KM/H</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 55,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="2">
                                    <button type="submit" class="book-link red"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Card 3: Bentley Bentayga -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/car_1.png" alt="Bentley Bentayga">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>Bentley Bentayga</h3>
                                <span class="badge">LUXURY SUV</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>ENGINE</label>
                                    <span>4.0L V8</span>
                                </div>
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>542 HP</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 65,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="3">
                                    <button type="submit" class="book-link"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Card 4: Porsche Cayenne Turbo -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/car_2.png" alt="Porsche Cayenne Turbo">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>Porsche Cayenne Turbo</h3>
                                <span class="badge danger">HOT PICK</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>541 HP</span>
                                </div>
                                <div class="spec">
                                    <label>0-100 KM/H</label>
                                    <span>3.9s</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 38,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="4">
                                    <button type="submit" class="book-link red"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Card 5: Lamborghini Urus -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/car_3.png" alt="Lamborghini Urus">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>Lamborghini Urus</h3>
                                <span class="badge">MOST POPULAR</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>650 HP</span>
                                </div>
                                <div class="spec">
                                    <label>TOP SPEED</label>
                                    <span>305 KM/H</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 72,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="5">
                                    <button type="submit" class="book-link"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Card 6: Mercedes-Benz S-Class -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/hcar_1.png" alt="Mercedes-Benz S-Class">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>Mercedes-Benz S-Class</h3>
                                <span class="badge danger">EXCLUSIVE</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>ENGINE</label>
                                    <span>3.0L I6</span>
                                </div>
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>429 HP</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 22,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="6">
                                    <button type="submit" class="book-link red"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Card 7: Range Rover Autobiography -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/hcar_2.png"
                                alt="Range Rover Autobiography">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>Range Rover Autobiography</h3>
                                <span class="badge">PREMIUM</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>ENGINE</label>
                                    <span>4.4L V8</span>
                                </div>
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>523 HP</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 45,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="7">
                                    <button type="submit" class="book-link"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Card 8: Rolls-Royce Cullinan -->
                    <div class="arrival-card">
                        <div class="img-container">
                            <img src="${pageContext.request.contextPath}/images/car_hero.png"
                                alt="Rolls-Royce Cullinan">
                        </div>
                        <div class="arrival-info">
                            <div class="info-header">
                                <h3>Rolls-Royce Cullinan</h3>
                                <span class="badge danger">ULTRA LUXURY</span>
                            </div>
                            <div class="specs">
                                <div class="spec">
                                    <label>ENGINE</label>
                                    <span>6.75L V12</span>
                                </div>
                                <div class="spec">
                                    <label>POWER</label>
                                    <span>563 HP</span>
                                </div>
                            </div>
                            <div class="info-footer">
                                <div class="price"><span>NPR 1,20,000</span>/day</div>
                                <form action="book" method="post" style="margin:0;">
                                    <input type="hidden" name="carId" value="8">
                                    <button type="submit" class="book-link red"
                                        style="background:transparent; border:none; cursor:pointer; padding:0;">Book Now
                                        &rarr;</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Elevated Experience -->
            <section class="experience" id="services">
                <div class="glass-tray">
                    <img src="${pageContext.request.contextPath}/images/car_2.png" alt="Keys">
                    <div class="support-badge">
                        <span class="huge">24/7</span>
                        <span class="tiny">CONCIERGE SUPPORT</span>
                    </div>
                </div>
                <div class="exp-content">
                    <h2>ELEVATED EXPERIENCE</h2>
                    <p>Beyond just a rental, we provide a gateway to automotive mastery. Every vehicle is detailed to
                        concours standards and delivered directly to your location with our elite white-glove service.
                    </p>

                    <ul class="perk-list">
                        <li><span class="dot"></span> Full-Coverage Elite Insurance Included</li>
                        <li><span class="dot"></span> Complimentary Airport Delivery & Return</li>
                        <li><span class="dot"></span> Instant Booking Confirmation</li>
                    </ul>
                </div>
            </section>

            <footer class="landing-footer" id="contact">
                <div class="f-logo">RIDE NEPAL</div>
                <p>&copy; 2024 RIDE NEPAL. ALL RIGHTS RESERVED.</p>
                <div class="f-links">
                    <a href="#">PRIVACY POLICY</a>
                    <a href="#">TERMS OF SERVICE</a>
                    <a href="#">FLEET MANAGEMENT</a>
                    <a href="#">CAREERS</a>
                </div>
            </footer>
            <script>
            const contextPath = '${pageContext.request.contextPath}';
            const searchInput = document.getElementById('liveSearchInput');
            const resultsPanel = document.getElementById('liveSearchResults');

            searchInput.addEventListener('input', async (e) => {
                const query = e.target.value.trim();
                if (query.length < 2) {
                    resultsPanel.style.display = 'none';
                    return;
                }

                try {
                    const response = await fetch(`${contextPath}/api/search?query=` + encodeURIComponent(query));
                    const results = await response.json();
                    
                    if (results.length > 0) {
                        resultsPanel.innerHTML = results.map(car => `
                            <div class="search-item" onclick="selectCar(${car.id}, '${car.make} ${car.model}')">
                                <img src="${contextPath}/images/car_${car.id}.png" 
                                     onerror="this.src='${contextPath}/images/car_hero.png'" alt="${car.model}">
                                <div class="item-info">
                                    <span class="item-name">${car.make} ${car.model}</span>
                                    <span class="item-price">NPR ${car.pricePerDay}/day</span>
                                </div>
                            </div>
                        `).join('');
                        resultsPanel.style.display = 'block';
                    } else {
                        resultsPanel.innerHTML = '<div class="no-results">No model found</div>';
                        resultsPanel.style.display = 'block';
                    }
                } catch (err) {
                    console.error('Search error:', err);
                }
            });

            function selectCar(id, name) {
                searchInput.value = name;
                resultsPanel.style.display = 'none';
                // Update hidden input in the form
                document.querySelector('input[name="carId"]').value = id;
            }

            const navSearchInput = document.getElementById('navSearchInput');
            const navResultsPanel = document.getElementById('navSearchResults');

            navSearchInput.addEventListener('input', async (e) => {
                const query = e.target.value.trim();
                if (query.length < 2) {
                    navResultsPanel.style.display = 'none';
                    return;
                }

                try {
                    const response = await fetch(`${contextPath}/api/search?query=` + encodeURIComponent(query));
                    const results = await response.json();
                    
                    if (results.length > 0) {
                        navResultsPanel.innerHTML = results.map(car => `
                            <div class="search-item" onclick="selectNavCar(${car.id}, '${car.make} ${car.model}')">
                                <img src="${contextPath}/images/car_${car.id}.png" 
                                     onerror="this.src='${contextPath}/images/car_hero.png'" alt="${car.model}">
                                <div class="item-info">
                                    <span class="item-name">${car.make} ${car.model}</span>
                                    <span class="item-price">NPR ${car.pricePerDay}/day</span>
                                </div>
                            </div>
                        `).join('');
                        navResultsPanel.style.display = 'block';
                    } else {
                        navResultsPanel.innerHTML = '<div class="no-results">No model found</div>';
                        navResultsPanel.style.display = 'block';
                    }
                } catch (err) {
                    console.error('Search error:', err);
                }
            });

            function selectNavCar(id, name) {
                navSearchInput.value = name;
                navResultsPanel.style.display = 'none';
                window.location.href = `search?query=` + encodeURIComponent(name);
            }

            // Close panels when clicking outside
            document.addEventListener('click', (e) => {
                if (!e.target.closest('.live-search-field')) {
                    resultsPanel.style.display = 'none';
                }
                if (!e.target.closest('.nav-search-container')) {
                    navResultsPanel.style.display = 'none';
                }
            });
        </script>
    </body>
</html>