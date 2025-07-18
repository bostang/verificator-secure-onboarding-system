#!/bin/bash

# --- 2. Menjalankan skrip SQL ---
# Pastikan PostgreSQL client (psql) sudah terinstall dan berjalan.
# Ganti 'your_db_user' jika username database kamu bukan 'postgres'
# Ganti 'your_db_password' jika password database kamu bukan 'password'
# Penting: Pastikan database 'customer_registration' sudah ada atau buat secara manual
# sebelum menjalankan skrip ini, atau tambahkan langkah pembuatan database di sini.

echo "Menjalankan skrip SQL: database_setup_FIXED.sql"
# Menggunakan PGPASSWORD untuk menghindari prompt password
PGPASSWORD=password psql -h localhost -U postgres -d customer_registration -f ./sql/database_fix.sql

if [ $? -eq 0 ]; then
    echo "database_fix.sql berhasil dijalankan."
else
    echo "Gagal menjalankan database_fix.sql. Pastikan PostgreSQL berjalan dan kredensial benar."
    exit 1
fi

# --- 3. Menjalankan aplikasi Spring Boot ---
echo "Menjalankan aplikasi Spring Boot dengan ./mvnw spring-boot:run"
# Penting: Pastikan kamu berada di direktori root proyekmu saat menjalankan skrip ini
./mvnw spring-boot:run

# Tambahan: Untuk menjalankan Spring Boot di background, kamu bisa gunakan `nohup` dan `&`:
# nohup ./mvnw spring-boot:run > app.log 2>&1 &
# echo "Aplikasi Spring Boot sedang berjalan di background. Lihat app.log untuk output."
# Jika kamu menjalankan di background, kamu perlu cara lain untuk mematikan aplikasi,
# misalnya dengan mencari PID dan membunuhnya: kill $(lsof -t -i:8083)
