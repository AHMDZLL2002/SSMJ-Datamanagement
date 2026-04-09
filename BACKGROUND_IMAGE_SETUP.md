# Background Image Setup

## Current Status
✅ Background system sudah siap dengan:
- Transparent gradient overlay (#667eea → #764ba2 dengan 75% opacity)
- SVG placeholder building telah ditambahkan
- Login page dan semua halaman mendapat background treatment

## Untuk Menambahkan Gambar Building Asli Anda

### Method 1: File JPG/PNG (Recommended)

1. **Simpan gambar building Anda** dengan nama: `building.jpg` atau `building.png`
   - Format: JPG atau PNG
   - Resolusi: 1920x1440px atau lebih (landscape orientation)
   - File size: < 500KB (optimal)

2. **Letakkan di folder**: `public/images/`
   - Path:` d:\MYSSMJ\public\images\building.png`

3. **CSS sudah siap** untuk menggunakan gambar:
   ```css
   body {
     background-image: url('images/building.png');
   }
   ```

4. **Refresh browser** - gambar akan muncul dengan overlay gradient transparan

### Overlay Transparency
- Current: 75% transparent gradient (rgba 0.75 opacity)
- Ini maintain brand colors sambil menunjukkan gambar di belakang
- Untuk adjust opacity, edit di `style.css`:
  ```css
  body::before {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.75) 0%, rgba(118, 75, 162, 0.75) 100%);
  }
  ```
  - Ubah `0.75` ke nilai lain (0 = transparent, 1 = solid)

### File Structure
```
public/images/
├── logo-main.png
├── logo-footer.png
├── logo-placeholder.svg
├── building.svg (placeholder - akan di-replace)
└── building.jpg (letakkan gambar asli di sini)
```

### CSS Implementation Details
- `background-attachment: fixed` - gambar tetap statis saat scroll (parallax effect)
- `background-size: cover` - gambar cover seluruh viewport
- `background-position: center` - gambar centered
- `::before pseudo-element` - overlay gradient di atas gambar
- Z-index layering:
  - `body::before` (overlay): z-index 0
  - Content elements: z-index 1+

### Result
Login page akan memiliki:
- Beautiful building image background
- Semi-transparent purple gradient overlay
- Professional, high-contrast look
- All elements clearly readable
- Consistent branding colors

Untuk update gambar, cukup replace file `building.jpg` di folder `public/images/`
