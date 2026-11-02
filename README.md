# Antigravity Memory Bank

Sistem manajemen memori persisten dan pelacak progres tugas untuk Google Antigravity.

Dirancang agar asisten AI dapat mempertahankan konteks profil, preferensi kerja, dan kelanjutan progres proyek lintas sesi tanpa membebani penggunaan token.

---

## Instalasi Cepat (One-Liner)

Jalankan perintah berikut di terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/0xposa/antigravity-memory-bank/main/install.sh | bash
```

Perintah di atas akan secara otomatis menyiapkan:
* **`~/.gemini/config/MEMORY.md`**: Memori profil pengguna dan preferensi umum lintas proyek.
* **`~/.gemini/config/GEMINI.md`**: Aturan global untuk prioritas pencarian web dan pemuatan memori otomatis.
* **Skill `memory-bank`**: Skill bawaan untuk mengelola progres dan konteks tugas pada setiap proyek aktif.

---

## Struktur Memori

Sistem ini memisahkan konteks menjadi dua tingkat:

### 1. Tingkat Global (`~/.gemini/config/`)
* **`MEMORY.md`**: Menyimpan identitas, spesifikasi perangkat, akun, dan preferensi kerja.
* **`GEMINI.md`**: Mengatur perilaku asisten agar selalu memeriksa data terbaru di internet dan membaca memori sebelum merespons.

### 2. Tingkat Proyek (`.agents/context/`)
Dibuat di dalam direktori proyek kerja Anda:
* **`activeContext.md`**: Status fitur yang sedang dikerjakan saat ini, fokus tugas, dan langkah selanjutnya.
* **`progress.md`**: Daftar periksa (*checklist*) fitur yang telah selesai dan yang belum dikerjakan.
* **`systemPatterns.md`**: Standar arsitektur, pola kode, dan dependensi proyek.

---

## Cara Penggunaan

Setelah terpasang, Anda cukup memberikan instruksi kepada asisten seperti biasa:

* *"Inisialisasi memori untuk proyek ini"* — Menyiapkan folder konteks proyek.
* *"Simpan progres hari ini"* — Mencatat status pekerjaan dan langkah berikutnya.
* *"Lanjutkan tugas kemarin"* — Membaca kembali progres terakhir tanpa perlu mengulang penjelasan.
* *"Catat ini ke memori"* — Menyimpan preferensi atau informasi penting baru secara permanen.

---

## Lisensi

MIT License
