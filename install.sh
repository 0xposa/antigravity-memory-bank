#!/usr/bin/env bash
set -e

echo "=========================================="
echo " 🧠 Antigravity Memory Bank Installer"
echo "=========================================="

CONFIG_DIR="${HOME}/.gemini/config"
SKILL_DIR="${CONFIG_DIR}/skills/memory-bank"
TEMPLATES_DIR="${SKILL_DIR}/resources/templates"
SCRIPTS_DIR="${SKILL_DIR}/scripts"

echo "[1/5] Membuat struktur direktori..."
mkdir -p "${CONFIG_DIR}"
mkdir -p "${TEMPLATES_DIR}"
mkdir -p "${SCRIPTS_DIR}"

echo "[2/5] Menyiapkan template memori proyek..."
cat << 'EOF' > "${TEMPLATES_DIR}/activeContext.md"
# Active Context

## Status Saat Ini
- **Fokus Terakhir**: [Fitur / Modul yang baru saja dikerjakan]
- **Status**: [Selesai / Sedang berlangsung / Terkendala]

## Perubahan Terakhir
- [Ringkasan perubahan kode / file yang baru dibuat]

## Langkah Berikutnya (Next Steps)
- [ ] [Tugas berikutnya yang harus dilanjutkan]
- [ ] [Pengujian / Verifikasi]

## Catatan / Kendala
- [Catatan penting atau bug yang masih harus diperhatikan]
EOF

cat << 'EOF' > "${TEMPLATES_DIR}/progress.md"
# Project Progress

## Fitur & Tugas Utama
- [ ] Inisialisasi arsitektur proyek
- [ ] Fitur A: [Nama Fitur]
- [ ] Fitur B: [Nama Fitur]
- [ ] Pengujian & QA
- [ ] Dokumentasi & Deployment

## Riwayat Selesai
- [x] Inisialisasi memory bank proyek
EOF

cat << 'EOF' > "${TEMPLATES_DIR}/systemPatterns.md"
# System Patterns & Architecture

## Arsitektur & Teknologi
- **Bahasa / Runtime**: [misal Node.js / Python / Go]
- **Framework**: [misal Next.js / FastAPI / Express]
- **Database**: [misal PostgreSQL / SQLite / MongoDB]

## Standar Kode & Struktur Folder
- `src/`: Berisi kode sumber utama aplikasi
- `tests/`: Pengujian unit dan integrasi

## Keputusan Arsitektur Kunci (Key Decisions)
- [Keputusan 1]: [Alasan pemilihan teknologi / pola desain]
EOF

echo "[3/5] Menyiapkan skill 'memory-bank'..."
cat << 'EOF' > "${SKILL_DIR}/SKILL.md"
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
EOF

cat << 'EOF' > "${SCRIPTS_DIR}/init_memory_bank.sh"
#!/usr/bin/env bash
set -e

TARGET_DIR="${1:-.}"
CONTEXT_DIR="$TARGET_DIR/.agents/context"
TEMPLATES_DIR="$(dirname "$0")/../resources/templates"

mkdir -p "$CONTEXT_DIR"

if [ ! -f "$CONTEXT_DIR/activeContext.md" ]; then
    cp "$TEMPLATES_DIR/activeContext.md" "$CONTEXT_DIR/activeContext.md"
    echo "✓ Created $CONTEXT_DIR/activeContext.md"
fi

if [ ! -f "$CONTEXT_DIR/progress.md" ]; then
    cp "$TEMPLATES_DIR/progress.md" "$CONTEXT_DIR/progress.md"
    echo "✓ Created $CONTEXT_DIR/progress.md"
fi

if [ ! -f "$CONTEXT_DIR/systemPatterns.md" ]; then
    cp "$TEMPLATES_DIR/systemPatterns.md" "$CONTEXT_DIR/systemPatterns.md"
    echo "✓ Created $CONTEXT_DIR/systemPatterns.md"
fi

echo "Memory bank successfully initialized in $CONTEXT_DIR"
EOF
chmod +x "${SCRIPTS_DIR}/init_memory_bank.sh"

echo "[4/5] Menyiapkan MEMORY.md global..."
if [ ! -f "${CONFIG_DIR}/MEMORY.md" ]; then
    cat << 'EOF' > "${CONFIG_DIR}/MEMORY.md"
# Persistent Memory & Context

Dokumen ini adalah memori permanen asisten AI untuk mengingat preferensi, profil perangkat, dan konteks percakapan di setiap sesi baru.

---

## 1. Profil Pengguna & Komunikasi
* **Gaya Bahasa**: Santai, to the point, dan praktis.
* **Akun GitHub**: 0xposa

---

## 2. Lingkungan Perangkat & Sistem
* **Perangkat**: Komputer / Laptop Utama

---

## 3. Kebijakan & Preferensi Kerja AI
* **Prioritas Live Web Search**: Selalu gunakan search_web terlebih dahulu jika membahas nama produk, tool, framework, atau fitur baru.
* **Auto-Update**: Perbarui dokumen ini setiap kali ada konteks atau preferensi baru yang penting.
EOF
    echo "✓ Dibuat: ${CONFIG_DIR}/MEMORY.md"
else
    echo "✓ Berkas sudah ada: ${CONFIG_DIR}/MEMORY.md (tidak ditimpa)"
fi

echo "[5/5] Menyiapkan aturan global GEMINI.md..."
if [ ! -f "${CONFIG_DIR}/GEMINI.md" ]; then
    cat << 'EOF' > "${CONFIG_DIR}/GEMINI.md"
# Global AI Assistant Rules

## Persistent User & Environment Memory
- **Memory File**: Buka dan patuhi memori pengguna di `~/.gemini/config/MEMORY.md`.
- **Auto-Update**: Jika pengguna memberikan preferensi atau konteks penting baru, perbarui file memory ini secara otomatis.

## Internet & Information Freshness Policy
- **Prioritize Live Web Search**: Selalu gunakan tool `search_web` terlebih dahulu ketika pengguna menyebutkan nama produk, teknologi, tool, framework, library, bot, atau istilah teknis yang berpotensi memiliki perkembangan baru atau informasi terkini.
- **Jangan Berasumsi dari Training Data Saja**: Hindari menyimpulkan atau berasumsi hanya berdasarkan memori internal jika suatu istilah/fitur mungkin telah berkembang atau memiliki produk baru dengan nama serupa.
- **Proaktif Mencari Informasi**: Jika konteks suatu istilah terasa ambigu atau belum jelas, lakukan pencarian web secara proaktif terlebih dahulu sebelum bertanya balik kepada pengguna.
EOF
    echo "✓ Dibuat: ${CONFIG_DIR}/GEMINI.md"
else
    if ! grep -q "MEMORY.md" "${CONFIG_DIR}/GEMINI.md"; then
        cat << 'EOF' >> "${CONFIG_DIR}/GEMINI.md"

## Persistent User & Environment Memory
- **Memory File**: Buka dan patuhi memori pengguna di `~/.gemini/config/MEMORY.md`.
- **Auto-Update**: Jika pengguna memberikan preferensi atau konteks penting baru, perbarui file memory ini secara otomatis.
EOF
        echo "✓ Ditambahkan aturan memori ke ${CONFIG_DIR}/GEMINI.md"
    else
        echo "✓ Aturan memori sudah aktif di ${CONFIG_DIR}/GEMINI.md"
    fi
fi

echo ""
echo "=========================================="
echo " 🎉 Sukses! Memory Bank berhasil dipasang."
echo " Skill 'memory-bank' sudah aktif di Antigravity!"
echo "=========================================="
