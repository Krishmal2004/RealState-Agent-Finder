<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Animate.css for animations -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<!-- AOS (Animate On Scroll) CSS -->
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<!-- Custom CSS -->
<style>
    :root {
        --primary-color: #0a1f44;
        --secondary-color: #1a3a6c;
        --accent-color: #4a90e2;
    }
    
    body {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        min-height: 100vh;
        overflow-x: hidden;
    }

    .floating {
        animation: floating 3s ease-in-out infinite;
    }

    @keyframes floating {
        0% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
        100% { transform: translateY(0px); }
    }

    .card-hover {
        transition: all 0.3s ease;
    }

    .card-hover:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
    }

    .input-group-hover {
        transition: all 0.3s ease;
    }

    .input-group-hover:hover {
        transform: scale(1.02);
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
    }

    .current-time {
        position: fixed;
        top: 20px;
        right: 20px;
        color: white;
        background: rgba(0, 0, 0, 0.5);
        padding: 10px;
        border-radius: 10px;
        font-size: 0.9rem;
        z-index: 1000;
    }
</style>