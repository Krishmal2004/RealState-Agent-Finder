document.addEventListener("DOMContentLoaded", function () {
  // Navigation active state
  const navLinks = document.querySelectorAll(".nav-links li");
  navLinks.forEach((link) => {
    link.addEventListener("click", function () {
      navLinks.forEach((item) => item.classList.remove("active"));
      this.classList.add("active");
    });
  });

  // Property action buttons (Edit and Delete)
  const deleteButtons = document.querySelectorAll(".delete-btn");
  deleteButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      e.preventDefault();
      const propertyCard = this.closest(".property-card");
      if (confirm("Are you sure you want to remove this property?")) {
        propertyCard.style.opacity = "0";
        setTimeout(() => {
          propertyCard.style.display = "none";
        }, 300);
      }
    });
  });

  // Appointment action buttons
  const appointmentDeleteButtons = document.querySelectorAll(
    ".appointment-actions .delete-btn"
  );
  appointmentDeleteButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      e.preventDefault();
      const appointmentCard = this.closest(".appointment-card");
      if (confirm("Are you sure you want to cancel this appointment?")) {
        appointmentCard.style.opacity = "0";
        setTimeout(() => {
          appointmentCard.style.display = "none";
        }, 300);
      }
    });
  });

  // Add Property Button
  const addPropertyBtn = document.querySelector(".add-property-btn");
  addPropertyBtn.addEventListener("click", function () {
    window.location.href = "addProperty.jsp";
    // Placeholder for Add Property functionality
    alert("Add Property Form will open here");

    // In a real application, this would open a modal or redirect to a form page
  });
/*
  // Notifications and Messages Click
  const notifications = document.querySelector(".notifications");
  const messages = document.querySelector(".messages");

  notifications.addEventListener("click", function () {
    alert("Notifications panel will open here");
  });

  messages.addEventListener("click", function () {
    alert("Messages panel will open here");
  });
*/
  // Search functionality
  const searchInput = document.querySelector(".search input");
  searchInput.addEventListener("keyup", function (e) {
    if (e.key === "Enter") {
      alert(`Searching for: ${this.value}`);
      this.value = "";
    }
  });

  // Simple animation on page load
  document.querySelectorAll(".stat-card").forEach((card, index) => {
    setTimeout(() => {
      card.style.opacity = "1";
      card.style.transform = "translateY(0)";
    }, 100 * index);
  });
});

// Initial animations
document.addEventListener("DOMContentLoaded", function () {
  const statCards = document.querySelectorAll(".stat-card");
  const propertyCards = document.querySelectorAll(".property-card");

  // Apply initial styles for animation
  statCards.forEach((card) => {
    card.style.opacity = "0";
    card.style.transform = "translateY(20px)";
    card.style.transition = "opacity 0.5s ease, transform 0.5s ease";
  });

  propertyCards.forEach((card) => {
    card.style.opacity = "0";
    card.style.transform = "translateY(20px)";
    card.style.transition = "opacity 0.5s ease, transform 0.5s ease";
  });

  // Animate in after a short delay
  setTimeout(() => {
    statCards.forEach((card, index) => {
      setTimeout(() => {
        card.style.opacity = "1";
        card.style.transform = "translateY(0)";
      }, 100 * index);
    });

    setTimeout(() => {
      propertyCards.forEach((card, index) => {
        setTimeout(() => {
          card.style.opacity = "1";
          card.style.transform = "translateY(0)";
        }, 100 * index);
      });
    }, 300);
  }, 300);
});

// Add this to your existing script.js file

// Update the agent info with the user's login ID
document.addEventListener("DOMContentLoaded", function () {
  // Update agent info with login ID
  const agentInfoSection = document.querySelector(".info");
  const loginIdElement = document.createElement("span");
  loginIdElement.classList.add("login-id");
  loginIdElement.style.fontSize = "0.7rem";
  loginIdElement.style.color = "var(--accent-color)";
  loginIdElement.style.display = "block";
  loginIdElement.style.marginTop = "0.2rem";
  loginIdElement.innerHTML = '<i class="fas fa-id-badge"></i> ID: IT24102083';
  agentInfoSection.appendChild(loginIdElement);

  // Real-time clock update function
  function updateDateTime() {
    const now = new Date();
    const year = now.getUTCFullYear();
    const month = String(now.getUTCMonth() + 1).padStart(2, "0");
    const day = String(now.getUTCDate()).padStart(2, "0");
    const hours = String(now.getUTCHours()).padStart(2, "0");
    const minutes = String(now.getUTCMinutes()).padStart(2, "0");
    const seconds = String(now.getUTCSeconds()).padStart(2, "0");

    const formattedDateTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    document.getElementById("current-datetime").textContent = formattedDateTime;
  }

  // Update time immediately and then every second
  updateDateTime();
  setInterval(updateDateTime, 1000);
});

// This would typically be loaded from an external file
const notificationData = [
  {
    id: 1,
    type: "info",
    message: "Welcome to the new dashboard!",
    time: "2025-03-22T10:30:00",
    read: false,
    detailsUrl: "/notifications/1",
  },
  {
    id: 2,
    type: "alert",
    message: "Your subscription will expire in 3 days",
    time: "2025-03-21T15:45:00",
    read: false,
    detailsUrl: "/notifications/2",
  },
  {
    id: 3,
    type: "success",
    message: "Your report has been successfully generated",
    time: "2025-03-20T08:15:00",
    read: false,
    detailsUrl: "/notifications/3",
  },
];

// Notifications and Messages Click
const notifications = document.querySelector(".notifications");
const messages = document.querySelector(".messages");
const notificationPanel = document.querySelector(".notification-panel");

// Function to format the time
function formatTime(timeString) {
  const date = new Date(timeString);
  const now = new Date();
  const diffInHours = Math.floor((now - date) / (1000 * 60 * 60));

  if (diffInHours < 24) {
    return diffInHours === 0
      ? "Just now"
      : `${diffInHours} hour${diffInHours > 1 ? "s" : ""} ago`;
  } else {
    const days = Math.floor(diffInHours / 24);
    return `${days} day${days > 1 ? "s" : ""} ago`;
  }
}

// Function to render notifications
function renderNotifications() {
  const notificationList = document.querySelector(".notification-list");
  notificationList.innerHTML = "";

  // Filter to only show unread notifications
  const unreadNotifications = notificationData.filter(
    (notification) => !notification.read
  );

  if (unreadNotifications.length === 0) {
    notificationList.innerHTML =
      '<div class="empty-notification">No new notifications</div>';
    updateNotificationBadge(0);
    return;
  }

  unreadNotifications.forEach((notification) => {
    const notificationItem = document.createElement("div");
    notificationItem.className = `notification-item ${notification.type} unread`;
    notificationItem.dataset.id = notification.id;

    notificationItem.innerHTML = `
                    <div class="message">${notification.message}</div>
                    <div class="time">${formatTime(notification.time)}</div>
                    <a href="${
                      notification.detailsUrl
                    }" class="details-link">More Details</a>
                `;

    // Mark as read when clicked on the notification (but not on the details link)
    notificationItem.addEventListener("click", function (e) {
      // Don't mark as read when clicking the "More Details" link
      if (!e.target.classList.contains("details-link")) {
        const id = parseInt(this.dataset.id);
        const notification = notificationData.find((n) => n.id === id);
        if (notification) {
          notification.read = true;
          this.classList.add("fade-out");
          setTimeout(() => {
            renderNotifications();
          }, 300);
        }
      }
    });

    // Prevent "More Details" link from triggering the parent click event
    const detailsLink = notificationItem.querySelector(".details-link");
    detailsLink.addEventListener("click", function (e) {
      e.stopPropagation();
      // You could either follow the link or open a modal
      // If you want to open a modal instead of navigating:
      // e.preventDefault();
      // openNotificationModal(notification.id);
    });

    notificationList.appendChild(notificationItem);
  });

  // Update notification badge with unread count
  updateNotificationBadge(unreadNotifications.length);
}

// Function to update notification badge
function updateNotificationBadge(count) {
  let badge = notifications.querySelector(".notification-badge");

  if (count === 0) {
    if (badge) badge.remove();
    return;
  }

  if (!badge) {
    badge = document.createElement("span");
    badge.className = "notification-badge";
    notifications.appendChild(badge);
  }

  badge.textContent = count > 9 ? "9+" : count;
}

// Initialize notifications
renderNotifications();

// Toggle notification panel
notifications.addEventListener("click", function (e) {
  e.stopPropagation();
  notificationPanel.classList.toggle("show");

  // Toggle active class for bell styling
  notifications.classList.toggle("active");

  // If you have a messages panel, close it when opening notifications
  if (
    messages &&
    messages.nextElementSibling &&
    messages.nextElementSibling.classList.contains("show")
  ) {
    messages.nextElementSibling.classList.remove("show");
  }
});

// Mark all as read button
document
  .querySelector(".mark-all-read")
  .addEventListener("click", function (e) {
    e.stopPropagation(); // Prevent the panel from closing

    // Add fade-out animation to all items
    const items = document.querySelectorAll(".notification-item");
    items.forEach((item) => {
      item.classList.add("fade-out");
    });

    // Mark all as read
    notificationData.forEach((notification) => {
      notification.read = true;
    });

    // Wait for animation then update display
    setTimeout(() => {
      renderNotifications();
    }, 300);
  });

// Close panel when clicking outside
document.addEventListener("click", function (e) {
  if (
    notificationPanel.classList.contains("show") &&
    !notificationPanel.contains(e.target) &&
    e.target !== notifications
  ) {
    notificationPanel.classList.remove("show");
    notifications.classList.remove("active"); // Remove active class from bell
  }
});

/*
// Keep the messages functionality
if (messages) {
  messages.addEventListener("click", function () {
    alert("Messages panel will open here");
  });
}*/

// Add a little bell animation when the page loads to draw attention
setTimeout(() => {
  notifications.classList.add("active");
  setTimeout(() => {
    notifications.classList.remove("active");
  }, 1000);
}, 1500);

// Add this after your notifications code

// Sample message data - this would normally come from a backend
const messageData = [
  {
    id: 1,
    sender: "Sarah Thompson",
    avatar: "https://randomuser.me/api/portraits/women/65.jpg",
    content: "Hi John, is the house on Oak Street still available for viewing?",
    time: "2025-03-22T09:15:00",
    read: false
  },
  {
    id: 2,
    sender: "Michael Brown",
    avatar: "https://randomuser.me/api/portraits/men/32.jpg",
    content: "Thanks for the contract. I've reviewed it and have a few questions.",
    time: "2025-03-21T14:30:00",
    read: false
  },
  {
    id: 3,
    sender: "Jennifer Wilson",
    avatar: "https://randomuser.me/api/portraits/women/42.jpg",
    content: "Can we reschedule tomorrow's appointment to 4pm instead?",
    time: "2025-03-20T16:45:00",
    read: false
  }
];

// Message panel functionality
const messagePanel = document.querySelector(".message-panel");

// Function to render messages
function renderMessages() {
  const messageList = document.querySelector(".message-list");
  messageList.innerHTML = "";

  // Filter to only show unread messages
  const unreadMessages = messageData.filter(message => !message.read);

  if (unreadMessages.length === 0) {
    messageList.innerHTML = '<div class="empty-message">No new messages</div>';
    updateMessageBadge(0);
    return;
  }

  unreadMessages.forEach(message => {
    const messageItem = document.createElement("div");
    messageItem.className = `message-item unread`;
    messageItem.dataset.id = message.id;

    messageItem.innerHTML = `
      <div class="message-sender">
        <img src="${message.avatar}" alt="${message.sender}">
        <div class="sender-info">
          <h4>${message.sender}</h4>
          <span class="time">${formatTime(message.time)}</span>
        </div>
      </div>
      <div class="message-content">${message.content}</div>
      <div class="message-actions">
        <button class="reply-btn"><i class="fas fa-reply"></i> Reply</button>
      </div>
    `;

    // Mark as read when clicked on the message item
    messageItem.addEventListener("click", function(e) {
      if (!e.target.closest('.message-actions')) {
        const id = parseInt(this.dataset.id);
        const message = messageData.find(m => m.id === id);
        if (message) {
          message.read = true;
          this.classList.add("fade-out");
          setTimeout(() => {
            renderMessages();
          }, 300);
        }
      }
    });

    // Handle reply button
    const replyBtn = messageItem.querySelector(".reply-btn");
    replyBtn.addEventListener("click", function(e) {
      e.stopPropagation();
      alert(`Replying to ${message.sender}`);
      // Here you would typically open a reply form or chat interface
    });

    messageList.appendChild(messageItem);
  });

  // Update message badge with unread count
  updateMessageBadge(unreadMessages.length);
}

// Function to update message badge
function updateMessageBadge(count) {
  let badge = messages.querySelector(".badge");

  if (count === 0) {
    if (badge) badge.remove();
    return;
  }

  if (!badge) {
    badge = document.createElement("span");
    badge.className = "badge";
    messages.appendChild(badge);
  }

  badge.textContent = count > 9 ? "9+" : count;
}

// Initialize messages
renderMessages();

// Toggle message panel
messages.addEventListener("click", function(e) {
  e.stopPropagation();
  messagePanel.classList.toggle("show");
  
  // Toggle active class for envelope styling
  messages.classList.toggle("active");
  
  // Close notification panel if it's open
  if (notificationPanel.classList.contains("show")) {
    notificationPanel.classList.remove("show");
    notifications.classList.remove("active");
  }
});

// Mark all messages as read button
document.querySelector(".mark-all-read-msg").addEventListener("click", function(e) {
  e.stopPropagation(); // Prevent the panel from closing
  
  // Add fade-out animation to all items
  const items = document.querySelectorAll(".message-item");
  items.forEach(item => {
    item.classList.add("fade-out");
  });
  
  // Mark all as read
  messageData.forEach(message => {
    message.read = true;
  });
  
  // Wait for animation then update display
  setTimeout(() => {
    renderMessages();
  }, 300);
});

// Close message panel when clicking outside
document.addEventListener("click", function(e) {
  if (messagePanel.classList.contains("show") && 
      !messagePanel.contains(e.target) && 
      e.target !== messages) {
    messagePanel.classList.remove("show");
    messages.classList.remove("active"); // Remove active class from envelope
  }
});

// Add a little envelope animation when the page loads after the bell animation
setTimeout(() => {
  setTimeout(() => {
    messages.classList.add("active");
    setTimeout(() => {
      messages.classList.remove("active");
    }, 1000);
  }, 1000);
}, 1500);