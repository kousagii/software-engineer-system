// sales-shared.js
// Shared UI utilities for the sales-screen modules

function showToast(message, isError = false) {
    const toast = document.getElementById("toast");
    if (!toast) return;
    toast.innerText = message;
    toast.className = isError ? "show error" : "show";
    setTimeout(() => {
        toast.className = toast.className.replace("show", "").replace("error", "").trim();
    }, 3000);
}

function closeModal(modalId) {
    const element = document.getElementById(modalId);
    if (element) {
        element.style.display = 'none';
    }
}

function printReceipt(containerId = 'printableReceipt') {
    const receiptEl = document.getElementById(containerId);
    if (!receiptEl) return;
    const printWin = window.open('', '_blank', 'width=800,height=1000');
    printWin.document.write(`
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Receipt</title>
            <link rel="stylesheet" href="../style.css">
            <style>
                @page { size: 80mm auto; margin: 4mm; }
                body { background: white; margin: 0; padding: 0; display: flex; justify-content: center; font-family: 'Arial Narrow', Arial, Helvetica, sans-serif; }
                .receipt-container { box-shadow: none; margin-top: 0; font-family: 'Arial Narrow', Arial, Helvetica, sans-serif; }
                .no-print { display: none !important; }
            </style>
        </head>
        <body onload="setTimeout(() => { window.print(); window.close(); }, 150);">
            <div id="receiptModal">
                ${receiptEl.outerHTML}
            </div>
        </body>
        </html>
    `);
    printWin.document.close();
    printWin.focus();

}

function generateTransactionID(prefix = "TRX") {
    const now = new Date();
    const yy = String(now.getFullYear()).slice(-2);
    const mm = String(now.getMonth() + 1).padStart(2, '0');
    const dd = String(now.getDate()).padStart(2, '0');
    const randomChars = Math.random().toString(36).substring(2, 6).toUpperCase();
    return `${prefix}-${yy}${mm}${dd}-${randomChars}`;
}
