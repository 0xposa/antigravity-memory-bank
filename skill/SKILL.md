---
name: memory-bank
description: >-
  Manages persistent project memory, session continuity, and active context.
  Use this skill when resuming work from a previous session, initializing project memory,
  updating task progress, or saving context before finishing work.
---

# Persistent Memory Bank Skill

Skill ini memungkinkan agen AI mempertahankan konteks kerja, riwayat keputusan, dan daftar tugas (to-do list) di seluruh sesi, baik di level proyek maupun di level pengguna global.

---

## 1. Arsitektur Memori

Sistem memori terbagi menjadi 2 lapisan:

### A. Memori Global Pengguna (`~/.gemini/config/MEMORY.md`)
* Berisi data identitas pengguna, profil perangkat, akun GitHub, dan preferensi umum.
* Bersifat lintas proyek dan otomatis dimuat di semua folder.

### B. Memori Konteks Proyek (`.agents/context/`)
* Diletakkan di dalam setiap folder proyek aktif:
  * `activeContext.md`: Apa yang sedang dikerjakan sekarang, kendala aktif, dan langkah selanjutnya (*next steps*).
  * `progress.md`: Daftar fitur yang sudah selesai `[x]` vs belum `[ ]`.
  * `systemPatterns.md`: Standar arsitektur, pola kode, dan dependensi proyek.

---

## 2. Prosedur Kerja Agen

### Saat Memulai atau Melanjutkan Proyek (Resume Session)
1. Periksa apakah folder `.agents/context/` ada di dalam proyek.
2. Jika ada, baca file `activeContext.md` dan `progress.md`.
3. Sapa pengguna dengan merangkum status terakhir secara singkat:
   > *"Terakhir kita selesai mengerjakan [Fitur A], dan langkah berikutnya adalah [Fitur B]. Mau kita lanjutkan sekarang?"*

### Saat Memulai Proyek Baru (Inisialisasi)
1. Jalankan skrip pembantu untuk membuat template memori:
   `bash ~/.gemini/config/skills/memory-bank/scripts/init_memory_bank.sh`
2. Isi informasi awal proyek di `.agents/context/progress.md` dan `systemPatterns.md`.

### Saat Menyelesaikan Tugas atau Menyimpan Progres
1. Perbarui checklist di `.agents/context/progress.md` (ubah `[ ]` menjadi `[x]`).
2. Tuliskan ringkasan status di `activeContext.md`:
   * **Perubahan Terakhir**: Apa yang baru saja dibuat atau diubah.
   * **Langkah Berikutnya**: Apa yang harus dikerjakan di sesi selanjutnya.
   * **Catatan/Kendala**: Jika ada bug atau dependensi yang belum selesai.
