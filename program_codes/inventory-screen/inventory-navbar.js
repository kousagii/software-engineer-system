document.getElementById("sidebar").innerHTML = ` 
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
        <button class="logout">Logout</button>
    </div>
</nav>   
`;
