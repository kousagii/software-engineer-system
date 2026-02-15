document.getElementById("sidebar").innerHTML = ` 
  <nav class="sidebar">     
    <div>
        <img id="logo" src="../assets/uc_logo.png" />
        <div class="menu">
            <a href="admin-dashboard.html">Dashboard</a>
            <a href="admin&inventory-search.html">Search</a>
            <a href="admin&inventory-product.html">Product</a>
            <a href="admin&inventory-supplier.html">Supplier</a>
            <a href="admin-report.html">Reports</a>
        </div>
    </div>

    <div class="bottom-menu">
        <div class="menu">
             <a href="admin-register.html">Register User</a>
             <a href="admin-backup.html">Back-up</a>
             <a href="admin-help.html">Help</a>
        </div>
        <button class="logout">Logout</button>
    </div>
</nav>   `;
