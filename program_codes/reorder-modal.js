// reorder-modal.js

// Inject the modal HTML into the body if it doesn't exist
document.addEventListener("DOMContentLoaded", () => {
    if (!document.getElementById('reorder-custom-modal')) {
        const modalHtml = `
            <div id="reorder-custom-modal" class="modal-overlay" style="display: none; z-index: 1000;">
                <div class="modal-box" style="max-width: 800px; width: 90%;">
                    <h3 id="reorder-modal-title" style="margin-top: 0;">Auto Reorder</h3>
                    <p id="reorder-modal-subtitle" class="sub-text" style="margin-bottom: 20px;"></p>
                    
                    <div style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; border-radius: 8px;">
                        <table class="data-table" style="margin: 0; width: 100%;">
                            <thead style="position: sticky; top: 0; z-index: 1;">
                                <tr>
                                    <th>Product</th>
                                    <th>Current Stock</th>
                                    <th>Order Qty</th>
                                    <th>Supplier</th>
                                    <th style="width: 40px;"></th>
                                </tr>
                            </thead>
                            <tbody id="reorder-modal-body">
                                <!-- Populated dynamically -->
                            </tbody>
                        </table>
                    </div>

                    <div id="reorder-modal-actions" style="margin-top: 20px; display: flex; justify-content: flex-end; gap: 10px;">
                        <button class="modal-btn btn-cancel" onclick="closeReorderModal()">Cancel</button>
                        <button class="modal-btn btn-ok" id="reorder-confirm-btn" onclick="submitReorder()">Confirm Reorder</button>
                    </div>
                </div>
            </div>
        `;
        document.body.insertAdjacentHTML('beforeend', modalHtml);
    }
});

let currentReorderItems = [];

function closeReorderModal() {
    const modal = document.getElementById('reorder-custom-modal');
    if (modal) modal.style.display = 'none';
    currentReorderItems = [];
}

async function openReorderModal(productID = null) {
    const btn = productID ? null : document.getElementById('btn-auto-reorder-dash') || document.getElementById('btn-auto-reorder-report');
    if (btn) {
        btn.disabled = true;
        btn.textContent = 'Loading...';
    }

    try {
        const url = productID ? `/api/auto-reorder/preview?productID=${productID}` : `/api/auto-reorder/preview`;
        const res = await fetch(url);
        const data = await res.json();

        if (!res.ok) {
            alert(data.error || 'Failed to load reorder preview.');
            return;
        }

        if (data.length === 0) {
            alert(productID ? 'No suppliers available for this product.' : 'No low-stock products with assigned suppliers found.');
            return;
        }

        currentReorderItems = data;

        data.forEach(p => {
            let bestSupplierID = p.suppliers[0].supplierID;
            let lowestPrice = Infinity;
            p.suppliers.forEach(s => {
                const sPrice = s.supplierPrice > 0 ? s.supplierPrice : Infinity;
                if (sPrice < lowestPrice) {
                    lowestPrice = sPrice;
                    bestSupplierID = s.supplierID;
                }
            });
            
            p.selectedSupplierID = bestSupplierID;
            p.selectedQuantity = Math.max(p.lowStockThreshold, 1);
        });

        renderReorderTable();

        document.getElementById('reorder-modal-title').textContent = productID ? `Reorder: ${data[0].productName}` : 'Auto Reorder All';
        document.getElementById('reorder-modal-subtitle').textContent = productID
            ? 'Adjust the order quantity and choose a supplier.'
            : 'Review the suggested order quantities and suppliers. The system has automatically selected the supplier with the lowest price for each item.';

        document.getElementById('reorder-custom-modal').style.display = 'flex';

    } catch (err) {
        console.error(err);
        alert('Could not connect to server.');
    } finally {
        if (btn) {
            btn.disabled = false;
            btn.textContent = 'Auto Reorder All';
        }
    }
}

function renderReorderTable() {
    const tbody = document.getElementById('reorder-modal-body');
    tbody.innerHTML = '';

    currentReorderItems.forEach((p, index) => {
        const supplierOptions = p.suppliers.map(s => {
            const priceLabel = s.supplierPrice ? ` (₱${s.supplierPrice.toFixed(2)})` : '';
            return `<option value="${s.supplierID}" ${s.supplierID === p.selectedSupplierID ? 'selected' : ''}>${s.supplierName}${priceLabel}</option>`;
        }).join('');

        const row = document.createElement('tr');
        row.innerHTML = `
            <td><strong>${p.productName}</strong></td>
            <td>
                <span class="${p.stockQuantity === 0 ? 'status-pill status-outstock' : 'status-pill status-lowstock'}">
                    ${p.stockQuantity}
                </span>
            </td>
            <td>
                <input type="number" min="1" value="${p.selectedQuantity}" style="width: 80px; padding: 4px;" 
                       onchange="updateReorderItem(${index}, 'selectedQuantity', this.value)">
            </td>
            <td>
                <select style="width: 100%; padding: 4px;" onchange="updateReorderItem(${index}, 'selectedSupplierID', this.value)">
                    ${supplierOptions}
                </select>
            </td>
            <td style="text-align: center;">
                <button class="btn-delete" style="padding: 4px 8px; margin: 0; min-width: unset; font-size: 10px;" onclick="removeReorderItem(${index})">X</button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

function removeReorderItem(index) {
    currentReorderItems.splice(index, 1);
    if (currentReorderItems.length === 0) {
        closeReorderModal();
    } else {
        renderReorderTable();
    }
}

function updateReorderItem(index, field, value) {
    if (currentReorderItems[index]) {
        currentReorderItems[index][field] = field === 'selectedQuantity' ? parseInt(value) || 1 : parseInt(value);
    }
}

async function submitReorder() {
    const btn = document.getElementById('reorder-confirm-btn');
    btn.disabled = true;
    btn.textContent = 'Creating Orders...';

    // Build payload
    const payloadItems = currentReorderItems.map(p => {
        const supp = p.suppliers.find(s => s.supplierID === p.selectedSupplierID);
        return {
            productID: p.productID,
            productName: p.productName,
            supplierID: p.selectedSupplierID,
            supplierName: supp ? supp.supplierName : 'Unknown',
            quantity: p.selectedQuantity,
            price: supp && supp.supplierPrice ? supp.supplierPrice : p.price
        };
    });

    try {
        const res = await fetch('/api/auto-reorder', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ items: payloadItems })
        });
        const data = await res.json();

        if (!res.ok) {
            alert(data.error || 'Failed to submit reorder.');
            return;
        }

        closeReorderModal();

        // Show success summary
        const list = data.orders.map(o =>
            `<li style="margin-bottom:4px;"><strong>PO-${o.orderID}</strong> → ${o.supplierName} (${o.itemCount} item${o.itemCount > 1 ? 's' : ''})</li>`
        ).join('');

        // Use existing modal if available, otherwise native alert
        if (typeof showInfoModal === 'function') {
            showInfoModal('Auto Reorder Complete!', `
                <strong>${data.ordersCreated} purchase order(s) created:</strong>
                <ul style="text-align:left;margin:10px 0 0 0;padding-left:18px;">${list}</ul>
                <p class="sub-text" style="margin-top:10px;">View them in Purchase Order Management.</p>
            `);
        } else if (typeof showAlert === 'function') {
            showAlert(`<strong>${data.ordersCreated} purchase order(s) created:</strong><ul style="text-align:left;margin:8px 0 0 0;padding-left:16px;">${list}</ul>`, false);
        } else if (typeof showSimpleModal === 'function') {
            showSimpleModal('Reorder Created!', `<strong>${data.ordersCreated} purchase order(s) created.</strong><br><p style="color:#777;font-size:12px;margin-top:6px;">View them in Purchase Order Management.</p>`);
        } else {
            alert(`Auto reorder complete! ${data.ordersCreated} purchase order(s) created.\n\nView them in Order Management.`);
        }

    } catch (err) {
        console.error(err);
        alert('Could not submit reorder. Check connection.');
    } finally {
        btn.disabled = false;
        btn.textContent = 'Confirm Reorder';
    }
}
