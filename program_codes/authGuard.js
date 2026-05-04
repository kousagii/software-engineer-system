// authGuard.js
document.addEventListener("DOMContentLoaded", () => {
    // 1. Ask the server who is logged in
    fetch('/api/auth-status')
        .then(response => response.json())
        .then(data => {
            if (!data.loggedIn) {
                window.location.href = '../log-in.html';
                return;
            }

            const currentPath = window.location.pathname;
            const userRole = data.role;

            // 2. Role-Based Page Protection
            if (currentPath.includes('admin-screen') && userRole !== 'Admin') {
                alert("Access Denied: Admins Only");
                window.location.href = '../log-in.html';
                return;
            }
            if (currentPath.includes('sales-screen') && userRole !== 'SalesStaff') {
                alert("Access Denied: Sales Staff Only");
                window.location.href = '../log-in.html';
                return;
            }
            if (currentPath.includes('inventory-screen') && userRole !== 'InventoryStaff') {
                alert("Access Denied: Inventory Staff Only");
                window.location.href = '../log-in.html';
                return;
            }

            // 3. Render the Correct Sidebar
            renderSidebar(userRole);

            // 4. Activate the Logout Button
            setupLogoutButton();
        });
});

// Function to inject the correct sidebar HTML based on Role
function renderSidebar(role) {
    const sidebarContainer = document.getElementById("sidebar");
    if (!sidebarContainer) return; 

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
                    <a href="../admin-screen/admin-report.html">Reports</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                     <a href="../admin-screen/admin-user-management.html">User Management</a>
                     <a href="../admin-screen/admin-backup.html">Back-up</a>
                     <a href="../admin-screen/admin-help.html">Help</a>
                </div>
                <button class="logout" id="logoutBtn">Logout</button>
            </div>
        </nav>`;
    } else if (role === 'SalesStaff') {
        sidebarHTML = ` 
          <nav class="sidebar">    
            <div>
                <img id="logo" src="../assets/uc_logo.png" />
                <div class="menu">
                    <a href="../sales-screen/sales-transaction.html">Sales Transaction</a>
                    <a href="../sales-screen/sales-product-list.html">Product List</a>
                    <a href="../sales-screen/sales-refund-or-change.html">Refund / Change</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                     <a href="../sales-screen/sales-help.html">Help</a>
                </div>
                <button class="logout" id="logoutBtn">Logout</button>
            </div>
        </nav>`;
    } else if (role === 'InventoryStaff') {
        sidebarHTML = ` 
          <nav class="sidebar">    
            <div>
                <img id="logo" src="../assets/uc_logo.png" />
                <div class="menu">
                    <a href="../inventory-screen/inventory-search.html">Search</a>
                    <a href="../inventory-screen/inventory-product.html">Product</a>
                    <a href="../inventory-screen/inventory-supplier.html">Supplier</a>
                    <a href="../inventory-screen/inventory-order-management.html">Order Management</a>
                    <a href="../inventory-screen/inventory-report.html">Reports</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                     <a href="../inventory-screen/inventory-help.html">Help</a>
                </div>
                <button class="logout" id="logoutBtn">Logout</button>
            </div>
        </nav>`;
    }

    sidebarContainer.innerHTML = sidebarHTML;
}

// Function to make the Logout button actually work
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