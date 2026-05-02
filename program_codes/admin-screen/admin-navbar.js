document.getElementById("sidebar").innerHTML = ` 
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
             <a href="../admin-screen/admin-register.html">Register User</a>
             <a href="../admin-screen/admin-backup.html">Back-up</a>
             <a href="../admin-screen/admin-help.html">Help</a>
        </div>
        <button class="logout">Logout</button>
    </div>
</nav>   `;
