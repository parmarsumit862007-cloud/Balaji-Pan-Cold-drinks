# Balaji Pan & Cold Drink — Online Shop

Full-Stack React (Vite) + PHP 8 REST API + MySQL + Bilingual (English & Gujarati) + Installable PWA.

```
balaji-pan-website/
├── frontend/                                   React app (Vite, React Router, i18next)
├── backend/                                    PHP 8 API (PDO MySQL, JWT-style bearer auth)
├── database/schema.sql                         Full MySQL database schema & 50 sample products
├── database/migration_categories_and_products.sql Safe migration for existing installations
├── database/apply_migration.php                One-step UTF-8 safe migration runner
├── uploads/                                    Product SVG & photo assets
├── start-all.bat                               One-click local startup script
└── powershell.bat                              Windows PowerShell execution helper
```

## Features

- **Shop & Categories**: Home hero, browse by 9 categories:
  - 🍃 Pan
  - 🥤 Cold Drinks
  - 💧 Water & Soda
  - 🍿 Snacks
  - 🍫 Chocolates *(New)*
  - 🍪 Biscuits *(New)*
  - 🌿 Mouth Fresheners
  - 🍦 Ice Cream
  - 🧃 Juices
- **Product Display**: 50 pre-populated products with prices in INR (₹), MRP discounts, stock tags, lazy-loaded vector images, and fallback shields.
- **Search & Filter**: Real-time bilingual search (English + Gujarati), category chip filtering, and sorting (Popular, Price Low-High, Price High-Low, Newest).
- **Cart & Quantity**: Persistent cart in `localStorage`, quantity stepper with stock constraints, subtotal, delivery fee calculation (free delivery above threshold).
- **Customer Checkout**: Input validation (10-digit mobile, 6-digit PIN), Cash on Delivery (COD) and Online options, order notes, atomic stock decrement in MySQL transactions.
- **Order Tracking**: Track order status with live progress bar (`Pending` → `Confirmed` → `Preparing` → `Packed` → `Out for Delivery` → `Delivered`), order cancellation for pending orders.
- **Admin Authentication**: Secure login at `/admin/login`, role verification (`admin`), password hashing with `PASSWORD_DEFAULT` (bcrypt), HMAC-SHA256 signed bearer tokens with 14-day expiry.
- **Admin Dashboard**: Live metrics (Total Sales, Today's Sales, Orders, Customers, Products), 7-day sales bar chart, low stock alerts, recent orders, top-selling items.
- **Admin Product Management**: Add, edit, delete products, upload photos (JPG, PNG, WebP), manage Gujarati translations, inline stock editor with auto-save.
- **Admin Order Management**: Filter orders by status, change lifecycle status with automatic stock return on cancellation, mark paid, print customer invoices.
- **Sales & Business Reports**: Filter by 7, 30, 90 days, daily revenue & order count breakdown, top revenue-generating products, export report to CSV, print report.
- **Bilingual (English / ગુજરાતી)**: Instant switcher in the header, navbar, and admin panel with Gujarati font support (`Noto Sans Gujarati` & `Baloo Bhai 2`).
- **Mobile Responsive & PWA**: Mobile drawer menu, fluid grid, touch-friendly 44px buttons, web app manifest, offline service worker shell caching.

---

## Quick Start (Run Locally)

### Option 1: One-Click Launcher (Recommended on Windows)
Simply double-click:
```bat
start-all.bat
```
This automatically verifies MySQL on port 3306, starts the PHP API on port 8000, starts Vite on port 5173, and opens your browser.

### Option 2: Manual Commands

1. **Start MySQL**:
   Make sure MySQL is running in XAMPP on port 3306 (database: `balaji_pan`).

2. **Start the PHP API Backend** (Port 8000):
   ```bash
   cd backend
   php -S localhost:8000 dev-router.php
   ```

3. **Start the React Frontend** (Port 5173):
   ```bash
   cd frontend
   npm run dev
   ```

4. **Access the application**:
   - Customer Shop: [http://localhost:5173](http://localhost:5173)
   - Admin Panel: [http://localhost:5173/admin/login](http://localhost:5173/admin/login)
   - Backend API: [http://localhost:8000/api/products](http://localhost:8000/api/products)

---

## Admin Credentials

- **Email**: `admin@balajipan.com`
- **Password**: `Admin@123456`

---

## Testing Each Feature

1. **Product Display**: Open `http://localhost:5173/products` — observe all 50 products across Pan, Cold Drinks, Water, Snacks, Chocolates, Biscuits, and Mouth Fresheners with images and ₹ INR pricing.
2. **Category Filter**: Click on "Chocolates" 🍫 or "Cold Drinks" 🥤 chips to verify real-time filtering.
3. **Search**: Search "Pan" or "ચોકલેટ" or "Chips" to verify search works in both English and Gujarati.
4. **Cart & Stepper**: Click "Add to Cart", increase/decrease quantity, verify subtotal and delivery charge calculations.
5. **Checkout**: Proceed to `/checkout`, enter delivery details, place an order with COD, and verify redirect to `/order/:number`.
6. **Track Order**: Click "Track Order" or visit `/track?number=<your-order-number>&phone=<phone>` to view status timeline.
7. **Admin Dashboard**: Log in at `/admin/login` using credentials above. Verify sales chart and metrics.
8. **Product Management**: In Admin → Products, add a new item or edit stock inline.
9. **Order Management**: In Admin → Orders, change status to "Confirmed" or "Delivered".
10. **Reports**: In Admin → Reports, view 30-day breakdown, click "Export to CSV", and test "Print Report".
11. **Language Switching**: Toggle between English and ગુજરાતી using the switcher in the top bar.

---

## Deployment to Production

Refer to [DEPLOY.md](DEPLOY.md) for full cPanel / Apache / Nginx production setup.
