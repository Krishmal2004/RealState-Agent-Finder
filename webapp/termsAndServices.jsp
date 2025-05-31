<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --dark-blue: #1a1f3c;
            --darker-blue: #151933;
            --accent-blue: #4A90E2;
            --text-light: #E1E8ED;
            --text-bright: #FFFFFF;
            --card-bg: rgba(26, 31, 60, 0.7);
            --border-color: rgba(74, 144, 226, 0.3);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--dark-blue);
            color: var(--text-light);
            line-height: 1.6;
        }

        #particles-js {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            background: linear-gradient(135deg, var(--darker-blue) 0%, var(--dark-blue) 100%);
        }

        .content-wrapper {
            position: relative;
            z-index: 2;
            padding: 2rem;
        }

        .privacy-container {
            background: var(--card-bg);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid var(--border-color);
            margin: 2rem auto;
            max-width: 800px;
            padding: 2rem;
        }

        .privacy-content {
            height: 600px;
            overflow-y: auto;
            padding: 20px;
            border-radius: 10px;
            background: rgba(26, 31, 60, 0.9);
            border: 1px solid var(--border-color);
        }

        .privacy-content::-webkit-scrollbar {
            width: 6px;
        }

        .privacy-content::-webkit-scrollbar-track {
            background: rgba(74, 144, 226, 0.1);
            border-radius: 3px;
        }

        .privacy-content::-webkit-scrollbar-thumb {
            background: var(--accent-blue);
            border-radius: 3px;
        }

        .section-title {
            color: var(--accent-blue);
            margin: 1.5rem 0 1rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .user-info {
            color: var(--text-bright);
            background: rgba(74, 144, 226, 0.1);
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            border: 1px solid var(--border-color);
        }

        .timestamp {
            color: var(--accent-blue);
        }

        .btn-home {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--accent-blue);
            color: var(--text-bright);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
            border: 1px solid var(--border-color);
            z-index: 1000;
        }

        .btn-home:hover {
            background: #357abd;
            color: var(--text-bright);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(74, 144, 226, 0.5);
        }

        .btn-home i {
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <div id="particles-js"></div>
    
    <div class="content-wrapper">
        <div class="privacy-container animate__animated animate__fadeInUp">
            <div class="user-info">
                <div class="d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-user"></i> User: Krishmal2004</span>
                    <span class="timestamp">2025-03-14 21:06:43 UTC</span>
                </div>
            </div>

            <div class="privacy-content">
                <h1 class="section-title">Privacy Policy</h1>

                <h2 class="section-title">1. What Information Do We Collect?</h2>
                <h3>Personal Identification Information</h3>
                <p>We may collect personal identifying information from Users in a variety of ways, including when Users visit our Site, subscribe to the newsletter, fill out a form, and in conjunction with other activities, services, features, or resources we make accessible on our Site. Users may be requested for their name, email address, mailing address, and phone number, if applicable. Users can browse the Site anonymously, and the aforementioned information is only gathered when willingly submitted. Users who do not want to reveal such information may do so, but they may be unable to participate in or access some site-related activities.</p>

                <h3>Non-Personal Identification Information</h3>
                <p>We may gather non-personal identifying information in addition to personal identification information. Non-personal identifying information may include the browser name, computer type, and technical information about Users' methods of access to our Site, such as the operating system and Internet service providers used, among other things.</p>

                <h2 class="section-title">2. Web Browser Cookies</h2>
                <p>This Site may use cookies to improve the user experience. Cookies are placed on a user's hard drive by their web browser for record-keeping and sometimes to monitor information about them. Users can configure their web browser to refuse cookies or to notify them when cookies are transmitted. If they do so, note that some parts of the Site may not be accessible to them.</p>

                <h2 class="section-title">3. How We Use Collected Information</h2>
                <p>Home Lands Holdings (Private) Ltd may collect and use Users personal information for the following purposes:</p>
                <ul>
                    <li>Improve customer service</li>
                    <li>Personalize user experience</li>
                    <li>Improve our Site</li>
                    <li>Run promotions, contests, surveys</li>
                    <li>Send periodic emails</li>
                </ul>

                <h2 class="section-title">4. How We Protect Your Information</h2>
                <p>We utilize appropriate data collecting, storage, and processing policies, as well as security measures, to safeguard your personal information, username, password, transaction information, and data held on our Site against unauthorized access, modification, disclosure, or destruction.</p>

                <h2 class="section-title">5. Sharing Your Personal Information</h2>
                <p>We do not sell, trade, or rent Users' personally identifiable information to third parties. We may share general aggregated demographic information about visitors and users that is not linked to any personal identifiable information with our business partners, trusted affiliates, and advertising for the reasons mentioned above.</p>

                <h2 class="section-title">6. Changes to This Privacy Policy</h2>
                <p>Home Lands Holdings (Pvt) Ltd. has the right to update this privacy policy at any time. We'll update the new date at the bottom of this page once we've done so. We urge Users to visit this page periodically for updates.</p>

                <h2 class="section-title">7. Your Acceptance of These Terms</h2>
                <p>By using this Site, you agree to the terms of this policy. Please do not use our Site if you do not agree with this policy. Your continued use of the Site after modifications to this policy are published will be deemed your acceptance of those changes.</p>

                <h2 class="section-title">8. Contacting Us</h2>
                <p>If you have any concerns regarding our Privacy Policy, our practices, or your dealings with this Site, please contact us at:</p>
                <p>Email: krishmaldinidu5466@gmail.com</p>
                <p>Phone: +94 70 219 5755</p>
                <p>Address: 123 Real Estate St.</p>

                <p class="mt-4">Last Updated: 2025-03-14 21:06:43 UTC</p>
            </div>
        </div>

        <a href="index.jsp" class="btn-home animate__animated animate__pulse animate__infinite animate__slower" title="Go to Homepage">
            <i class="fas fa-home"></i>
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script>
        particlesJS("particles-js", {
            particles: {
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: "#4A90E2" },
                shape: { type: "circle" },
                opacity: {
                    value: 0.5,
                    random: true,
                    animation: { enable: true, speed: 1, opacity_min: 0.1, sync: false }
                },
                size: {
                    value: 3,
                    random: true,
                    animation: { enable: true, speed: 2, size_min: 0.1, sync: false }
                },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#4A90E2",
                    opacity: 0.4,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 1,
                    direction: "none",
                    random: true,
                    straight: false,
                    out_mode: "out",
                    bounce: false
                }
            },
            interactivity: {
                detect_on: "canvas",
                events: {
                    onhover: { enable: true, mode: "repulse" },
                    onclick: { enable: true, mode: "push" },
                    resize: true
                },
                modes: {
                    repulse: { distance: 100, duration: 0.4 },
                    push: { particles_nb: 4 }
                }
            },
            retina_detect: true
        });
    </script>
</body>
</html>