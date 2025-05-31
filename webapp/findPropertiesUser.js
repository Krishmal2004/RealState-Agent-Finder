/**
 * Property Finder - Comprehensive Property Listings Application
 * 
 * Current User: IT24103866
 * Session Time: 2025-03-25 21:54:44
 * 
 * Features:
 * - Complete property details for all listings
 * - Dynamic filtering and sorting
 * - Infinite scrolling with animated loading
 * - Interactive property cards with animations
 * - Detailed property modal views
 * - Agent contact system
 */

$(document).ready(function() {
    // Global variables
    let page = 1;
    let loading = false;
    let allPropertiesLoaded = false;
    let currentFilters = {};
    let currentPropertyId = null;
    const PAGE_SIZE = 6;
    
    // Mock data - Complete Properties dataset with full details
    const ALL_PROPERTIES = [
        {
            id: 1,
            title: "Modern Downtown Apartment",
            price: 350000,
            bedrooms: 2,
            bathrooms: 2,
            sqft: 1200,
            shortDescription: "Modern apartment with stunning city views",
            imageUrl: "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YXBhcnRtZW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            propertyType: "apartment",
            location: "downtown",
            yearBuilt: 2018,
            address: "123 Main Street, Downtown, City",
            fullDescription: "This modern downtown apartment features floor-to-ceiling windows with stunning city views. The open floor plan includes a gourmet kitchen with stainless steel appliances and quartz countertops. The master suite includes a walk-in closet and en-suite bathroom with rainfall shower. Building amenities include 24-hour security, a fitness center, and rooftop terrace.",
            mainImageUrl: "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YXBhcnRtZW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-15",
            images: [
                "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YXBhcnRtZW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGFwYXJ0bWVudCUyMGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1564078516393-cf04bd966897?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bW9kZXJuJTIwYmF0aHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1560185127-6ed189bf02f4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YXBhcnRtZW50JTIwbGl2aW5nJTIwcm9vbXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Central Air Conditioning",
                "In-unit Washer/Dryer",
                "Fitness Center",
                "Concierge Service",
                "Underground Parking",
                "Pet Friendly",
                "Hardwood Floors",
                "Stainless Steel Appliances",
                "Quartz Countertops"
            ],
            agent: {
                id: 1,
                name: "John Smith",
                phone: "(555) 123-4567",
                email: "john@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                position: "Senior Agent",
                agency: "Premium Realty"
            }
        },
        {
            id: 2,
            title: "Spacious Family Home",
            price: 520000,
            bedrooms: 4,
            bathrooms: 3.5,
            sqft: 2800,
            shortDescription: "Perfect home for growing families in a quiet neighborhood",
            imageUrl: "https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            propertyType: "house",
            location: "suburb",
            yearBuilt: 2010,
            address: "456 Oak Lane, Pleasant Hills, Suburb",
            fullDescription: "This beautiful family home offers ample space for comfortable living and entertaining. Features include a gourmet kitchen with island, formal dining room, large family room with fireplace, and master suite with luxury bathroom. The fenced backyard includes a covered patio, landscaped garden, and play area. Located in the award-winning Pleasant Hills school district.",
            mainImageUrl: "https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-10",
            images: [
                "https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1484154218962-a197022b5858?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8YmVkcm9vbXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1576941089067-2de3c901e126?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGJhY2t5YXJkfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Two-car Garage",
                "Central Heating/Air",
                "Fireplace",
                "Finished Basement",
                "Fenced Yard",
                "Walk-in Closets",
                "Home Office",
                "Granite Countertops",
                "Energy Efficient Windows",
                "Sprinkler System"
            ],
            agent: {
                id: 2,
                name: "Maria Garcia",
                phone: "(555) 234-5678",
                email: "maria@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
                position: "Luxury Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 3,
            title: "Luxury Beachfront Villa",
            price: 1250000,
            bedrooms: 5,
            bathrooms: 4,
            sqft: 3500,
            shortDescription: "Exclusive beachfront property with private access",
            imageUrl: "https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHZpbGxhfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            propertyType: "villa",
            location: "beachfront",
            yearBuilt: 2015,
            address: "789 Coastal Highway, Beachside, Oceanview",
            fullDescription: "Experience luxury beachfront living in this stunning villa with panoramic ocean views. This architectural masterpiece features high ceilings, wall-to-wall windows, and an open concept design that maximizes the breathtaking vistas. The gourmet kitchen includes premium appliances, custom cabinetry, and a large center island. The master suite offers a private balcony, spa-like bathroom, and walk-in closet. Additional features include a home theater, wine cellar, infinity pool, and direct beach access.",
            mainImageUrl: "https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHZpbGxhfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-02-28",
            images: [
                "https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHZpbGxhfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1602343168117-bb8ffe3e2e9f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fGx1eHVyeSUyMGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1615874959474-d609969a20ed?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmVhY2glMjB2aWV3fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1572331165267-854da2b3cec3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bHV4dXJ5JTIwYmVkcm9vbXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Private Beach Access",
                "Infinity Pool",
                "Smart Home System",
                "Wine Cellar",
                "Home Theater",
                "Outdoor Kitchen",
                "Multi-car Garage",
                "Security System",
                "Solar Panels",
                "Guest House",
                "Elevator",
                "Spa/Hot Tub"
            ],
            agent: {
                id: 3,
                name: "David Johnson",
                phone: "(555) 345-6789",
                email: "david@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/59.jpg",
                position: "Luxury Property Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 4,
            title: "Modern Studio Apartment",
            price: 175000,
            bedrooms: 1,
            bathrooms: 1,
            sqft: 650,
            shortDescription: "Cozy studio perfect for young professionals",
            imageUrl: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXBhcnRtZW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            propertyType: "apartment",
            location: "downtown",
            yearBuilt: 2019,
            address: "555 Urban Lofts, Downtown, City",
            fullDescription: "This stylish studio apartment is the perfect urban retreat for young professionals. Thoughtfully designed to maximize space, it features high ceilings, large windows providing abundant natural light, and modern fixtures. The kitchen is equipped with energy-efficient appliances, quartz countertops, and stylish backsplash. Building amenities include a rooftop lounge, fitness center, and bicycle storage. Located in a vibrant downtown neighborhood with easy access to public transportation, restaurants, and entertainment.",
            mainImageUrl: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXBhcnRtZW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-18",
            images: [
                "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXBhcnRtZW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1499916078039-922301b0eb9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHN0dWRpbyUyMGFwYXJ0bWVudHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1489171078254-c3365d6e359f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YXBhcnRtZW50JTIwa2l0Y2hlbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1583845112203-29329902332e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGFwYXJ0bWVudCUyMGJhdGhyb29tfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Rooftop Lounge",
                "Fitness Center",
                "Energy Efficient Appliances",
                "Quartz Countertops",
                "Bicycle Storage",
                "In-unit Laundry",
                "Smart Home Features",
                "Pet Friendly",
                "High-Speed Internet Ready",
                "Keyless Entry"
            ],
            agent: {
                id: 1,
                name: "John Smith",
                phone: "(555) 123-4567",
                email: "john@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                position: "Senior Agent",
                agency: "Premium Realty"
            }
        },
        {
            id: 5,
            title: "Rural Farmhouse with Land",
            price: 450000,
            bedrooms: 3,
            bathrooms: 2,
            sqft: 2200,
            shortDescription: "Charming farmhouse with 5 acres of land",
            imageUrl: "https://images.unsplash.com/photo-1572120360610-d971b9d7767c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGZhcm1ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
            propertyType: "house",
            location: "rural",
            yearBuilt: 1985,
            address: "1234 Country Road, Rural County",
            fullDescription: "Escape to the countryside with this beautifully renovated farmhouse on 5 acres of scenic land. The home blends rustic charm with modern amenities, featuring exposed beams, hardwood floors, and a wood-burning fireplace. The updated kitchen offers stainless steel appliances, a farmhouse sink, and custom cabinetry. Outside, you'll find a wrap-around porch, detached garage/workshop, small barn, and fenced areas for animals. The property includes a mix of pasture and wooded land, with a small pond. Perfect for those seeking peace and privacy while being just a 25-minute drive from town amenities.",
            mainImageUrl: "https://images.unsplash.com/photo-1572120360610-d971b9d7767c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGZhcm1ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-05",
            images: [
                "https://images.unsplash.com/photo-1572120360610-d971b9d7767c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGZhcm1ob3VzZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1561470508-d9c7b5a601e3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGZhcm1ob3VzZSUyMGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1575517111839-3a3843ee7f5d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGZhcm1sYW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvcGVydHl8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "5 Acres of Land",
                "Wrap-around Porch",
                "Wood-burning Fireplace",
                "Updated Kitchen",
                "Hardwood Floors",
                "Detached Workshop",
                "Small Barn",
                "Fenced Areas",
                "Pond",
                "Well Water",
                "Septic System",
                "Renovated Bathrooms"
            ],
            agent: {
                id: 2,
                name: "Maria Garcia",
                phone: "(555) 234-5678",
                email: "maria@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
                position: "Rural Property Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 6,
            title: "Downtown Luxury Condo",
            price: 620000,
            bedrooms: 2,
            bathrooms: 2.5,
            sqft: 1500,
            shortDescription: "High-end condo with premium amenities",
            imageUrl: "https://images.unsplash.com/photo-1551361415-69c87624334f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29uZG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            propertyType: "condo",
            location: "downtown",
            yearBuilt: 2017,
            address: "888 Luxury Tower, Financial District, City",
            fullDescription: "Indulge in downtown luxury living in this exquisite condo with panoramic city views. Located in the prestigious Luxury Tower, this residence features premium finishes throughout, including imported marble, hardwood flooring, and custom lighting. The chef's kitchen is equipped with Wolf and Sub-Zero appliances, waterfall quartz countertops, and custom cabinetry. The primary suite offers a walk-in closet and spa-inspired bathroom with soaking tub and rainfall shower. Building amenities include 24/7 concierge, rooftop infinity pool, state-of-the-art fitness center, resident lounge, and secure parking. Walking distance to fine dining, shopping, and entertainment.",
            mainImageUrl: "https://images.unsplash.com/photo-1551361415-69c87624334f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29uZG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-12",
            images: [
                "https://images.unsplash.com/photo-1551361415-69c87624334f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29uZG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1617104678098-de229db51175?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGx1eHVyeSUyMGxpdmluZyUyMHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1560185893-a55cbc8c57e8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bHV4dXJ5JTIwYmF0aHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "24/7 Concierge",
                "Rooftop Infinity Pool",
                "Premium Fitness Center",
                "Resident Lounge",
                "Secure Parking",
                "Wolf & Sub-Zero Appliances",
                "Imported Marble Counters",
                "Floor-to-Ceiling Windows",
                "Custom Lighting",
                "Home Automation System",
                "Wine Refrigerator",
                "Electric Vehicle Charging"
            ],
            agent: {
                id: 3,
                name: "David Johnson",
                phone: "(555) 345-6789",
                email: "david@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/59.jpg",
                position: "Luxury Condo Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 7,
            title: "Suburban Family House",
            price: 385000,
            bedrooms: 3,
            bathrooms: 2,
            sqft: 2000,
            shortDescription: "Well-maintained family home with large backyard",
            imageUrl: "https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            propertyType: "house",
            location: "suburb",
            yearBuilt: 2005,
            address: "42 Maple Street, Pleasant Valley, Suburb",
            fullDescription: "Welcome to this charming family home nestled in the desirable Pleasant Valley neighborhood. This well-maintained residence offers three bedrooms, two bathrooms, and an open floor plan perfect for family living. The bright kitchen features solid oak cabinets, granite countertops, and stainless steel appliances. The spacious living room includes a gas fireplace and flows into the dining area. The backyard is an outdoor oasis with a covered patio, landscaping, and plenty of room for play and entertainment. Conveniently located near excellent schools, parks, shopping, and easy commuting routes.",
            mainImageUrl: "https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-09",
            images: [
                "https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1593696140826-c58b021acf8b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bGl2aW5nJTIwcm9vbXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1591825729269-caeb344f6df2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fGJhY2t5YXJkfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Two-car Garage",
                "Gas Fireplace",
                "Granite Countertops",
                "Stainless Steel Appliances", 
                "Central Air Conditioning",
                "New Roof (2023)",
                "Covered Patio",
                "Landscaped Yard",
                "Security System",
                "Energy Efficient Windows",
                "Master Suite with Walk-in Closet",
                "Near Top-rated Schools"
            ],
            agent: {
                id: 1,
                name: "John Smith",
                phone: "(555) 123-4567",
                email: "john@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                position: "Residential Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 8,
            title: "Beachside Condo",
            price: 495000,
            bedrooms: 2,
            bathrooms: 2,
            sqft: 1100,
            shortDescription: "Beautiful condo with ocean views",
            imageUrl: "https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y29uZG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            propertyType: "condo",
            location: "beachfront",
            yearBuilt: 2012,
            address: "333 Seabreeze Lane, Oceanview Condos, Beach City",
            fullDescription: "Wake up to the sound of waves in this stunning beachside condo featuring breathtaking ocean views. This beautifully maintained 2-bedroom residence offers an open floor plan, high ceilings, and a large balcony perfect for enjoying sunsets over the water. The modern kitchen includes granite countertops, tile backsplash, and stainless steel appliances. The master bedroom features an en-suite bathroom and access to the balcony. Oceanview Condos offers resort-style amenities including a heated oceanfront pool, fitness center, clubhouse, and private beach access. Located near restaurants, shops, and recreational activities.",
            mainImageUrl: "https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y29uZG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-07",
            images: [
                "https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y29uZG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1613553507747-5f8d62ad5904?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8b2NlYW4lMjB2aWV3fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGFwYXJ0bWVudCUyMGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1512929328064-c75ee2b89199?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cG9vbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Ocean Views",
                "Private Balcony",
                "Heated Oceanfront Pool",
                "Fitness Center",
                "Clubhouse",
                "Private Beach Access",
                "Secured Entry",
                "Covered Parking",
                "Storage Unit",
                "Elevator Access",
                "Hurricane Impact Windows",
                "Pet Friendly"
            ],
            agent: {
                id: 2,
                name: "Maria Garcia",
                phone: "(555) 234-5678",
                email: "maria@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
                position: "Coastal Property Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 9,
            title: "Mountain View Cabin",
            price: 320000,
            bedrooms: 3,
            bathrooms: 1,
            sqft: 1500,
            shortDescription: "Rustic cabin with breathtaking mountain views",
            imageUrl: "https://images.unsplash.com/photo-1587061949409-02df41d5e562?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FiaW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            propertyType: "house",
            location: "rural",
            yearBuilt: 1998,
            address: "77 Pine Ridge Road, Mountain Valley",
            fullDescription: "Escape to this charming cabin nestled in the mountains with spectacular views from every window. This authentic retreat features knotty pine interiors, a stone fireplace, and large windows that bring the outdoors in. The open concept living area is perfect for family gatherings, while the country kitchen provides ample space for preparing meals. A large wraparound deck invites outdoor dining and relaxation while enjoying the pristine surroundings. Situated on 2 wooded acres, this property offers privacy and access to hiking trails. An ideal year-round residence or vacation getaway.",
            mainImageUrl: "https://images.unsplash.com/photo-1587061949409-02df41d5e562?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FiaW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-02",
            images: [
                "https://images.unsplash.com/photo-1587061949409-02df41d5e562?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FiaW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1596178065887-1198b6148b2b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2FiaW4lMjBpbnRlcmlvcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1489582341401-cec42aac46c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1vdW50YWluJTIwdmlld3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1568365851292-ff4c3517add0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y2FiaW4lMjBvdXRkb29yfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Mountain Views",
                "2 Wooded Acres",
                "Stone Fireplace",
                "Knotty Pine Interior",
                "Wraparound Deck",
                "Vaulted Ceilings",
                "Wood Stove",
                "Well Water",
                "Septic System",
                "Metal Roof",
                "Attached Carport",
                "Access to Hiking Trails"
            ],
            agent: {
                id: 3,
                name: "David Johnson",
                phone: "(555) 345-6789",
                email: "david@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/59.jpg",
                position: "Mountain Property Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 10,
            title: "Modern Townhouse",
            price: 425000,
            bedrooms: 3,
            bathrooms: 2.5,
            sqft: 1800,
            shortDescription: "Contemporary townhome with rooftop terrace",
            imageUrl: "https://images.unsplash.com/photo-1625602812206-5ec545ca1231?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG93bmhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            propertyType: "condo",
            location: "suburb",
            yearBuilt: 2020,
            address: "144 Urban Heights, Modern Village, Suburb",
            fullDescription: "Experience modern living in this stylish townhome featuring sleek design and premium finishes. The open floor plan includes a gourmet kitchen with quartz countertops, custom cabinetry, and high-end appliances. The living area features hardwood floors and a gas fireplace. The primary bedroom suite includes a walk-in closet and spa-inspired bathroom. One of this home's highlights is the private rooftop terrace perfect for entertaining or relaxing under the stars. Additional features include a two-car garage, energy-efficient systems, and smart home technology. Located in a pedestrian-friendly community with community pool and green spaces. Minutes from shopping, dining, and major transportation routes.",
            mainImageUrl: "https://images.unsplash.com/photo-1625602812206-5ec545ca1231?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG93bmhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-14",
            images: [
                "https://images.unsplash.com/photo-1625602812206-5ec545ca1231?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dG93bmhvdXNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1600210492486-724fe5c67fb3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG1vZGVybiUyMGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1588854337236-6889d631faa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHJvb2Z0b3AlMjB0ZXJyYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1583608205463-438b0fe30337?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGxpdmluZyUyMHJvb218ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Rooftop Terrace",
                "Two-car Garage",
                "Smart Home Technology",
                "Gas Fireplace",
                "Quartz Countertops",
                "Hardwood Floors",
                "High Ceilings",
                "Energy Star Appliances",
                "Community Pool",
                "Walk-in Closets",
                "Nest Thermostat",
                "Ring Doorbell System"
            ],
            agent: {
                id: 1,
                name: "John Smith",
                phone: "(555) 123-4567",
                email: "john@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                position: "Urban Property Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 11,
            title: "Historic City Apartment",
            price: 550000,
            bedrooms: 2,
            bathrooms: 1,
            sqft: 1100,
            shortDescription: "Restored apartment in historic building",
            imageUrl: "https://images.unsplash.com/photo-1493809842364-78817add7ffb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGFwYXJ0bWVudHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
            propertyType: "apartment",
            location: "downtown",
            yearBuilt: 1920,
            address: "210 Heritage Building, Historic District, City",
            fullDescription: "Own a piece of history in this beautifully restored apartment located in the historic Heritage Building. This elegant residence combines period charm with modern conveniences, featuring 12-foot ceilings, original hardwood floors, crown molding, and large windows. The updated kitchen includes marble countertops, high-end appliances, and custom cabinetry while respecting the historical character. The spacious living room includes a decorative fireplace and built-in bookshelves. Located in the heart of the city's historic district, you'll enjoy walking distance to museums, fine dining, boutique shops, and cultural attractions. The building has been meticulously maintained and includes an elevator and secure entry system.",
            mainImageUrl: "https://images.unsplash.com/photo-1493809842364-78817add7ffb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGFwYXJ0bWVudHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-02-28",
            images: [
                "https://images.unsplash.com/photo-1493809842364-78817add7ffb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGFwYXJ0bWVudHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1532323544230-7191fd51bc1b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8aGlzdG9yaWMlMjBpbnRlcmlvcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1585412727339-54e4bae3bbf9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8aG91c2UlMjBmcm9udHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Historic Building",
                "12-foot Ceilings",
                "Original Hardwood Floors",
                "Crown Molding",
                "Decorative Fireplace",
                "Marble Countertops",
                "Built-in Bookshelves",
                "Updated Electrical System",
                "Secure Entry",
                "Elevator Access",
                "Large Windows",
                "Walk-up Storage Space"
            ],
            agent: {
                id: 2,
                name: "Maria Garcia",
                phone: "(555) 234-5678",
                email: "maria@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
                position: "Historic Property Specialist",
                agency: "Premium Realty"
            }
        },
        {
            id: 12,
            title: "Waterfront Property",
            price: 875000,
            bedrooms: 4,
            bathrooms: 3,
            sqft: 2600,
            shortDescription: "Beautiful house with private dock and lake access",
            imageUrl: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            propertyType: "house",
            location: "beachfront",
            yearBuilt: 2008,
            address: "15 Lakeshore Drive, Crystal Lake",
            fullDescription: "Experience waterfront living at its finest in this spectacular lakeside property. The home features an open floor plan with walls of windows showcasing panoramic lake views. The great room includes vaulted ceilings and a stone fireplace, while the chef's kitchen offers high-end appliances, granite countertops, and a large island. The primary suite includes a sitting area, walk-in closet, and luxurious bathroom with soaking tub. The finished walkout basement provides additional living space and access to the waterfront. Outside, enjoy multiple decks, a covered boat dock with lift, and landscaped grounds. Perfect for year-round living or as a vacation retreat.",
            mainImageUrl: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
            status: "For Sale",
            listedDate: "2025-03-01",
            images: [
                "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8aG91c2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1563298723-dcfebaa392e3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bGFrZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1574118140238-470de8bca3f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZG9ja3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
                "https://images.unsplash.com/photo-1600607687644-a677735bca8d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGx1eHVyeSUyMGtpdGNoZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
            ],
            features: [
                "Lake Views",
                "Private Dock with Boat Lift",
                "Stone Fireplace",
                "Vaulted Ceilings",
                "Granite Countertops",
                "Walkout Basement",
                "Multiple Decks",
                "Landscaped Grounds",
                "Security System",
                "Irrigation System",
                "Water Filtration System",
                "Three-car Garage"
            ],
            agent: {
                id: 3,
                name: "David Johnson",
                phone: "(555) 345-6789",
                email: "david@realtyagent.com",
                imageUrl: "https://randomuser.me/api/portraits/men/59.jpg",
                position: "Waterfront Property Specialist",
                agency: "Premium Realty"
            }
        }
    ];

    // Initialize components
    initInfiniteScroll();
    initFilterHandling();
    initModalHandling();

    /**
     * Infinite Scroll Implementation
     */
    function initInfiniteScroll() {
        $(window).scroll(function() {
            if($(window).scrollTop() + $(window).height() > $(document).height() - 300) {
                if(!loading && !allPropertiesLoaded) {
                    loadMoreProperties();
                }
            }
        });
    }

    /**
     * Filter Handling Implementation
     */
    function initFilterHandling() {
        // Apply filters button click
        $('#applyFilters').click(function() {
            // Get all filter values
            currentFilters = {
                propertyType: $('#propertyType').val(),
                priceRange: $('#priceRange').val(),
                bedrooms: $('#bedrooms').val(),
                location: $('#location').val()
            };
            
            // Reset and reload properties with new filters
            resetPropertyList();
            loadMoreProperties();
        });
        
        // Reset filters button click
        $('#resetFilters').click(function() {
            // Clear all form fields
            $('#filterForm')[0].reset();
            
            // Clear current filters
            currentFilters = {};
            
            // Reset and reload properties
            resetPropertyList();
            loadMoreProperties();
        });
    }

    /**
     * Modal Handling Implementation
     */
    function initModalHandling() {
        // Property detail modal handling
        $(document).on('click', '.view-details', function() {
            const propertyId = $(this).data('property-id');
            currentPropertyId = propertyId;
            loadPropertyDetails(propertyId);
        });
        
        // Contact agent button click
        $('#contactAgentBtn').click(function() {
            // Hide property modal and show agent modal
            $('#propertyModal').modal('hide');
            loadAgentInfo(currentPropertyId);
            $('#agentModal').modal('show');
        });
        
        // Send message to agent
        $('#sendMessageBtn').click(function() {
            sendMessageToAgent();
        });
    }

    /**
     * Filter properties based on current filters
     */
    function filterProperties() {
        let filteredProperties = ALL_PROPERTIES;
        
        if (currentFilters.propertyType) {
            filteredProperties = filteredProperties.filter(property => 
                property.propertyType === currentFilters.propertyType
            );
        }
        
        if (currentFilters.location) {
            filteredProperties = filteredProperties.filter(property => 
                property.location === currentFilters.location
            );
        }
        
        if (currentFilters.bedrooms) {
            const minBedrooms = parseInt(currentFilters.bedrooms);
            filteredProperties = filteredProperties.filter(property => 
                property.bedrooms >= minBedrooms
            );
        }
        
        if (currentFilters.priceRange) {
            const [min, max] = currentFilters.priceRange.split('-');
            if (max === 'plus') {
                filteredProperties = filteredProperties.filter(property => 
                    property.price >= parseInt(min)
                );
            } else {
                filteredProperties = filteredProperties.filter(property => 
                    property.price >= parseInt(min) && property.price <= parseInt(max)
                );
            }
        }
        
        return filteredProperties;
    }

    /**
     * Load more properties with current filters
     */
    function loadMoreProperties() {
        loading = true;
        $('#loadingSpinner').show();
        
        // Filter and paginate properties
        const filteredProperties = filterProperties();
        const startIndex = (page - 1) * PAGE_SIZE;
        const endIndex = Math.min(startIndex + PAGE_SIZE, filteredProperties.length);
        const propertiesForPage = filteredProperties.slice(startIndex, endIndex);
        
        // Simulate loading time
        setTimeout(function() {
            if (propertiesForPage.length > 0) {
                appendProperties(propertiesForPage);
                page++;
                allPropertiesLoaded = endIndex >= filteredProperties.length;
            } else {
                allPropertiesLoaded = true;
                if (page === 1) {
                    $('#propertyList').html('<div class="col-12 text-center"><p>No properties found matching your criteria.</p></div>');
                }
            }
            loading = false;
            $('#loadingSpinner').hide();
        }, 800);
    }
    
    /**
     * Append properties to the list
     */
    function appendProperties(properties) {
        let html = '';
        
        properties.forEach(function(property) {
            // Format price safely
            const formattedPrice = typeof property.price === 'number' ? 
                property.price.toLocaleString() : property.price;
            
            // Format square feet safely
            const formattedSqft = typeof property.sqft === 'number' ? 
                property.sqft.toLocaleString() : property.sqft;
            
            html += `
            <div class="col-md-4 mb-4 property-item">
                <div class="card h-100">
                    <img src="${property.imageUrl}" class="card-img-top" alt="${property.title}">
                    <div class="card-body">
                        <h5 class="card-title">${property.title || 'Untitled Property'}</h5>
                        <p class="card-text text-primary fw-bold">$${formattedPrice}</p>
                        <p class="card-text">
                            <span class="badge bg-secondary">${property.bedrooms || 0} Beds</span>
                            <span class="badge bg-secondary">${property.bathrooms || 0} Baths</span>
                            <span class="badge bg-secondary">${formattedSqft} sqft</span>
                        </p>
                        <p class="card-text">${property.shortDescription || 'No description available'}</p>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">Listed by: ${property.agent && property.agent.name ? property.agent.name : 'Unknown Agent'}</small>
                        <button type="button" class="btn btn-primary view-details" 
                            data-bs-toggle="modal" 
                            data-bs-target="#propertyModal" 
                            data-property-id="${property.id}">
                            View All Details
                        </button>
                    </div>
                </div>
            </div>
            `;
        });
        
        $('#propertyList').append(html);
    }
    
    /**
     * Reset property list for new search/filter
     */
    function resetPropertyList() {
        $('#propertyList').empty();
        page = 1;
        allPropertiesLoaded = false;
    }
    
    /**
     * Load property details into modal
     */
    function loadPropertyDetails(propertyId) {
        $('#propertyDetails').html('<div class="text-center py-3"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>');
        
        // Get property from ALL_PROPERTIES array
        const property = ALL_PROPERTIES.find(p => p.id === propertyId);
        
        // Simulate loading time
		        // Simulate loading time
		        setTimeout(function() {
		            if(property) {
		                // Format price safely
		                const formattedPrice = typeof property.price === 'number' ? 
		                    property.price.toLocaleString() : property.price;
		                
		                // Format square feet safely
		                const formattedSqft = typeof property.sqft === 'number' ? 
		                    property.sqft.toLocaleString() : property.sqft;
		                
		                // Ensure images array exists
		                const images = property.images || [];
		                
		                // Ensure features array exists
		                const features = property.features || [];
		                
		                // Build the property details HTML
		                let html = `
		                <div class="property-detail-content">
		                    <div class="row mb-4">
		                        <div class="col-md-8">
		                            <h3>${property.title || 'Untitled Property'}</h3>
		                            <p class="text-muted">${property.address || 'Address not available'}</p>
		                            <h4 class="text-primary">$${formattedPrice}</h4>
		                        </div>
		                        <div class="col-md-4 text-md-end">
		                            <span class="badge bg-success">${property.status || 'Unknown'}</span>
		                            <p class="mt-2">Listed on ${property.listedDate || 'Unknown date'}</p>
		                        </div>
		                    </div>
		                    
		                    <div class="mb-4">
		                        <img src="${property.mainImageUrl}" class="img-fluid rounded" alt="${property.title || 'Property'}">
		                    </div>
		                    
		                    <div class="image-gallery mb-4">
		                        ${images.map(img => `<img src="${img}" class="gallery-image" alt="Property image">`).join('')}
		                    </div>
		                    
		                    <div class="row mb-4">
		                        <div class="col-md-3 col-6">
		                            <div class="property-feature">
		                                <i class="bi bi-house-door"></i>
		                                <div>
		                                    <strong>${property.bedrooms || 0}</strong>
		                                    <div>Bedrooms</div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-3 col-6">
		                            <div class="property-feature">
		                                <i class="bi bi-water"></i>
		                                <div>
		                                    <strong>${property.bathrooms || 0}</strong>
		                                    <div>Bathrooms</div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-3 col-6">
		                            <div class="property-feature">
		                                <i class="bi bi-rulers"></i>
		                                <div>
		                                    <strong>${formattedSqft}</strong>
		                                    <div>Square Feet</div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-3 col-6">
		                            <div class="property-feature">
		                                <i class="bi bi-calendar"></i>
		                                <div>
		                                    <strong>${property.yearBuilt || 'N/A'}</strong>
		                                    <div>Year Built</div>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                    
		                    <div class="mb-4">
		                        <h5>Description</h5>
		                        <p>${property.fullDescription || 'No detailed description available.'}</p>
		                    </div>
		                    
		                    <div class="mb-4">
		                        <h5>Features & Amenities</h5>
		                        <div class="row">
		                            ${features.length > 0 ? features.map(feature => `
		                                <div class="col-md-4 col-6 mb-2">
		                                    <div><i class="bi bi-check-circle text-success me-2"></i>${feature}</div>
		                                </div>
		                            `).join('') : '<div class="col-12"><p>No features listed for this property.</p></div>'}
		                        </div>
		                    </div>
		                    
		                    <div class="mb-4">
		                        <h5>Location</h5>
		                        <div class="ratio ratio-16x9">
		                            <iframe
		                                src="https://www.google.com/maps/embed/v1/place?key=YOUR_API_KEY&q=${encodeURIComponent(property.address || '')}"
		                                allowfullscreen>
		                            </iframe>
		                        </div>
		                    </div>
		                    
		                    <div class="property-meta mt-4">
		                        <div class="row mb-2">
		                            <div class="col-md-6">
		                                <span class="text-muted">Property Type:</span> 
		                                <span class="badge bg-info">${property.propertyType ? property.propertyType.charAt(0).toUpperCase() + property.propertyType.slice(1) : 'Unknown'}</span>
		                            </div>
		                            <div class="col-md-6">
		                                <span class="text-muted">Location:</span> 
		                                <span class="badge bg-info">${property.location ? property.location.charAt(0).toUpperCase() + property.location.slice(1) : 'Unknown'}</span>
		                            </div>
		                        </div>
		                        <div class="row">
		                            <div class="col-12">
		                                <div class="listing-info mt-2">
		                                    <small class="text-muted">
		                                        Listing ID: ${property.id} • 
		                                        Last Updated: 2025-03-25 • 
		                                        Viewed: 24 times
		                                    </small>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                    `;
		                    
		                    // Add agent card only if agent info exists
		                    if (property.agent) {
		                        html += `
		                        <hr class="my-4">
		                        <div class="agent-card">
		                            <img src="${property.agent.imageUrl || 'images/default-agent.jpg'}" class="agent-image" alt="${property.agent.name || 'Agent'}">
		                            <div class="agent-info">
		                                <h5>${property.agent.name || 'Agent'}</h5>
		                                <p class="agent-position mb-2">${property.agent.position || 'Real Estate Agent'}</p>
		                                <p class="mb-1"><i class="bi bi-telephone me-2"></i>${property.agent.phone || 'Phone not available'}</p>
		                                <p class="mb-1"><i class="bi bi-envelope me-2"></i>${property.agent.email || 'Email not available'}</p>
		                                <p class="mb-0"><i class="bi bi-building me-2"></i>${property.agent.agency || 'Agency not available'}</p>
		                            </div>
		                        </div>
		                        `;
		                    }
		                    
		                    html += `
		                    <div class="user-view-info text-end mt-4">
		                        <small class="text-muted">Viewed by: IT24103866 at 2025-03-25 22:00:20</small>
		                    </div>
		                    </div>`;
		                
		                $('#modalPropertyTitle').text(property.title || 'Property Details');
		                $('#propertyDetails').html(html);
		                
		                // Initialize gallery image click functionality
		                $('.gallery-image').click(function() {
		                    const imgSrc = $(this).attr('src');
		                    $('.property-detail-content > .mb-4 > img').attr('src', imgSrc);
		                });
		                
		                // Track property view
		                trackPropertyView(propertyId);
		            } else {
		                $('#propertyDetails').html('<div class="alert alert-danger">Property details not found.</div>');
		            }
		        }, 800);
		    }
		    
		    /**
		     * Track property views for analytics
		     */
		    function trackPropertyView(propertyId) {
		        // In a real application, this would send data to the server
		        console.log(`Property ${propertyId} viewed by IT24103866 at 2025-03-25 22:00:20`);
		        
		        // You could use localStorage to track views locally for demonstration
		        let views = JSON.parse(localStorage.getItem('propertyViews') || '{}');
		        views[propertyId] = views[propertyId] ? views[propertyId] + 1 : 1;
		        localStorage.setItem('propertyViews', JSON.stringify(views));
		    }
		    
		    /**
		     * Load agent information for contact modal
		     */
		    function loadAgentInfo(propertyId) {
		        $('#agentInfo').html('<div class="text-center py-3"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>');
		        
		        // Find the property with the matching ID
		        const property = ALL_PROPERTIES.find(p => p.id === propertyId);
		        let agent = null;
		        
		        if (property && property.agent) {
		            agent = property.agent;
		        }
		        
		        // Simulate loading time
		        setTimeout(function() {
		            if(agent) {
		                const html = `
		                <div class="d-flex align-items-center mb-3">
		                    <img src="${agent.imageUrl || 'images/default-agent.jpg'}" class="me-3 rounded-circle" style="width: 60px; height: 60px; object-fit: cover;" alt="${agent.name || 'Agent'}">
		                    <div>
		                        <h5 class="mb-1">${agent.name || 'Agent'}</h5>
		                        <p class="mb-0">${agent.position || 'Real Estate Agent'}</p>
		                    </div>
		                </div>
		                <div class="mb-3">
		                    <p class="mb-1"><i class="bi bi-telephone me-2"></i>${agent.phone || 'Phone not available'}</p>
		                    <p class="mb-1"><i class="bi bi-envelope me-2"></i>${agent.email || 'Email not available'}</p>
		                    <p class="mb-0"><i class="bi bi-building me-2"></i>${agent.agency || 'Agency not available'}</p>
		                </div>
		                <div class="alert alert-primary">
		                    <small>Send a message to ${agent.name || 'the agent'} about this property. They typically respond within 24 hours.</small>
		                </div>
		                <div class="contact-meta text-end">
		                    <small class="text-muted">Session: IT24103866 at 2025-03-25 22:00:20</small>
		                </div>
		                `;
		                
		                $('#agentInfo').html(html);
		            } else {
		                $('#agentInfo').html('<div class="alert alert-danger">Agent information not found.</div>');
		            }
		        }, 800);
		    }
		    
		    /**
		     * Send message to agent (simulated)
		     */
		    function sendMessageToAgent() {
		        const messageData = {
		            propertyId: currentPropertyId,
		            name: $('#name').val(),
		            email: $('#email').val(),
		            phone: $('#phone').val(),
		            message: $('#message').val(),
		            userId: 'IT24103866',
		            timestamp: '2025-03-25 22:00:20'
		        };
		        
		        // Form validation
		        if(!messageData.name || !messageData.email || !messageData.message) {
		            alert('Please fill out all required fields.');
		            return;
		        }
		        
		        // Disable send button and show loading state
		        $('#sendMessageBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Sending...');
		        
		        // Simulate API call with timeout
		        setTimeout(function() {
		            // Re-enable button
		            $('#sendMessageBtn').prop('disabled', false).text('Send Message');
		            
		            // Clear form
		            $('#contactForm')[0].reset();
		            
		            // Show success message and close modal
		            alert('Your message has been sent successfully. The agent will contact you soon.');
		            $('#agentModal').modal('hide');
		            
		            // Log the event (in a real app, this would be sent to the server)
		            console.log('Message sent by IT24103866:', messageData);
		            
		        }, 1500);
		    }
		    
		    // Initial load of properties
		    loadMoreProperties();

		    // Add the user session info to the page
		    if (!document.querySelector('.user-session-info')) {
		        const sessionInfo = document.createElement('div');
		        sessionInfo.className = 'user-session-info';
		        sessionInfo.innerHTML = '<span class="dot"></span>' +
		                                '<span class="user-id">IT24103866</span> | ' +
		                                '<span class="timestamp">2025-03-25 22:00:20</span>';
		        document.body.appendChild(sessionInfo);
		    }

		    // Create the animated background if it doesn't exist
		    if (!document.getElementById('animatedBackground')) {
		        const background = document.createElement('div');
		        background.className = 'animated-background';
		        background.id = 'animatedBackground';
		        document.body.insertBefore(background, document.body.firstChild);

		        // Create particles and stars
		        createParticlesAndStars();
		    }

		    /**
		     * Create animated background elements
		     */
		    function createParticlesAndStars() {
		        const background = document.getElementById('animatedBackground');
		        
		        // Create particles
		        for (let i = 0; i < 30; i++) {
		            const particle = document.createElement('div');
		            particle.className = 'particle';
		            
		            // Random size between 3px and 8px
		            const size = Math.random() * 5 + 3;
		            particle.style.width = `${size}px`;
		            particle.style.height = `${size}px`;
		            
		            // Random position
		            particle.style.left = `${Math.random() * 100}%`;
		            particle.style.top = `${Math.random() * 100}%`;
		            
		            // Random opacity
		            particle.style.opacity = Math.random() * 0.5 + 0.1;
		            
		            // Random animation duration between 10s and 20s
		            const duration = Math.random() * 10 + 10;
		            particle.style.animationDuration = `${duration}s`;
		            
		            // Random animation delay
		            particle.style.animationDelay = `${Math.random() * 5}s`;
		            
		            background.appendChild(particle);
		        }
		        
		        // Create stars
		        for (let i = 0; i < 60; i++) {
		            const star = document.createElement('div');
		            star.className = 'star';
		            
		            // Random position
		            star.style.left = `${Math.random() * 100}%`;
		            star.style.top = `${Math.random() * 100}%`;
		            
		            // Random animation duration between 2s and 8s
		            const duration = Math.random() * 6 + 2;
		            star.style.animationDuration = `${duration}s`;
		            
		            // Random animation delay
		            star.style.animationDelay = `${Math.random() * 5}s`;
		            
		            background.appendChild(star);
		        }
		    }
		    
		    // Navbar scroll effect
		    window.addEventListener('scroll', function() {
		        const navbar = document.querySelector('.navbar');
		        if (window.scrollY > 10) {
		            navbar.classList.add('scrolled');
		        } else {
		            navbar.classList.remove('scrolled');
		        }
		    });
		    
		    /**
		     * Analytics tracking for user session
		     */
		    function trackSession() {
		        const sessionData = {
		            userId: 'IT24103866',
		            timestamp: '2025-03-25 22:00:20',
		            page: window.location.pathname,
		            referrer: document.referrer,
		            deviceInfo: navigator.userAgent
		        };
		        
		        // In a real application, this would be sent to an analytics service
		        console.log('Session tracked:', sessionData);
		    }
		    
		    // Track the current session
		    trackSession();
		});