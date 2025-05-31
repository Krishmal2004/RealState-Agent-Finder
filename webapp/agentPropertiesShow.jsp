<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Properties | Real Estate Portal</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@splidejs/splide@4.1.4/dist/css/splide.min.css">

    <style>
        :root {
            --primary-dark: #0A192F;
            --primary-medium: #112240;
            --primary-light: #1E3A8A;
            --accent-blue: #3B82F6;
            --accent-cyan: #06B6D4;
            --text-white: #F8FAFC;
            --text-light: #CBD5E1;
            --text-muted: #94A3B8;
            --border-color: rgba(203, 213, 225, 0.1);
            --gradient-start: rgba(10, 25, 47, 0.95);
            --gradient-end: rgba(17, 34, 64, 0.95);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            color: var(--text-light);
            min-height: 100vh;
        }

        .floating-search {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background: rgba(10, 25, 47, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem 2rem;
            transition: all 0.3s ease;
        }

        .search-collapsed {
            transform: translateY(-100%);
        }

        .main-container {
            padding: 7rem 2rem 2rem 2rem;
        }

        .property-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        .property-card {
            background: rgba(17, 34, 64, 0.7);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .splide__slide img {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }

        .property-info {
            padding: 1.5rem;
        }

        .price-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-cyan));
            color: var(--text-white);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            z-index: 10;
        }

        .status-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            z-index: 10;
        }

        .status-sale {
            background-color: rgba(16, 185, 129, 0.2);
            color: #10B981;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-rent {
            background-color: rgba(245, 158, 11, 0.2);
            color: #F59E0B;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .property-details {
            display: flex;
            gap: 1.5rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            font-size: 0.875rem;
        }

        .property-title {
            color: var(--text-white);
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .property-location {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            font-size: 0.875rem;
            margin-bottom: 1rem;
        }

        .search-section {
            background: rgba(30, 58, 138, 0.3);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .search-input {
            background: rgba(10, 25, 47, 0.5);
            border: 1px solid var(--border-color);
            color: var(--text-white);
            border-radius: 8px;
            padding: 0.75rem 1rem;
        }
        .search-input::placeholder {
    		color: var(--text-muted); /* Makes placeholder text slightly dimmer */
		}
		
        .search-input:focus {
            border-color: var(--accent-cyan);
            box-shadow: 0 0 0 2px rgba(6, 182, 212, 0.2);
            background: rgba(10, 25, 47, 0.7);
            color: var(--text-white) !important;
        }

        .amenity-tag {
            background: rgba(59, 130, 246, 0.1);
            color: var(--accent-blue);
            border: 1px solid rgba(59, 130, 246, 0.2);
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.75rem;
            display: inline-block;
            margin: 0.25rem;
        }

        .splide__arrow {
            background: rgba(10, 25, 47, 0.8);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .property-card:hover .splide__arrow {
            opacity: 1;
        }

        .splide__pagination__page {
            background: rgba(255, 255, 255, 0.3);
        }

        .splide__pagination__page.is-active {
            background: var(--accent-cyan);
        }

    </style>
</head>
<body>
    <!-- Floating Search Bar -->
    <div class="floating-search">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-auto">
                    <div class="d-flex align-items-center gap-3">
                        <i class="fas fa-building text-accent-blue fs-4"></i>
                        <div>
                            <h5 class="mb-0 text-white">Property Listings</h5>
                            <small class="text-muted">
                                <i class="far fa-clock me-1"></i>
                                 2025-03-21 18:52:06
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <input type="text" class="form-control search-input" placeholder="Search properties...">
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input">
                                <option>Property Type</option>
                                <option>House</option>
                                <option>Apartment</option>
                                <option>Villa</option>
                                <option>Commercial</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input">
                                <option>Price Range</option>
                                <option>$100k - $200k</option>
                                <option>$200k - $500k</option>
                                <option>$500k - $1M</option>
                                <option>$1M+</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input">
                                <option>Bedrooms</option>
                                <option>1+</option>
                                <option>2+</option>
                                <option>3+</option>
                                <option>4+</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input">
                                <option>Sort By</option>
                                <option>Price: Low to High</option>
                                <option>Price: High to Low</option>
                                <option>Newest First</option>
                                <option>Most Popular</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <button class="btn btn-primary w-100">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-container">
        <div class="property-grid">
            <!-- Inside the property-grid div -->

<!-- Luxury Villa Property -->
<div class="property-card">
    <div class="splide">
        <div class="splide__track">
            <ul class="splide__list">
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1613977257363-707ba9348227" alt="Luxury Villa">
                </li>
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1613977257592-4871e5fcd7c4" alt="Villa Interior">
                </li>
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1613977257401-b1a01c3491a9" alt="Villa Pool">
                </li>
            </ul>
        </div>
    </div>
    <div class="price-badge">$1,250,000</div>
    <div class="status-badge status-sale">For Sale</div>
    <div class="property-info">
        <h3 class="property-title">Grand Luxury Villa with Ocean View</h3>
        <div class="property-location">
            <i class="fas fa-map-marker-alt text-accent-cyan"></i>
            78 Coastal Avenue, Colombo 03
        </div>
        <div class="property-details">
            <div class="detail-item">
                <i class="fas fa-bed text-accent-blue"></i>
                5 Beds
            </div>
            <div class="detail-item">
                <i class="fas fa-bath text-accent-blue"></i>
                4 Baths
            </div>
            <div class="detail-item">
                <i class="fas fa-ruler-combined text-accent-blue"></i>
                4,200 sqft
            </div>
        </div>
        <div class="mt-3">
            <span class="amenity-tag">Infinity Pool</span>
            <span class="amenity-tag">Ocean View</span>
            <span class="amenity-tag">Smart Home</span>
            <span class="amenity-tag">Security</span>
        </div>
    </div>
</div>

<!-- Modern Apartment -->
<div class="property-card">
    <div class="splide">
        <div class="splide__track">
            <ul class="splide__list">
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267" alt="Modern Apartment">
                </li>
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6" alt="Apartment Interior">
                </li>
            </ul>
        </div>
    </div>
    <div class="price-badge">$350,000</div>
    <div class="status-badge status-sale">For Sale</div>
    <div class="property-info">
        <h3 class="property-title">Modern City Center Apartment</h3>
        <div class="property-location">
            <i class="fas fa-map-marker-alt text-accent-cyan"></i>
            45 Urban Square, Colombo 02
        </div>
        <div class="property-details">
            <div class="detail-item">
                <i class="fas fa-bed text-accent-blue"></i>
                2 Beds
            </div>
            <div class="detail-item">
                <i class="fas fa-bath text-accent-blue"></i>
                2 Baths
            </div>
            <div class="detail-item">
                <i class="fas fa-ruler-combined text-accent-blue"></i>
                1,100 sqft
            </div>
        </div>
        <div class="mt-3">
            <span class="amenity-tag">City View</span>
            <span class="amenity-tag">Gym</span>
            <span class="amenity-tag">Parking</span>
        </div>
    </div>
</div>

<!-- Beach House -->
<div class="property-card">
    <div class="splide">
        <div class="splide__track">
            <ul class="splide__list">
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1499793983690-e29da59ef1c2" alt="Beach House">
                </li>
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1499916078039-922301b0eb9b" alt="Beach View">
                </li>
            </ul>
        </div>
    </div>
    <div class="price-badge">$4,500/mo</div>
    <div class="status-badge status-rent">For Rent</div>
    <div class="property-info">
        <h3 class="property-title">Luxury Beach House</h3>
        <div class="property-location">
            <i class="fas fa-map-marker-alt text-accent-cyan"></i>
            23 Beach Road, Mount Lavinia
        </div>
        <div class="property-details">
            <div class="detail-item">
                <i class="fas fa-bed text-accent-blue"></i>
                3 Beds
            </div>
            <div class="detail-item">
                <i class="fas fa-bath text-accent-blue"></i>
                2 Baths
            </div>
            <div class="detail-item">
                <i class="fas fa-ruler-combined text-accent-blue"></i>
                2,300 sqft
            </div>
        </div>
        <div class="mt-3">
            <span class="amenity-tag">Beach Front</span>
            <span class="amenity-tag">Private Garden</span>
            <span class="amenity-tag">BBQ Area</span>
        </div>
    </div>
</div>

<!-- Penthouse Apartment -->
<div class="property-card">
    <div class="splide">
        <div class="splide__track">
            <ul class="splide__list">
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1545324418-cc1a3fa10c00" alt="Penthouse">
                </li>
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1545324418-cc1a3fa10c01" alt="Penthouse View">
                </li>
            </ul>
        </div>
    </div>
    <div class="price-badge">$750,000</div>
    <div class="status-badge status-sale">For Sale</div>
    <div class="property-info">
        <h3 class="property-title">Luxury Penthouse Suite</h3>
        <div class="property-location">
            <i class="fas fa-map-marker-alt text-accent-cyan"></i>
            120 Sky Tower, Colombo 01
        </div>
        <div class="property-details">
            <div class="detail-item">
                <i class="fas fa-bed text-accent-blue"></i>
                4 Beds
            </div>
            <div class="detail-item">
                <i class="fas fa-bath text-accent-blue"></i>
                3 Baths
            </div>
            <div class="detail-item">
                <i class="fas fa-ruler-combined text-accent-blue"></i>
                3,000 sqft
            </div>
        </div>
        <div class="mt-3">
            <span class="amenity-tag">Panoramic View</span>
            <span class="amenity-tag">Private Pool</span>
            <span class="amenity-tag">Helipad Access</span>
            <span class="amenity-tag">Premium Finishes</span>
        </div>
    </div>
</div>

<!-- Family Home -->
<div class="property-card">
    <div class="splide">
        <div class="splide__track">
            <ul class="splide__list">
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1570129477492-45c003edd2be" alt="Family Home">
                </li>
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1570129477492-45c003edd2bf" alt="Home Garden">
                </li>
            </ul>
        </div>
    </div>
    <div class="price-badge">$425,000</div>
    <div class="status-badge status-sale">For Sale</div>
    <div class="property-info">
        <h3 class="property-title">Spacious Family Home</h3>
        <div class="property-location">
            <i class="fas fa-map-marker-alt text-accent-cyan"></i>
            56 Green Lane, Nawala
        </div>
        <div class="property-details">
            <div class="detail-item">
                <i class="fas fa-bed text-accent-blue"></i>
                4 Beds
            </div>
            <div class="detail-item">
                <i class="fas fa-bath text-accent-blue"></i>
                3 Baths
            </div>
            <div class="detail-item">
                <i class="fas fa-ruler-combined text-accent-blue"></i>
                2,800 sqft
            </div>
        </div>
        <div class="mt-3">
            <span class="amenity-tag">Garden</span>
            <span class="amenity-tag">Double Garage</span>
            <span class="amenity-tag">Solar Powered</span>
        </div>
    </div>
</div>

<!-- Studio Apartment -->
<div class="property-card">
    <div class="splide">
        <div class="splide__track">
            <ul class="splide__list">
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267" alt="Studio">
                </li>
                <li class="splide__slide">
                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0268" alt="Studio Interior">
                </li>
            </ul>
        </div>
    </div>
    <div class="price-badge">$2,000/mo</div>
    <div class="status-badge status-rent">For Rent</div>
    <div class="property-info">
        <h3 class="property-title">Modern Studio Apartment</h3>
        <div class="property-location">
            <i class="fas fa-map-marker-alt text-accent-cyan"></i>
            89 Metro Complex, Colombo 04
        </div>
        <div class="property-details">
            <div class="detail-item">
                <i class="fas fa-bed text-accent-blue"></i>
                1 Bed
            </div>
            <div class="detail-item">
                <i class="fas fa-bath text-accent-blue"></i>
                1 Bath
            </div>
            <div class="detail-item">
                <i class="fas fa-ruler-combined text-accent-blue"></i>
                600 sqft
            </div>
        </div>
        <div class="mt-3">
            <span class="amenity-tag">Furnished</span>
            <span class="amenity-tag">City View</span>
            <span class="amenity-tag">24/7 Security</span>
        </div>
    </div>
</div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@splidejs/splide@4.1.4/dist/js/splide.min.js"></script>
    <script>
        // Initialize all Splide sliders
        document.addEventListener('DOMContentLoaded', function() {
            const splides = document.getElementsByClassName('splide');
            for (const splide of splides) {
                new Splide(splide, {
                    type: 'loop',
                    perPage: 1,
                    autoplay: false,
                    pauseOnHover: true,
                    arrows: true,
                    pagination: true,
                    interval: 3000,
                }).mount();
            }
        });

        // Floating search bar behavior
        let lastScroll = 0;
        const floatingSearch = document.querySelector('.floating-search');
        
        window.addEventListener('scroll', () => {
            const currentScroll = window.pageYOffset;
            
            if (currentScroll <= 0) {
                floatingSearch.classList.remove('search-collapsed');
            }
            else if (currentScroll > lastScroll && !floatingSearch.classList.contains('search-collapsed')) {
                floatingSearch.classList.add('search-collapsed');
            }
            else if (currentScroll < lastScroll && floatingSearch.classList.contains('search-collapsed')) {
                floatingSearch.classList.remove('search-collapsed');
            }
            
            lastScroll = currentScroll;
        });
    </script>
</body>
</html>