// Modal handling functionality
const modal = document.getElementById('editModal');
const editForm = document.getElementById('editForm');

// Open the edit modal and populate it with data from the appointment card
function openEditModal(appointmentId) {
    // Get the appointment card
    const card = document.getElementById('appointment-' + appointmentId);
    
    if (!card) return;
    
    // Extract values from the appointment card
    const date = card.querySelector('.appointment-date').textContent;
    const time = card.querySelector('.appointment-time').textContent;
    const duration = card.querySelector('.appointment-duration').textContent.split(':')[1].trim().replace(' mins', '');
    const property = card.querySelector('.property-name').textContent;
    const customer = card.querySelector('.customer-name').textContent.split(':')[1].trim();
    
    // Format time for the input (HH:MM)
    let timeForInput = '';
    if (time.includes('AM') || time.includes('PM')) {
        // Convert from 12-hour to 24-hour format for the input
        let [hourMin, period] = time.split(' ');
        let [hour, min] = hourMin.split(':');
        hour = parseInt(hour);
        
        if (period === 'PM' && hour < 12) {
            hour += 12;
        } else if (period === 'AM' && hour === 12) {
            hour = 0;
        }
        
        timeForInput = `${hour.toString().padStart(2, '0')}:${min}`;
    } else {
        timeForInput = time; // Already in HH:MM format
    }
    
    // Populate the form
    document.getElementById('appointmentId').value = appointmentId;
    document.getElementById('appointmentDate').value = date;
    document.getElementById('appointmentTime').value = timeForInput;
    document.getElementById('appointmentDuration').value = duration;
    document.getElementById('propertyName').value = property;
    document.getElementById('customerName').value = customer;
    
    // Show the modal
    modal.style.display = 'block';
}

// Close the modal
function closeModal() {
    modal.style.display = 'none';
}

// Handle form submission
editForm.addEventListener('submit', function(event) {
    event.preventDefault();
    
    const appointmentId = document.getElementById('appointmentId').value;
    const date = document.getElementById('appointmentDate').value;
    const timeInput = document.getElementById('appointmentTime').value;
    const duration = document.getElementById('appointmentDuration').value;
    const property = document.getElementById('propertyName').value;
    const customer = document.getElementById('customerName').value;
    
    // Format time from 24-hour to 12-hour format with AM/PM
    let formattedTime = '';
    if (timeInput) {
        const [hours, minutes] = timeInput.split(':');
        const hour = parseInt(hours);
        const ampm = hour >= 12 ? 'PM' : 'AM';
        const hour12 = hour % 12 || 12;
        formattedTime = `${hour12}:${minutes} ${ampm}`;
    }

    // Send data to servlet
    const formData = new URLSearchParams();
    formData.append('action', 'edit');
    formData.append('id', appointmentId);
    formData.append('date', date);
    formData.append('time', formattedTime);
    formData.append('duration', duration);
    formData.append('propertyName', property);
    formData.append('customerName', customer);

    fetch('AppointmentServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData.toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Update the appointment card
            const card = document.getElementById('appointment-' + appointmentId);
            
            if (card) {
                card.querySelector('.appointment-date').textContent = date;
                card.querySelector('.appointment-time').textContent = formattedTime;
                card.querySelector('.appointment-duration').innerHTML = '<span>Duration:</span> ' + duration + ' mins';
                card.querySelector('.property-name').textContent = property;
                card.querySelector('.customer-name').innerHTML = '<span>Customer:</span> ' + customer;
            }
            
            // Close the modal
            closeModal();
            
            // Show success message
            alert('Appointment updated successfully!');
        } else {
            alert('Error updating appointment: ' + data.error);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error updating appointment');
    });
});

// Confirm and delete an appointment
function confirmDelete(appointmentId) {
    if (confirm('Are you sure you want to delete this appointment?')) {
        // Send delete request to servlet
        const formData = new URLSearchParams();
        formData.append('action', 'delete');
        formData.append('id', appointmentId);

        fetch('AppointmentServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData.toString()
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const card = document.getElementById('appointment-' + appointmentId);
                if (card) {
                    card.remove();
                }
                alert('Appointment deleted successfully!');
            } else {
                alert('Error deleting appointment: ' + data.error);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error deleting appointment');
        });
    }
}

// Close the modal if the user clicks outside of it
window.onclick = function(event) {
    if (event.target == modal) {
        closeModal();
    }
}

// Load initial appointments when page loads
function loadAppointments() {
    fetch('AppointmentServlet')
        .then(response => response.json())
        .then(data => {
            if (data.appointments) {
                const container = document.querySelector('.appointments-grid');
                container.innerHTML = ''; // Clear existing appointments
                
                data.appointments.forEach(appointment => {
                    const appointmentCard = createAppointmentCard(appointment);
                    container.appendChild(appointmentCard);
                });
            }
        })
        .catch(error => {
            console.error('Error loading appointments:', error);
        });
}

// Create appointment card HTML
function createAppointmentCard(appointment) {
    const card = document.createElement('div');
    card.className = 'appointment-card';
    card.id = 'appointment-' + appointment.id;
    
    card.innerHTML = `
        <div class="card-header">
            <div class="appointment-date">${appointment.date}</div>
            <div class="appointment-time">${appointment.time}</div>
        </div>
        <div class="card-body">
            <div class="property-info">
                <h3 class="property-name">${appointment.propertyName}</h3>
                <div class="customer-name"><span>Customer:</span> ${appointment.customerName}</div>
            </div>
            <div class="appointment-details">
                <div class="appointment-duration"><span>Duration:</span> ${appointment.duration} mins</div>
            </div>
        </div>
        <div class="card-actions">
            <button class="btn-edit" onclick="openEditModal(${appointment.id})">Edit</button>
            <button class="btn-delete" onclick="confirmDelete(${appointment.id})">Delete</button>
        </div>
    `;
    
    return card;
}

// Load appointments when page loads
document.addEventListener('DOMContentLoaded', loadAppointments);