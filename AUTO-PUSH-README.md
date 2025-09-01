# 🚀 Auto Push ke GitHub

Script otomatis untuk push perubahan ke GitHub dan auto-deploy ke Vercel.

## 📋 Cara Penggunaan

### 1. Push Manual (Sekali Jalan)
```bash
# Menggunakan script bash
./auto-push.sh

# Atau menggunakan npm script
npm run push

# Atau menggunakan Node.js script
node auto-push.js
```

### 2. Watch Mode (Otomatis Memantau Perubahan)
```bash
# Menggunakan bash script dengan inotify
./watch-and-push.sh

# Atau menggunakan npm script
npm run watch-push

# Atau menggunakan Node.js dengan chokidar (perlu install dulu)
npm install chokidar
node auto-push.js --watch
```

## 🔧 Fitur

### Auto Push Script (`auto-push.sh` / `auto-push.js`)
- ✅ Otomatis menambahkan semua perubahan (`git add .`)
- ✅ Membuat commit dengan timestamp
- ✅ Push ke branch saat ini
- ✅ Jika bukan di master, otomatis merge ke master
- ✅ Push ke master untuk trigger Vercel deployment

### Watch Mode (`watch-and-push.sh` / `auto-push.js --watch`)
- 👀 Memantau perubahan file secara real-time
- 🚫 Mengabaikan file yang tidak perlu (.git, node_modules, .next, dll)
- ⏰ Debounce: menunggu 2 detik setelah perubahan terakhir
- 🔄 Otomatis menjalankan auto-push saat ada perubahan

## 🛠️ Setup

### Prerequisites untuk Watch Mode
```bash
# Untuk bash script (Linux/Mac)
sudo apt-get install inotify-tools  # Ubuntu/Debian
# atau
brew install inotify-tools          # macOS

# Untuk Node.js script
npm install chokidar
```

## 📝 Contoh Workflow

1. **Edit file** → Simpan
2. **Script otomatis** mendeteksi perubahan
3. **Auto commit** dengan timestamp
4. **Auto push** ke GitHub
5. **Vercel otomatis deploy** aplikasi

## ⚙️ Kustomisasi

Edit script sesuai kebutuhan:
- Ubah format commit message
- Tambah validasi sebelum push
- Konfigurasi file yang diabaikan
- Sesuaikan delay debounce

## 🚨 Catatan Penting

- Pastikan Git credentials sudah dikonfigurasi
- Script akan push ke branch saat ini dan master
- Vercel akan auto-deploy dari branch master
- Hentikan watch mode dengan `Ctrl+C`

## 🎯 Tips

- Gunakan **manual push** untuk kontrol penuh
- Gunakan **watch mode** saat development aktif
- Monitor deployment di Vercel dashboard
- Backup penting sebelum menggunakan auto-push