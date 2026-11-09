# Deploy to the internet (cPanel / shared hosting with PHP + MySQL)

You need: a domain, hosting with PHP 8+, MySQL and HTTPS (free SSL in cPanel → "SSL/TLS Status"). HTTPS is required for the PWA.

## 1. Build the website (on your computer)
```
cd frontend
npm install
npm run build
```
This creates `frontend/dist/`.

## 2. Create the database
cPanel → **MySQL Databases**: create a database, a user, and add the user to the database with ALL PRIVILEGES.
Then cPanel → **phpMyAdmin** → select the database → **Import** → choose `database/schema.sql` → Go.

## 3. Configure the backend
Open `backend/config.php` and set `db_name`, `db_user`, `db_pass` (cPanel adds a prefix, e.g. `abc123_balaji`),
a long random `token_secret`, and your own `setup_key`. Keep `allowed_origin` empty.

## 4. Upload (cPanel → File Manager → `public_html`)
| Upload this | To this place |
|---|---|
| everything **inside** `frontend/dist/` (index.html, assets/, sw.js, manifest, icons/, **.htaccess**) | `public_html/` |
| the `backend/` folder contents (except `dev-router.php`) | `public_html/api/` |
| the `uploads/` folder contents (including `.htaccess`) | `public_html/uploads/` |

Tip: in File Manager enable "Show Hidden Files" so `.htaccess` is visible. Set `uploads/` permission to 755.
Final layout: `public_html/index.html`, `public_html/api/index.php`, `public_html/uploads/`.

## 5. Create the admin account
Open `https://yourdomain.com/api/install.php`, enter name, email, password and your `setup_key`.
**Then delete `public_html/api/install.php`.** Log in at `https://yourdomain.com/admin/login`.

## 6. First-time setup in the admin panel
Settings → shop name, phone, address, delivery charge, free-delivery amount, opening hours. Products → edit prices/stock, upload photos, add Gujarati names.

## 7. Test
Open the site on a phone → add to cart → place an order → see it in Admin → Orders → change status → track it from the "Track Order" page.
Chrome shows "Install App" (or Add to Home Screen). Switch language with the selector in the header.

## Troubleshooting
- Blank page / refresh gives 404: `.htaccess` missing in `public_html/`.
- Products do not load: check `api/config.php` DB details; open `https://yourdomain.com/api/products` — it should show JSON.
- Admin login says not authorised on every page: your host strips the Authorization header — the provided `api/.htaccess` fixes this; make sure it was uploaded.
- Image upload fails: `uploads/` must be writable (755) and PHP `upload_max_filesize` ≥ 3M.
- Site in a sub-folder (domain.com/shop)? Not supported out of the box; use the domain root or a subdomain.

## VPS (Nginx) note
Serve `dist/` as the root with `try_files $uri /index.html;`, route `/api` to PHP-FPM (`index.php` as front controller) and serve `/uploads` as static files.
