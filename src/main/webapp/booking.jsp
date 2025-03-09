<%@ page import="com.dulakshi.vrs.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User user = (User) session.getAttribute("_user_");

  if(user==null) {
    response.sendRedirect("index.jsp");
  }
%>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="assets/img/logo.png">
  <title>Mega City Cab - Book a Ride</title>
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
      --light-gray: #e9ecef;
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
    
    .container {
      max-width: 1000px;
      margin: 30px auto;
      padding: 0 20px;
    }
    
    .page-title {
      margin-bottom: 20px;
      color: var(--dark);
    }
    
    .booking-card {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 3px 15px rgba(0,0,0,0.1);
      overflow: hidden;
    }
    
    .booking-header {
      background: linear-gradient(135deg, var(--primary) 0%, #1a3a99 100%);
      color: white;
      padding: 20px;
    }
    
    .booking-header h2 {
      font-size: 24px;
      margin-bottom: 5px;
    }
    
    .booking-header p {
      opacity: 0.9;
    }
    
    .booking-form {
      padding: 30px;
    }
    
    .form-row {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
    }
    
    .form-group {
      flex: 1;
    }
    
    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: var(--dark);
      font-weight: 500;
    }
    
    .form-control {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
      transition: border-color 0.3s;
    }
    
    .form-control:focus {
      border-color: var(--primary);
      outline: none;
    }
    
    .booking-summary {
      background-color: var(--light-gray);
      padding: 20px 30px;
      border-top: 1px solid #ddd;
      display: none;
    }
    
    .summary-row {
      display: flex;
      justify-content: space-between;
      padding: 10px 0;
      border-bottom: 1px solid #ddd;
    }
    
    .summary-row:last-child {
      border-bottom: none;
      font-weight: bold;
    }
    
    .btn {
      padding: 12px 25px;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s;
    }
    
    .btn-primary {
      background-color: var(--primary);
      color: white;
    }
    
    .btn-primary:hover {
      background-color: #263d8f;
    }
    
    .btn-secondary {
      background-color: var(--gray);
      color: white;
    }
    
    .btn-secondary:hover {
      background-color: #5a6268;
    }
    
    .btn-block {
      display: block;
      width: 100%;
    }
    
    .form-actions {
      margin-top: 30px;
      display: flex;
      justify-content: flex-end;
      gap: 15px;
    }
    
    .status-tag {
      display: inline-block;
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 500;
      background-color: var(--warning);
      color: var(--dark);
    }
    
    .vehicle-options {
      display: flex;
      gap: 15px;
      margin-top: 15px;
    }
    
    .vehicle-option {
      border: 2px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      flex: 1;
      cursor: pointer;
      text-align: center;
      transition: all 0.3s;
    }
    
    .vehicle-option:hover {
      border-color: var(--primary);
    }
    
    .vehicle-option.selected {
      border-color: var(--primary);
      background-color: rgba(46, 78, 173, 0.05);
    }
    
    .vehicle-icon {
      font-size: 32px;
      margin-bottom: 10px;
    }
    
    .vehicle-name {
      font-weight: 600;
      margin-bottom: 5px;
    }
    
    .vehicle-description {
      font-size: 14px;
      color: var(--gray);
    }
    
    .divider {
      margin: 30px 0;
      border-top: 1px solid #ddd;
    }
    
    .section-title {
      margin-bottom: 20px;
      color: var(--dark);
      font-size: 18px;
    }
    
    .error-message {
      color: var(--danger);
      font-size: 14px;
      margin-top: 5px;
      display: none;
    }
    
    .input-error {
      border-color: var(--danger);
    }
    
    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 1000;
      display: none;
    }
    
    .spinner {
      width: 50px;
      height: 50px;
      border: 5px solid #f3f3f3;
      border-top: 5px solid var(--primary);
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .confirmation-message {
      background-color: var(--success);
      color: white;
      padding: 20px;
      border-radius: 5px;
      margin-bottom: 20px;
      display: none;
    }
    
    .confirmation-buttons {
      display: flex;
      gap: 15px;
      margin-top: 15px;
    }
    
    @media (max-width: 768px) {
      .form-row {
        flex-direction: column;
        gap: 15px;
      }
      
      .booking-form {
        padding: 20px;
      }
      
      .vehicle-options {
        flex-direction: column;
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
    <h1 class="page-title">Book a Ride</h1>
    
    <div class="confirmation-message" id="confirmationMessage">
      <h3>Booking Confirmed!</h3>
      <p>Your ride has been successfully booked.</p>
      <div class="confirmation-buttons">
        <button type="button" id="newBookingBtn" class="btn btn-primary">Book Another Ride</button>
        <button type="button" onclick="redirectToHome()" class="btn btn-secondary">Return to Home</button>
      </div>
    </div>
    
    <div class="booking-card" id="bookingCard">
      <div class="booking-header">
        <h2>New Reservation Request</h2>
        <p>Please fill in the details to book your ride</p>
      </div>
      
      <form id="bookingForm" class="booking-form">
        <h3 class="section-title">Trip Details</h3>
        
        <div class="form-row">
          <div class="form-group">
            <label for="pickup">Pickup Location</label>
            <input type="text" id="pickup" class="form-control" placeholder="Enter pickup address">
            <div id="pickupError" class="error-message">Please enter a pickup location</div>
          </div>
          
          <div class="form-group">
            <label for="dropoff">Dropoff Location</label>
            <input type="text" id="dropoff" class="form-control" placeholder="Enter destination address">
            <div id="dropoffError" class="error-message">Please enter a dropoff location</div>
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label for="date">Date</label>
            <input type="date" id="date" class="form-control">
            <div id="dateError" class="error-message">Please select a valid date</div>
          </div>
          
          <div class="form-group">
            <label for="time">Time</label>
            <input type="time" id="time" class="form-control">
            <div id="timeError" class="error-message">Please select a valid time</div>
          </div>
          
          <div class="form-group">
            <label for="passengers">Passengers</label>
            <input type="number" id="passengers" class="form-control" min="1" max="10" value="1">
            <div id="passengersError" class="error-message">Please select 1-10 passengers</div>
          </div>
        </div>
        
        <div class="divider"></div>
        
        <h3 class="section-title">Vehicle Type</h3>
        
        <div class="vehicle-options">
          <div class="vehicle-option selected" data-vehicle="ECONOMY" data-rate="50">
            <div class="vehicle-icon">🚗</div>
            <div class="vehicle-name">Economy</div>
            <div class="vehicle-description">Up to 4 passengers</div>
            <div class="vehicle-description">Rs. 50/km</div>
          </div>
          
          <div class="vehicle-option" data-vehicle="COMFORT" data-rate="70">
            <div class="vehicle-icon">🚙</div>
            <div class="vehicle-name">Comfort</div>
            <div class="vehicle-description">Up to 4 passengers</div>
            <div class="vehicle-description">Rs. 70/km</div>
          </div>
          
          <div class="vehicle-option" data-vehicle="VAN" data-rate="90">
            <div class="vehicle-icon">🚐</div>
            <div class="vehicle-name">Van</div>
            <div class="vehicle-description">Up to 8 passengers</div>
            <div class="vehicle-description">Rs. 90/km</div>
          </div>
        </div>
        
        <div class="form-actions">
          <button type="button" id="checkoutBtn" class="btn btn-primary btn-block">Review Booking</button>
        </div>
      </form>
      
      <div id="bookingSummary" class="booking-summary">
        <h3 style="margin-bottom: 15px;">Booking Summary</h3>
        
        <div class="summary-row">
          <span>From:</span>
          <span id="summaryPickup"></span>
        </div>
        
        <div class="summary-row">
          <span>To:</span>
          <span id="summaryDropoff"></span>
        </div>
        
        <div class="summary-row">
          <span>Date & Time:</span>
          <span id="summaryDateTime"></span>
        </div>
        
        <div class="summary-row">
          <span>Passengers:</span>
          <span id="summaryPassengers"></span>
        </div>
        
        <div class="summary-row">
          <span>Vehicle Type:</span>
          <span id="summaryVehicle"></span>
        </div>
        
        <div class="summary-row">
          <span>Rate:</span>
          <span id="summaryRate"></span>
        </div>
        
        <div class="form-actions" style="justify-content: space-between;">
          <button type="button" id="backBtn" class="btn btn-secondary">Back to Details</button>
          <button type="button" id="confirmBtn" class="btn btn-primary">Confirm Booking</button>
        </div>
      </div>
    </div>
  </div>
  
  <div class="loading-overlay" id="loadingOverlay">
    <div class="spinner"></div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Set minimum date to today
      const today = new Date();
      const formattedDate = today.toISOString().split('T')[0];
      document.getElementById('date').min = formattedDate;
      document.getElementById('date').value = formattedDate;
      
      // Vehicle selection
      const vehicleOptions = document.querySelectorAll('.vehicle-option');
      let selectedVehicle = 'economy';
      let selectedRate = 50;
      
      vehicleOptions.forEach(option => {
        option.addEventListener('click', function() {
          // Remove selected class from all options
          vehicleOptions.forEach(opt => opt.classList.remove('selected'));
          
          // Add selected class to clicked option
          this.classList.add('selected');
          
          // Store selected vehicle data
          selectedVehicle = this.getAttribute('data-vehicle');
          selectedRate = this.getAttribute('data-rate');
        });
      });
      
      // Form validation and submission
      const bookingForm = document.getElementById('bookingForm');
      const bookingCard = document.getElementById('bookingCard');
      const checkoutBtn = document.getElementById('checkoutBtn');
      const backBtn = document.getElementById('backBtn');
      const confirmBtn = document.getElementById('confirmBtn');
      const bookingSummary = document.getElementById('bookingSummary');
      const loadingOverlay = document.getElementById('loadingOverlay');
      const confirmationMessage = document.getElementById('confirmationMessage');
      const newBookingBtn = document.getElementById('newBookingBtn');
      
      // Validate form
      function validateForm() {
        let isValid = true;
        
        // Pickup location
        const pickup = document.getElementById('pickup');
        const pickupError = document.getElementById('pickupError');
        if (!pickup.value.trim()) {
          pickup.classList.add('input-error');
          pickupError.style.display = 'block';
          isValid = false;
        } else {
          pickup.classList.remove('input-error');
          pickupError.style.display = 'none';
        }
        
        // Dropoff location
        const dropoff = document.getElementById('dropoff');
        const dropoffError = document.getElementById('dropoffError');
        if (!dropoff.value.trim()) {
          dropoff.classList.add('input-error');
          dropoffError.style.display = 'block';
          isValid = false;
        } else {
          dropoff.classList.remove('input-error');
          dropoffError.style.display = 'none';
        }
        
        // Date
        const date = document.getElementById('date');
        const dateError = document.getElementById('dateError');
        if (!date.value) {
          date.classList.add('input-error');
          dateError.style.display = 'block';
          isValid = false;
        } else {
          date.classList.remove('input-error');
          dateError.style.display = 'none';
        }
        
        // Time
        const time = document.getElementById('time');
        const timeError = document.getElementById('timeError');
        if (!time.value) {
          time.classList.add('input-error');
          timeError.style.display = 'block';
          isValid = false;
        } else {
          time.classList.remove('input-error');
          timeError.style.display = 'none';
        }
        
        // Passengers
        const passengers = document.getElementById('passengers');
        const passengersError = document.getElementById('passengersError');
        if (!passengers.value || passengers.value < 1 || passengers.value > 10) {
          passengers.classList.add('input-error');
          passengersError.style.display = 'block';
          isValid = false;
        } else {
          passengers.classList.remove('input-error');
          passengersError.style.display = 'none';
        }
        
        return isValid;
      }
      
      // Format date for display
      function formatDate(dateStr, timeStr) {
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const date = new Date(dateStr);
        const formattedDate = date.toLocaleDateString('en-US', options);
        
        // Format time (convert from 24h to 12h format)
        const [hours, minutes] = timeStr.split(':');
        const hour = parseInt(hours, 10);
        const ampm = hour >= 12 ? 'PM' : 'AM';
        const hour12 = hour % 12 || 12;
        const formattedTime = hour12 +':'+ minutes +' '+ ampm;
        
        return formattedDate +' at '+ formattedTime;
      }
      
      // Reset the form to its initial state
      function resetForm() {
        // Reset form fields
        document.getElementById('pickup').value = '';
        document.getElementById('dropoff').value = '';
        
        // Reset date to today
        const today = new Date();
        const formattedDate = today.toISOString().split('T')[0];
        document.getElementById('date').value = formattedDate;
        
        // Reset time
        document.getElementById('time').value = '';
        
        // Reset passengers
        document.getElementById('passengers').value = '1';
        
        // Reset vehicle selection
        vehicleOptions.forEach(opt => opt.classList.remove('selected'));
        document.querySelector('.vehicle-option[data-vehicle="economy"]').classList.add('selected');
        selectedVehicle = 'economy';
        selectedRate = 50;
        
        // Reset display
        bookingSummary.style.display = 'none';
        bookingForm.style.display = 'block';
        confirmationMessage.style.display = 'none';
        bookingCard.style.display = 'block';
        
        // Remove any error styling
        const errorFields = document.querySelectorAll('.input-error');
        errorFields.forEach(field => field.classList.remove('input-error'));
        
        const errorMessages = document.querySelectorAll('.error-message');
        errorMessages.forEach(msg => msg.style.display = 'none');
      }
      
      // Show booking summary
      checkoutBtn.addEventListener('click', function() {
        if (validateForm()) {
          // Populate summary
          document.getElementById('summaryPickup').textContent = document.getElementById('pickup').value;
          document.getElementById('summaryDropoff').textContent = document.getElementById('dropoff').value;
          document.getElementById('summaryDateTime').textContent = formatDate(
            document.getElementById('date').value, 
            document.getElementById('time').value
          );
          document.getElementById('summaryPassengers').textContent = document.getElementById('passengers').value;
          
          // Get selected vehicle name
          const selectedElement = document.querySelector('.vehicle-option.selected');
          const vehicleName = selectedElement.querySelector('.vehicle-name').textContent;
          document.getElementById('summaryVehicle').textContent = vehicleName;
          document.getElementById('summaryRate').textContent = 'Rs. ' + selectedRate + '/km';

          // Show summary
          bookingForm.style.display = 'none';
          bookingSummary.style.display = 'block';
        }
      });
      
      // Back button
      backBtn.addEventListener('click', function() {
        bookingSummary.style.display = 'none';
        bookingForm.style.display = 'block';
      });
      
      // New booking button
      newBookingBtn.addEventListener('click', function() {
        resetForm();
      });
      
      // Confirm booking
      confirmBtn.addEventListener('click', function() {
        // Show loading overlay
        loadingOverlay.style.display = 'flex';
        
        // Prepare data for submission
        const bookingData = {
          pickupLocation: document.getElementById('pickup').value,
          dropOffLocation: document.getElementById('dropoff').value,
          datetime: document.getElementById('date').value + "T" + document.getElementById('time').value,
          passengerCount: document.getElementById('passengers').value,
          vehicleType: selectedVehicle
        };

        setTimeout(() => {
          fetch('/reservation/customer/add', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(bookingData)
          })
          .then(response => {
            if (!response.ok) {
              throw new Error('Something went wrong!');
            }
            return response.text();
          })
          .then(response => {
            console.log(response);
            loadingOverlay.style.display = 'none';
            bookingCard.style.display = 'none';
            confirmationMessage.style.display = 'block';
          })
          .catch(error => {
            console.error('Error booking ride:', error);
            loadingOverlay.style.display = 'none';
            alert('There was an error processing your booking. Please try again.');
          });
          
          // For demo, show success message
          console.log('Booking data:', bookingData);
          loadingOverlay.style.display = 'none';
          bookingCard.style.display = 'none';
          confirmationMessage.style.display = 'block';
        }, 1500);
      });
    });
    
    function redirectToHome() {
      window.location.href = "home.jsp";
    }
  </script>
</body>
</html>