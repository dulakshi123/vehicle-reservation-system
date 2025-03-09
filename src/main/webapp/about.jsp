<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mega City Cab - About Us & Contact</title>
  <style>
    :root {
      --primary: #2e4ead;
      --secondary: #ff9800;
      --dark: #333;
      --light: #f8f9fa;
      --success: #28a745;
      --danger: #dc3545;
      --warning: #ffc107;
      --gray: #6c757d;
    }
    
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
      background-color: #f0f2f5;
    }
    
    .navbar {
      background-color: var(--primary);
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      color: white;
    }
    
    .logo {
      font-size: 24px;
      font-weight: bold;
      display: flex;
      align-items: center;
    }
    
    .logo span {
      color: var(--secondary);
    }

    .nav-links {
      display: flex;
      gap: 20px;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
      font-weight: 500;
    }
    
    .user-actions {
      display: flex;
      align-items: center;
      gap: 15px;
    }
    
    .user-info {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    
    .avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background-color: var(--secondary);
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
    }
    
    .btn {
      padding: 8px 15px;
      border-radius: 5px;
      border: none;
      cursor: pointer;
      font-weight: 500;
      transition: all 0.3s ease;
    }
    
    .btn-primary {
      background-color: var(--secondary);
      color: white;
    }
    
    .btn-primary:hover {
      background-color: #e68a00;
    }
    
    .container {
      max-width: 1200px;
      margin: 30px auto;
      padding: 0 20px;
    }
    
    .page-title {
      background: linear-gradient(135deg, var(--primary) 0%, #1a3a99 100%);
      border-radius: 15px;
      padding: 30px;
      color: white;
      margin-bottom: 30px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      text-align: center;
    }
    
    .page-title h1 {
      font-size: 32px;
      margin-bottom: 10px;
    }
    
    .page-title p {
      font-size: 18px;
      max-width: 800px;
      margin: 0 auto;
    }
    
    .content-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 30px;
      margin-bottom: 30px;
    }
    
    .card {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 3px 10px rgba(0,0,0,0.08);
      overflow: hidden;
    }
    
    .card-content {
      padding: 30px;
    }
    
    .section-title {
      color: var(--primary);
      font-size: 24px;
      margin-bottom: 20px;
      position: relative;
      display: inline-block;
    }
    
    .section-title::after {
      content: '';
      position: absolute;
      left: 0;
      bottom: -5px;
      width: 50px;
      height: 3px;
      background-color: var(--secondary);
    }
    
    .about-content p {
      margin-bottom: 15px;
      line-height: 1.6;
      color: var(--dark);
    }
    
    .car-animation {
      position: relative;
      height: 100px;
      margin: 30px 0;
      overflow: hidden;
    }
    
    .car {
      position: absolute;
      bottom: 0;
      left: -100px;
      width: 80px;
      height: 40px;
      background-color: var(--secondary);
      border-radius: 10px;
      animation: drive 8s linear infinite;
    }
    
    .car::before {
      content: '';
      position: absolute;
      top: -15px;
      left: 10px;
      width: 40px;
      height: 20px;
      background-color: var(--secondary);
      border-radius: 10px 10px 0 0;
    }
    
    .wheel {
      position: absolute;
      width: 15px;
      height: 15px;
      background-color: var(--dark);
      border-radius: 50%;
      bottom: -5px;
      animation: rotate 1s linear infinite;
    }
    
    .wheel.front {
      left: 10px;
    }
    
    .wheel.back {
      right: 10px;
    }
    
    .road {
      position: absolute;
      bottom: 0;
      width: 100%;
      height: 5px;
      background-color: var(--dark);
    }
    
    @keyframes drive {
      0% {
        left: -100px;
      }
      100% {
        left: 100%;
      }
    }
    
    @keyframes rotate {
      0% {
        transform: rotate(0deg);
      }
      100% {
        transform: rotate(360deg);
      }
    }
    
    .contact-info {
      margin-bottom: 30px;
    }
    
    .info-item {
      display: flex;
      align-items: flex-start;
      margin-bottom: 20px;
    }
    
    .info-icon {
      width: 40px;
      height: 40px;
      background-color: rgba(46, 78, 173, 0.1);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 15px;
      color: var(--primary);
      font-size: 18px;
      flex-shrink: 0;
    }
    
    .info-details h4 {
      color: var(--dark);
      margin-bottom: 5px;
    }
    
    .info-details p {
      color: var(--gray);
      line-height: 1.5;
    }
    
    .office-hours {
      margin-bottom: 30px;
    }
    
    .hour-item {
      display: flex;
      justify-content: space-between;
      padding: 10px 0;
      border-bottom: 1px solid #eee;
    }
    
    .hour-item:last-child {
      border-bottom: none;
    }
    
    .social-links {
      display: flex;
      gap: 15px;
      margin-top: 30px;
    }
    
    .social-btn {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background-color: var(--primary);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.3s ease;
      text-decoration: none;
      font-size: 18px;
    }
    
    .social-btn:hover {
      background-color: var(--secondary);
      transform: translateY(-3px);
    }
    
    .footer {
      background-color: var(--dark);
      color: white;
      padding: 30px 0;
      text-align: center;
    }
    
    .footer-content {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }
    
    .footer-links {
      display: flex;
      justify-content: center;
      gap: 30px;
      margin: 20px 0;
    }
    
    .footer-links a {
      color: #ccc;
      text-decoration: none;
      transition: color 0.3s ease;
    }
    
    .footer-links a:hover {
      color: white;
    }
    
    @media (max-width: 768px) {
      .content-grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <nav class="navbar">
    <div onclick="redirectToHome()" class="logo" style="cursor: pointer;">
      Mega<span>City</span>Cab
    </div>
    <div class="nav-links">
      <a href="home.jsp">Home</a>
      <a href="booking.jsp">Book a Ride</a>
      <a href="about.jsp">Contact</a>
    </div>
  </nav>
  
  <div class="container">
    <section class="page-title">
      <h1>About Us & Contact</h1>
      <p>Get to know more about Mega City Cab and connect with us</p>
    </section>
    
    <div class="content-grid">
      <div class="card">
        <div class="card-content">
          <h2 class="section-title">About Us</h2>
          
          <div class="about-content">
            <p>Welcome to Mega City Cab, Colombo's premier cab service trusted by thousands of customers each month. Established in 2010, we've been providing reliable, comfortable, and affordable transportation across Colombo City.</p>
            
            <p>Our mission is to revolutionize urban transportation by offering convenient, safe, and efficient cab services that meet the diverse needs of our clients. With a fleet of well-maintained vehicles and professional drivers, we ensure that every journey with us is pleasant and stress-free.</p>
            
            <p>At Mega City Cab, we prioritize customer satisfaction and continuously strive to improve our services. Our commitment to excellence has made us the preferred choice for both locals and tourists in Colombo.</p>
          </div>
          
          <div class="car-animation">
            <div class="road"></div>
            <div class="car">
              <div class="wheel front"></div>
              <div class="wheel back"></div>
            </div>
          </div>
          
          <div class="about-content">
            <p>As we expand our operations, we remain dedicated to our core values of reliability, safety, and customer-centricity. Join the thousands of satisfied customers who choose Mega City Cab for their transportation needs in Colombo.</p>
          </div>
        </div>
      </div>
      
      <div class="card">
        <div class="card-content">
          <h2 class="section-title">Contact Us</h2>
          
          <div class="contact-info">
            <div class="info-item">
              <div class="info-icon">📍</div>
              <div class="info-details">
                <h4>Head Office</h4>
                <p>123 Galle Road, Colombo 03,<br>Sri Lanka</p>
              </div>
            </div>
            
            <div class="info-item">
              <div class="info-icon">📞</div>
              <div class="info-details">
                <h4>Phone Numbers</h4>
                <p>Customer Support: +94 11 2345678<br>Bookings: +94 11 2345679</p>
              </div>
            </div>
            
            <div class="info-item">
              <div class="info-icon">✉️</div>
              <div class="info-details">
                <h4>Email Addresses</h4>
                <p>General Inquiries: info@megacitycab.lk<br>Customer Support: support@megacitycab.lk</p>
              </div>
            </div>
          </div>
          
          <h3 class="section-title">Office Hours</h3>
          <div class="office-hours">
            <div class="hour-item">
              <span>Monday - Friday</span>
              <span>8:00 AM - 8:00 PM</span>
            </div>
            <div class="hour-item">
              <span>Saturday</span>
              <span>9:00 AM - 6:00 PM</span>
            </div>
            <div class="hour-item">
              <span>Sunday</span>
              <span>10:00 AM - 4:00 PM</span>
            </div>
          </div>
          
          <h3 class="section-title">Connect With Us</h3>
          <div class="social-links">
            <a href="#" class="social-btn">f</a>
            <a href="#" class="social-btn">in</a>
            <a href="#" class="social-btn">t</a>
            <a href="#" class="social-btn">ig</a>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <footer class="footer">
    <div class="footer-content">
      <div class="footer-links">
        <a href="home.jsp">Home</a>
        <a href="#">About Us</a>
        <a href="#">Contact</a>
      
      </div>
      <p>&copy; 2025 Mega City Cab. All rights reserved.</p>
    </div>
  </footer>
</body>

<script>
  function redirectToHome() {
    window.location.href = "home.jsp";
}
</script>
</html>