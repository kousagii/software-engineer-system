// authGuard.js
document.addEventListener("DOMContentLoaded", () => {
    fetch('/api/auth-status')
        .then(response => response.json())
        .then(data => {
            if (!data.loggedIn) {
                window.location.href = '../log-in.html';
                return;
            }

            const currentPath = window.location.pathname;
            const userRole = data.role; // e.g., Admin, Sales, or Inventory
            const availableRoles = data.availableRoles || [];

            // Access Control Logic
            let isAllowed = false;
            
            if (userRole === 'Admin') {
                isAllowed = true; // Admin can access everything
            } else if (userRole === 'Inventory') {
                const inventoryPages = [
                    'inventory-screen', 'admin-product', 'admin-supplier', 'admin-search', 'admin-report'
                ];
                if (inventoryPages.some(p => currentPath.includes(p))) {
                    isAllowed = true;
                }
            } else if (userRole === 'Sales') {
                if (currentPath.includes('sales-screen')) {
                    isAllowed = true;
                }
            }

            if (!isAllowed) {
                alert("Access Denied: Your current role does not have permission for this page.");
                window.location.href = '../log-in.html';
                return;
            }

            window.currentUserRole = userRole;
            window.availableRoles = availableRoles;

            renderSidebar(userRole, availableRoles);
            setupLogoutButton();

            if (typeof window.onAuthReady === 'function') {
                window.onAuthReady(userRole);
            }
        });
});

function renderSidebar(role, availableRoles) {
    const sidebarContainer = document.getElementById("sidebar");
    if (!sidebarContainer) return;

    let switchButtonsHTML = '';
    if (availableRoles.length > 1) {
        if (role !== 'Admin' && availableRoles.includes('Admin')) {
            switchButtonsHTML += `<button class="btn-switch-role" onclick="switchRole('Admin')">⇄ Switch to Admin View</button>`;
        }
        if (role !== 'Inventory' && availableRoles.includes('Inventory')) {
            switchButtonsHTML += `<button class="btn-switch-role" onclick="switchRole('Inventory')">⇄ Switch to Inventory View</button>`;
        }
        if (role !== 'Sales' && availableRoles.includes('Sales')) {
            switchButtonsHTML += `<button class="btn-switch-role" onclick="switchRole('Sales')">⇄ Switch to Sales View</button>`;
        }
    }

    let sidebarHTML = '';

    if (role === 'Admin') {
        sidebarHTML = `
          <nav class="sidebar">
            <div>
                <img id="logo" src="../assets/uc_logo.png" />
                <div class="menu">
                    <a href="../admin-screen/admin-dashboard.html">Dashboard</a>
                    <a href="../admin-screen/admin-search.html">Search</a>
                    <a href="../admin-screen/admin-product.html">Product</a>
                    <a href="../admin-screen/admin-supplier.html">Supplier</a>
                    <a href="../inventory-screen/inventory-order-management.html">Order Management</a>
                    <a href="../admin-screen/admin-report.html">Reports</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                    <a href="../admin-screen/admin-user-management.html">User Management</a>
                    <a href="../admin-screen/admin-backup.html">Back-up</a>
                    <a href="../admin-screen/admin-help.html">Help</a>
                    ${switchButtonsHTML}
                </div>
                <button class="logout" id="logoutBtn">Logout</button>
            </div>
        </nav>`;

    } else if (role === 'Inventory') {
        sidebarHTML = `
          <nav class="sidebar">
            <div>
                <img id="logo" src="../assets/uc_logo.png" />
                <div class="menu">
                    <p class="sidebar-section-label">Inventory</p>
                    <a href="../admin-screen/admin-search.html">Search</a>
                    <a href="../admin-screen/admin-product.html">Product</a>
                    <a href="../admin-screen/admin-supplier.html">Supplier</a>
                    <a href="../inventory-screen/inventory-order-management.html">Order Management</a>
                    <a href="../admin-screen/admin-report.html">Reports</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                    <a href="../inventory-screen/inventory-help.html">Help</a>
                    ${switchButtonsHTML}
                </div>
                <button class="logout" id="logoutBtn">Logout</button>
            </div>
        </nav>`;
    } else if (role === 'Sales') {
        sidebarHTML = `
          <nav class="sidebar">
            <div>
                <img id="logo" src="../assets/uc_logo.png" />
                <div class="menu">
                    <p class="sidebar-section-label">Sales</p>
                    <a href="../sales-screen/sales-transaction.html">Sales Transaction</a>
                    <a href="../sales-screen/sales-refund-or-exchange.html">Refund / Exchange</a>
                    <a href="../sales-screen/sales-history.html">History</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                    <a href="../sales-screen/sales-help.html">Help</a>
                    ${switchButtonsHTML}
                </div>
                <button class="logout" id="logoutBtn">Logout</button>
            </div>
        </nav>`;
    }

    sidebarContainer.innerHTML = sidebarHTML;

    // Dynamically highlight active sidebar link
    const currentPath = window.location.pathname;
    const links = sidebarContainer.querySelectorAll('.menu a');
    links.forEach(link => {
        const href = link.getAttribute('href');
        if (href) {
            const cleanHref = href.replace(/^\.\.\//, '');
            if (currentPath.includes(cleanHref)) {
                link.classList.add('active');
            }
        }
    });
}

// Switch role via API
function switchRole(newRole) {
    fetch('/api/switch-role', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ role: newRole })
    })
        .then(r => r.json())
        .then(data => {
            if (data.role === 'Admin') {
                window.location.href = '../admin-screen/admin-dashboard.html';
            } else if (data.role === 'Sales') {
                window.location.href = '../sales-screen/sales-transaction.html';
            } else if (data.role === 'Inventory') {
                window.location.href = '../admin-screen/admin-search.html';
            } else {
                alert(data.error || 'Could not switch role.');
            }
        })
        .catch(err => {
            console.error('Switch role failed', err);
            alert('Could not switch role. Please try again.');
        });
}

function setupLogoutButton() {
    const logoutBtn = document.getElementById("logoutBtn");
    if (logoutBtn) {
        logoutBtn.addEventListener("click", () => {
            fetch('/api/logout', { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    window.location.href = '../log-in.html';
                })
                .catch(err => console.error("Logout failed", err));
        });
    }
}

// --- Global Input Validation ---
document.addEventListener("DOMContentLoaded", () => {
    // 1. Prevent non-numeric keys in type="number"
    document.body.addEventListener('keydown', (e) => {
        if (e.target && e.target.tagName === 'INPUT') {
            if (e.target.type === 'number') {
                // Prevent e, E, +, -
                const invalidChars = ['e', 'E', '+', '-'];
                if (invalidChars.includes(e.key)) {
                    e.preventDefault();
                }
            }
        }
    });

    // 2. Real-time scrubbing for specific fields (like contact numbers typed as text)
    document.body.addEventListener('input', (e) => {
        if (e.target && e.target.tagName === 'INPUT') {
            const id = e.target.id ? e.target.id.toLowerCase() : '';
            const placeholder = e.target.placeholder ? e.target.placeholder.toLowerCase() : '';

            // If it's a contact field and not explicitly allowing email
            if (id.includes('contact') && !placeholder.includes('email')) {
                // Keep only digits
                e.target.value = e.target.value.replace(/[^0-9]/g, '');
            }
        }
    });

    // 3. Validate email on change
    document.body.addEventListener('change', (e) => {
        if (e.target && e.target.tagName === 'INPUT' && e.target.type === 'email') {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (e.target.value && !emailRegex.test(e.target.value)) {
                alert("Please enter a valid email address.");
                e.target.value = ""; // Clear the invalid input
                e.target.focus();
            }
        }
    });
});