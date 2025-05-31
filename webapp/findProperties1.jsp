<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Details - Estate Agent Finder</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css">
    
    <!-- Google Maps API -->
    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&callback=myMap"></script>

    <style>
        :root {
            --dark-blue: #0a1f44;
            --darker-blue: #091632;
            --deepest-blue: #060d1f;
            --accent-blue: #4a90e2;
            --light-blue: #84ceeb;
            --text-light: #ffffff;
            --text-muted: #a0aec0;
            --glass-bg: rgba(10, 31, 68, 0.95);
            --glass-border: rgba(255, 255, 255, 0.1);
            --card-bg: rgba(9, 22, 50, 0.9);
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, var(--deepest-blue) 0%, var(--dark-blue) 100%);
            color: var(--text-light);
            min-height: 100vh;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 0;
        }

        .content-wrapper {
            position: relative;
            z-index: 1;
            padding: 2rem 0;
        }

        .property-details {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid var(--glass-border);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .property-image-gallery {
            position: relative;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .swiper {
            width: 100%;
            height: 400px;
            border-radius: 15px;
        }

        .swiper-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .property-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .feature-item {
            background: var(--card-bg);
            padding: 1rem;
            border-radius: 10px;
            border: 1px solid var(--glass-border);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .feature-icon {
            font-size: 1.5rem;
            color: var(--accent-blue);
        }

        .price-tag {
            font-size: 2rem;
            color: var(--accent-blue);
            font-weight: bold;
            margin: 1rem 0;
        }

        .agent-info {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 1.5rem;
            border: 1px solid var(--glass-border);
            margin-top: 2rem;
        }

        .agent-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 3px solid var(--accent-blue);
            padding: 2px;
        }

        .property-map {
            height: 400px;
            border-radius: 15px;
            margin-top: 2rem;
            overflow: hidden;
            border: 1px solid var(--glass-border);
        }

        .map-info-window {
            color: #333;
            padding: 10px;
        }

        .location-details {
            background: var(--card-bg);
            padding: 1rem;
            border-radius: 10px;
            margin-top: 1rem;
            border: 1px solid var(--glass-border);
        }

        .location-tag {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            background: var(--accent-blue);
            font-size: 0.9rem;
            margin: 0.2rem;
        }

        .amenity-tag {
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            margin: 0.5rem;
            display: inline-block;
        }

        .current-time {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid var(--glass-border);
            color: var(--accent-blue);
            z-index: 1000;
        }

        .btn-home {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--accent-blue);
            color: var(--text-light);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
            z-index: 1000;
        }

        .btn-home:hover {
            background: #357abd;
            color: var(--text-light);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(74, 144, 226, 0.5);
        }

        .btn-custom {
            background: var(--accent-blue);
            color: var(--text-light);
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background: #357abd;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <!-- Current Time Display -->
    <div class="current-time animate__animated animate__fadeIn">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-14 22:33:56</span>
    </div>

    <div class="content-wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <i class="fas fa-building me-2"></i>Estate Agent Finder
                </a>
                <div class="ms-auto d-flex align-items-center">
                    <div class="user-info me-3">
                        <!--  <span class="text-light">
                            <i class="fas fa-user me-2"></i>
                            <%= session.getAttribute("user") != null ? session.getAttribute("user") : "Krishmal2004" %>
                        </span>-->
                    </div>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="property-details animate__animated animate__fadeIn">
                <!-- Property Image Gallery -->
                <div class="property-image-gallery">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c" alt="Property Image 1">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://via.placeholder.com/800x400?text=Luxury+Villa+2" alt="Property Image 2">
                            </div>
                            <div class="swiper-slide">
                                <img src="https://via.placeholder.com/800x400?text=Luxury+Villa+3" alt="Property Image 3">
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </div>

                <!-- Property Title and Price -->
                <h1>Luxury Villa with Ocean View</h1>
                <div class="price-tag">$1,250,000</div>

                <!-- Property Features -->
                <div class="property-features">
                    <div class="feature-item">
                        <i class="fas fa-bed feature-icon"></i>
                        <div>
                            <h6 class="mb-0">Bedrooms</h6>
                            <p class="mb-0">4</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-bath feature-icon"></i>
                        <div>
                            <h6 class="mb-0">Bathrooms</h6>
                            <p class="mb-0">3.5</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-vector-square feature-icon"></i>
                        <div>
                            <h6 class="mb-0">Square Feet</h6>
                            <p class="mb-0">3,500</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-car feature-icon"></i>
                        <div>
                            <h6 class="mb-0">Garage</h6>
                            <p class="mb-0">2 Cars</p>
                        </div>
                    </div>
                </div>

                <!-- Property Description -->
                <h3>Description</h3>
                <p>Luxurious oceanfront villa featuring modern architecture and premium finishes. This stunning property offers panoramic ocean views, spacious living areas, and high-end amenities. Perfect for those seeking an exclusive lifestyle in a prime location.</p>

                <!-- Amenities -->
                <h3>Amenities</h3>
                <div class="amenities">
                    <span class="amenity-tag"><i class="fas fa-swimming-pool me-2"></i>Pool</span>
                    <span class="amenity-tag"><i class="fas fa-hot-tub me-2"></i>Spa</span>
                    <span class="amenity-tag"><i class="fas fa-dumbbell me-2"></i>Gym</span>
                    <span class="amenity-tag"><i class="fas fa-shield-alt me-2"></i>Security System</span>
                    <span class="amenity-tag"><i class="fas fa-wifi me-2"></i>Smart Home</span>
                </div>

                <!-- Agent Information -->
                <div class="agent-info">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <div class="d-flex align-items-center">
                                <img src="https://ui-avatars.com/api/?name=John+Smith&background=random" 
                                     class="agent-avatar me-3" alt="Agent">
                                <div>
                                    <h4>John Smith</h4>
                                    <p class="mb-0"><i class="fas fa-phone me-2"></i>+1 234 567 8900</p>
                                    <p class="mb-0"><i class="fas fa-envelope me-2"></i>john.smith@example.com</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 text-md-end mt-3 mt-md-0">
                            <button class="btn btn-custom">
                                <i class="fas fa-calendar-alt me-2"></i>Schedule Viewing
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Property Location Section -->
                <h3 class="mt-4">Location</h3>
                <div class="row">
                    <div class="col-md-8">
                        <div class="property-map" id="propertyMap"></div>
                    </div>
                    <div class="col-md-4">
                        <div class="location-details">
                            <h4><i class="fas fa-map-marker-alt me-2"></i>Property Location</h4>
                            <p>123 Ocean View Drive</p>
                            <p>Malibu, California 90265</p>
                            <p>United States</p>
                            
                            <div class="mt-3">
                                <h5>Nearby Amenities:</h5>
                                <span class="location-tag"><i class="fas fa-school me-2"></i>Schools</span>
                                <span class="location-tag"><i class="fas fa-shopping-cart me-2"></i>Shopping</span>
                                <span class="location-tag"><i class="fas fa-hospital me-2"></i>Hospital</span>
                                <span class="location-tag"><i class="fas fa-bus me-2"></i>Transport</span>
                            </div>

                            <div class="mt-3">
                                <h5>Distance To:</h5>
                                <p><i class="fas fa-plane me-2"></i>LAX Airport: 20 miles</p>
                                <p><i class="fas fa-city me-2"></i>Downtown LA: 30 miles</p>
                                <p><i class="fas fa-umbrella-beach me-2"></i>Beach: 0.2 miles</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Home Button -->
        <a href="index.jsp" class="btn-home animate__animated animate__pulse animate__infinite animate__slower" title="Go to Homepage">
            <i class="fas fa-home"></i>
        </a>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
    
    <script>
        // Initialize Swiper
        const swiper = new Swiper('.swiper', {
            loop: true,
            pagination: {
                el: '.swiper-pagination',
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            }
        });

        // Initialize Google Map
        function initMap() {
            const propertyLocation = {
                lat: 34.0259,
                lng: -118.7798
            };

            const map = new google.maps.Map(document.getElementById('propertyMap'), {
                center: propertyLocation,
                zoom: 13,
                styles: [
                    {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [{"color": "#193341"}]
                    },
                    {
                        "featureType": "landscape",
                        "elementType": "geometry",
                        "stylers": [{"color": "#2c5a71"}]
                    },
                    {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                            {"color": "#29768a"},
                            {"lightness": -37}
                        ]
                    },
                    {
                        "featureType": "poi",
                        "elementType": "geometry",
                        "stylers": [{"color": "#406d80"}]
                    },
                    {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [{"color": "#406d80"}]
                    }
                ]
            });

            const marker = new google.maps.Marker({
                position: propertyLocation,
                map: map,
                title: 'Luxury Villa with Ocean View',
                animation: google.maps.Animation.DROP
            });

            const contentString = `
                <div class="map-info-window">
                    <h5>Luxury Villa with Ocean View</h5>
                    <p>123 Ocean View Drive<br>
                    Malibu, CA 90265</p>
                    <p><strong>Price:</strong> $1,250,000</p>
                </div>
            `;

            const infowindow = new google.maps.InfoWindow({
                content: contentString
            });

            marker.addListener('click', () => {
                infowindow.open(map, marker);
            });

            const nearbyPlaces = [
                {
                    position: { lat: 34.0269, lng: -118.7758 },
                    title: 'Shopping Center',
                    icon: 'https://maps.google.com/mapfiles/ms/icons/blue-dot.png'
                },
                {
                    position: { lat: 34.0279, lng: -118.7818 },
                    title: 'Beach Access',
                    icon: 'https://maps.google.com/mapfiles/ms/icons/yellow-dot.png'
                },
                {
                    position: { lat: 34.0239, lng: -118.7778 },
                    title: 'School',
                    icon: 'https://maps.google.com/mapfiles/ms/icons/green-dot.png'
                }
            ];

            nearbyPlaces.forEach(place => {
                new google.maps.Marker({
                    position: place.position,
                    map: map,
                    title: place.title,
                    icon: place.icon
                });
            });
        }

        // Update current time
        function updateTime() {
            const timeElement = document.getElementById('current-time');
            const now = new Date();
            const formattedTime = now.toISOString().slice(0, 19).replace('T', ' ');
            timeElement.textContent = formattedTime;
        }
        
        // Initialize when document is ready
        $(document).ready(function() {
            initMap();
            setInterval(updateTime, 1000);
        });
    </script>
</body>
</html>