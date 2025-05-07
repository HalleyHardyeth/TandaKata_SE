**Workflow

**Pull dari Branch main Terlebih Dahulu
Sebelum push, pastikan kamu sync dengan branch main terbaru:
git pull origin main

**Buat Branch Baru
git checkout -b nama-fitur

**Lakukan Perubahan & Commit
git add .
git commit -m "Deskripsi singkat tentang perubahan yang kamu buat"

**Push ke GitHub
git push origin nama-fitur

**Buat Pull Request (PR)
- Masuk ke GitHub repo
- Akan muncul tombol “Compare & pull request”
- Beri deskripsi singkat
- Pilih reviewers
- Tunggu approval dari anggota tim lain sebelum di-merge ke main

**Tips Commit Message
Gunakan bahasa yang jelas dan ringkas
Contoh:
- Menambahkan fitur pencarian
- Fix bug input kutipan
- Update tampilan home page

**Penting 
- Setiap fitur harus dibuat di branch terpisah, bukan langsung di main.
- Jangan push langsung ke branch main.
- Selalu gunakan pull request.
