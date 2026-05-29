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
                const adminPages = [
                    'admin-dashboard', 'admin-search', 'admin-product', 'admin-supplier',
                    'inventory-order-management', 'admin-report', 'admin-user-management',
                    'admin-backup', 'admin-help', 'admin-archive'
                ];
                if (adminPages.some(p => currentPath.includes(p))) {
                    isAllowed = true;
                }
            } else if (userRole === 'Inventory') {
                const inventoryPages = [
                    'inventory-screen', 'admin-product', 'admin-supplier', 'admin-search', 'admin-report', 'admin-archive'
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

            renderSidebar(data.name, userRole, availableRoles);
            setupLogoutButton();

            if (typeof window.onAuthReady === 'function') {
                window.onAuthReady(userRole);
            }
        });
});

function renderSidebar(name, role, availableRoles) {
    const sidebarContainer = document.getElementById("sidebar");
    if (!sidebarContainer) return;

    const firstName = name ? name.split(' ')[0] : 'User';
    let switchButtonsHTML = '';

    if (availableRoles.length > 1) {
        let optionsHTML = '';
        availableRoles.forEach(r => {
            const isSelected = r === role ? 'selected' : '';
            optionsHTML += `<option value="${r}" ${isSelected}>${r.toUpperCase()}</option>`;
        });

        switchButtonsHTML = `
            <div class="sidebar-role-selector" style="padding: 0 20px 0px 20px;">
                <label style="display: block; font-size: 11px; color: #8fc96a; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 2px;">Switch Role</label>
                <div class="role-select-wrapper" style="position: relative;">
                    <select id="roleSelect" onchange="switchRole(this.value)" class="premium-role-select">
                        ${optionsHTML}
                    </select>
                    <svg class="select-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%); pointer-events: none; color: rgba(255,255,255,0.6);">
                        <polyline points="6 9 12 15 18 9"></polyline>
                    </svg>
                </div>
            </div>
        `;
    } else {
        switchButtonsHTML = `
            <div class="sidebar-role-selector" style="padding: 0 20px 0px 20px;">
                <div style="color: #8fc96a; font-weight: 700; font-size: 13px; background: rgba(0, 0, 0, 0.4); padding: 10px 14px; border-radius: 6px; border: 1px solid rgba(255, 255, 255, 0.1); text-align: center; letter-spacing: 0.5px;">
                    ${role.toUpperCase()}
                </div>
            </div>
        `;
    }

    const userProfileHTML = `
        <div style="padding: 0 20px 10px 20px; margin-top: auto;">
            <button id="logoutBtn" class="logout-btn-v2" title="Logout">
                <div style="display: flex; align-items: center; gap: 10px; min-width: 0;">
                    <div style="width: 32px; height: 32px; border-radius: 50%; background: #8fc96a; color: #015332; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 14px; flex-shrink: 0;">
                        ${firstName.charAt(0).toUpperCase()}
                    </div>
                    <div style="display: flex; flex-direction: column; align-items: flex-start; min-width: 0;">
                        <span style="font-size: 13px; font-weight: 600; color: #fff; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 110px;">${firstName}</span>
                        <span style="font-size: 11px; color: rgba(255, 255, 255, 0.5);">Sign Out</span>
                    </div>
                </div>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="rgba(255, 255, 255, 0.5)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="transition: 0.2s;">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                    <polyline points="16 17 21 12 16 7"></polyline>
                    <line x1="21" y1="12" x2="9" y2="12"></line>
                </svg>
            </button>
        </div>
    `;

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
                    <a href="../admin-screen/admin-archive.html">Archive</a>
                    <a href="../admin-screen/admin-backup.html">Back-up</a>
                    <a href="../admin-screen/admin-help.html">Help</a>
                    ${switchButtonsHTML}
                </div>
                ${userProfileHTML}
            </div>
        </nav>`;

    } else if (role === 'Inventory') {
        sidebarHTML = `
          <nav class="sidebar">
            <div>
                <img id="logo" src="../assets/uc_logo.png" />
                <div class="menu">
                    <a href="../admin-screen/admin-search.html">Search</a>
                    <a href="../admin-screen/admin-product.html">Product</a>
                    <a href="../admin-screen/admin-supplier.html">Supplier</a>
                    <a href="../inventory-screen/inventory-order-management.html">Order Management</a>
                    <a href="../admin-screen/admin-report.html">Reports</a>
                    <a href="../admin-screen/admin-archive.html">Archive</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                    <a href="../inventory-screen/inventory-help.html">Help</a>
                    ${switchButtonsHTML}
                </div>
                ${userProfileHTML}
            </div>
        </nav>`;
    } else if (role === 'Sales') {
        sidebarHTML = `
          <nav class="sidebar">
            <div>
                <img id="logo" src="../assets/uc_logo.png" />
                <div class="menu">
                    <a href="../sales-screen/sales-transaction.html">Sales Transaction</a>
                    <a href="../sales-screen/sales-refund-or-exchange.html">Refund / Exchange</a>
                    <a href="../sales-screen/sales-history.html">Transaction Records</a>
                </div>
            </div>
            <div class="bottom-menu">
                <div class="menu">
                    <a href="../sales-screen/sales-help.html">Help</a>
                    ${switchButtonsHTML}
                </div>
                ${userProfileHTML}
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
            let modal = document.getElementById('alert-modal');

            // In case a page doesn't have the modal skeleton, add it
            if (!modal) {
                modal = document.createElement('div');
                modal.id = 'alert-modal';
                modal.className = 'modal-overlay';
                modal.innerHTML = `
                    <div class="modal-box">
                        <p id="alert-message" style="margin-bottom: 20px; font-size: 16px;"></p>
                        <div id="alert-actions" style="display:flex;gap:10px;justify-content:center;"></div>
                    </div>
                `;
                document.body.appendChild(modal);
            }

            const alertMessage = document.getElementById('alert-message');
            const alertActions = document.getElementById('alert-actions');

            alertMessage.innerText = "Are you sure you want to sign out?";

            alertActions.innerHTML = `
                <button class="modal-btn btn-cancel" id="logout-cancel-btn">Cancel</button>
                <button class="modal-btn btn-ok" id="logout-confirm-btn">Sign Out</button>
            `;

            modal.style.display = 'flex';

            document.getElementById('logout-cancel-btn').onclick = () => {
                modal.style.display = 'none';
            };

            document.getElementById('logout-confirm-btn').onclick = () => {
                const confirmBtn = document.getElementById('logout-confirm-btn');
                confirmBtn.innerHTML = 'Signing out...';
                confirmBtn.disabled = true;

                fetch('/api/logout', { method: 'POST' })
                    .then(response => response.json())
                    .then(() => {
                        window.location.href = '../log-in.html';
                    })
                    .catch(err => {
                        console.error("Logout failed", err);
                        modal.style.display = 'none';
                    });
            };
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