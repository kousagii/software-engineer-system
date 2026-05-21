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
            const userRole = data.role;
            const dbRole   = data.dbRole || userRole; // true DB role

            // 'Staff' covers all operational screens (sales + inventory)
            const isStaff = userRole === 'Staff';

            if (currentPath.includes('admin-screen') && userRole !== 'Admin') {
                const sharedPages = ['admin-product', 'admin-supplier', 'admin-search', 'admin-report'];
                const isSharedPage = sharedPages.some(page => currentPath.includes(page));

                // Staff can access shared admin pages (product, supplier, search, reports)
                if (!(isStaff && isSharedPage)) {
                    alert("Access Denied: Admins Only");
                    window.location.href = '../log-in.html';
                    return;
                }
            }

            // Staff can access sales-screen
            if (currentPath.includes('sales-screen') && !isStaff && userRole !== 'Admin') {
                alert("Access Denied: Staff Only");
                window.location.href = '../log-in.html';
                return;
            }

            // Staff can access inventory-screen
            if (currentPath.includes('inventory-screen') && !isStaff && userRole !== 'Admin') {
                alert("Access Denied: Staff Only");
                window.location.href = '../log-in.html';
                return;
            }

            window.currentUserRole = userRole;
            window.currentDbRole   = dbRole;

            renderSidebar(userRole, dbRole);
            setupLogoutButton();

            if (typeof window.onAuthReady === 'function') {
                window.onAuthReady(userRole);
            }
        });
});

function renderSidebar(role, dbRole) {
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
                    <button class="btn-switch-role" id="switchRoleBtn" onclick="switchRole('Staff')">
                        ⇄ Switch to Staff View
                    </button>
                </div>
                <button class="logout" id="logoutBtn">Logout</button>
            </div>
        </nav>`;

    } else if (role === 'Staff') {
        const currentPath = window.location.pathname;
        const isInventoryView = currentPath.includes('inventory-screen') || currentPath.includes('admin-screen');

        // Show "Switch to Admin View" only if user is actually an Admin in the DB
        const adminSwitchBtn = dbRole === 'Admin'
            ? `<button class="btn-switch-role" id="switchRoleBtn" onclick="switchRole('Admin')">⇄ Switch to Admin View</button>`
            : '';

        if (isInventoryView) {
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
                        <button class="btn-switch-role" onclick="window.location.href='../sales-screen/sales-transaction.html'">
                            ⇄ Switch to Sales View
                        </button>
                        ${adminSwitchBtn}
                    </div>
                    <button class="logout" id="logoutBtn">Logout</button>
                </div>
            </nav>`;
        } else {
            // Sales View
            sidebarHTML = `
              <nav class="sidebar">
                <div>
                    <img id="logo" src="../assets/uc_logo.png" />
                    <div class="menu">
                        <p class="sidebar-section-label">Sales</p>
                        <a href="../sales-screen/sales-transaction.html">Sales Transaction</a>
                        <a href="../sales-screen/sales-product-list.html">Product List</a>
                        <a href="../sales-screen/sales-refund-or-exchange.html">Refund / Exchange</a>
                        <a href="../sales-screen/sales-history.html">History</a>
                    </div>
                </div>
                <div class="bottom-menu">
                    <div class="menu">
                        <a href="../sales-screen/sales-help.html">Help</a>
                        <button class="btn-switch-role" onclick="window.location.href='../admin-screen/admin-search.html'">
                            ⇄ Switch to Inventory View
                        </button>
                        ${adminSwitchBtn}
                    </div>
                    <button class="logout" id="logoutBtn">Logout</button>
                </div>
            </nav>`;
        }
    }

    sidebarContainer.innerHTML = sidebarHTML;
}

// Switch role without logging out
// Admin can switch to Staff view and back to Admin view
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
        } else if (data.role === 'Staff') {
            window.location.href = '../sales-screen/sales-transaction.html';
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