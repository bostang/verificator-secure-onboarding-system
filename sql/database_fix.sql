-- ===== FIX DATABASE SCHEMA ISSUES =====
-- File: database_fix.sql
-- Run: psql -U postgres -d dukcapil_ktp -f sql/database_fix.sql

DROP DATABASE IF EXISTS dukcapil_ktp;
CREATE DATABASE dukcapil_ktp WITH OWNER postgres;

\connect dukcapil_ktp;

-- 1. Drop problematic view first
DROP VIEW IF EXISTS ktp_summary CASCADE;

-- 2. Drop existing table to recreate fresh
DROP TABLE IF EXISTS ktp_dukcapil CASCADE;

-- 3. Create table with correct column types
CREATE TABLE ktp_dukcapil (
    id BIGSERIAL PRIMARY KEY,
    nik VARCHAR(20) NOT NULL UNIQUE,
    nama_lengkap VARCHAR(100) NOT NULL,
    tempat_lahir VARCHAR(50) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    jenis_kelamin VARCHAR(255) NOT NULL CHECK (jenis_kelamin IN ('LAKI_LAKI', 'PEREMPUAN')),
    nama_alamat TEXT NOT NULL,
    kecamatan VARCHAR(50) NOT NULL,
    kelurahan VARCHAR(50) NOT NULL,
    agama VARCHAR(255) NOT NULL CHECK (agama IN ('ISLAM', 'KRISTEN', 'BUDDHA', 'HINDU', 'KONGHUCU', 'LAINNYA')),
    status_perkawinan VARCHAR(20) NOT NULL,
    kewarganegaraan VARCHAR(20) DEFAULT 'WNI' NOT NULL,
    berlaku_hingga VARCHAR(20) DEFAULT 'SEUMUR HIDUP' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create indexes
CREATE INDEX idx_ktp_nik ON ktp_dukcapil(nik);
CREATE INDEX idx_ktp_nama ON ktp_dukcapil(LOWER(nama_lengkap));
CREATE INDEX idx_ktp_nik_nama ON ktp_dukcapil(nik, LOWER(nama_lengkap));

-- 5. Create trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER trigger_ktp_updated_at
    BEFORE UPDATE ON ktp_dukcapil
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 6. Insert sample data
INSERT INTO ktp_dukcapil (
    nik, nama_lengkap, tempat_lahir, tanggal_lahir, jenis_kelamin,
    nama_alamat, kecamatan, kelurahan, agama, status_perkawinan
) VALUES 
('3175031234567890', 'John Doe', 'Jakarta', '1990-05-15', 'LAKI_LAKI',
 'Jl. Sudirman No. 123, RT 001/RW 002', 'Tanah Abang', 'Bendungan Hilir', 'ISLAM', 'BELUM KAWIN'),

('3175032345678901', 'Jane Smith', 'Jakarta', '1995-08-22', 'PEREMPUAN', 
 'Jl. Gatot Subroto No. 456, RT 003/RW 004', 'Setiabudi', 'Kuningan Timur', 'KRISTEN', 'KAWIN'),

('3175033456789012', 'Ahmad Rahman', 'Bogor', '1985-12-10', 'LAKI_LAKI',
 'Jl. Thamrin No. 789, RT 005/RW 006', 'Menteng', 'Gondangdia', 'ISLAM', 'KAWIN'),

('3175034567890123', 'Siti Nurhaliza', 'Depok', '1992-03-18', 'PEREMPUAN',
 'Jl. HR Rasuna Said No. 321, RT 007/RW 008', 'Setiabudi', 'Setiabudi', 'ISLAM', 'BELUM KAWIN'),

('3175035678901234', 'Budi Santoso', 'Jakarta', '1988-11-25', 'LAKI_LAKI',
 'Jl. Kemang Raya No. 654, RT 009/RW 010', 'Mampang Prapatan', 'Kemang', 'BUDDHA', 'KAWIN'),

('1234567890123456', 'Test User One', 'Jakarta', '1995-01-01', 'LAKI_LAKI',
 'Jl. Test No. 123', 'Test Kecamatan', 'Test Kelurahan', 'ISLAM', 'BELUM KAWIN'),

('1234567890123457', 'Test User Two', 'Bandung', '1992-02-02', 'PEREMPUAN',
 'Jl. Test No. 456', 'Test Kecamatan', 'Test Kelurahan', 'KRISTEN', 'KAWIN');

-- insert additional sample data
-- Tambahan 23 data sampel untuk mencapai total 30 data

INSERT INTO ktp_dukcapil (
    nik, nama_lengkap, tempat_lahir, tanggal_lahir, jenis_kelamin,
    nama_alamat, kecamatan, kelurahan, agama, status_perkawinan
) VALUES
('3175036789012345', 'Dewi Lestari', 'Surabaya', '1993-01-01', 'PEREMPUAN',
 'Jl. Kebon Jeruk No. 1, RT 011/RW 012', 'Kebon Jeruk', 'Kedoya Selatan', 'ISLAM', 'BELUM KAWIN'),

('3175037890123456', 'Fajar Ramadhan', 'Medan', '1989-07-07', 'LAKI_LAKI',
 'Jl. Raya Bogor No. 234, RT 013/RW 014', 'Ciracas', 'Rambutan', 'ISLAM', 'KAWIN'),

('3175038901234567', 'Citra Kirana', 'Bandung', '1991-04-12', 'PEREMPUAN',
 'Jl. Bintaro Raya No. 567, RT 015/RW 016', 'Pesanggrahan', 'Bintaro', 'KRISTEN', 'KAWIN'),

('3175039012345678', 'Gatot Subroto', 'Palembang', '1978-09-20', 'LAKI_LAKI',
 'Jl. Fatmawati No. 890, RT 017/RW 018', 'Cilandak', 'Gandaria Selatan', 'ISLAM', 'KAWIN'),

('3175030123456789', 'Hana Putri', 'Makassar', '1998-02-28', 'PEREMPUAN',
 'Jl. Pondok Indah No. 111, RT 019/RW 020', 'Kebayoran Lama', 'Pondok Pinang', 'ISLAM', 'BELUM KAWIN'),

('3175031122334455', 'Irfan Hakim', 'Semarang', '1980-06-03', 'LAKI_LAKI',
 'Jl. Pahlawan Revolusi No. 222, RT 021/RW 022', 'Duren Sawit', 'Pondok Bambu', 'ISLAM', 'KAWIN'),

('3175032233445566', 'Kartika Sari', 'Yogyakarta', '1996-10-10', 'PEREMPUAN',
 'Jl. Jatinegara Timur No. 333, RT 023/RW 024', 'Jatinegara', 'Cipinang Cempedak', 'HINDU', 'BELUM KAWIN'),

('3175033344556677', 'Lukman Sardi', 'Jakarta', '1975-03-01', 'LAKI_LAKI',
 'Jl. Dewi Sartika No. 444, RT 025/RW 026', 'Kramat Jati', 'Cililitan', 'ISLAM', 'KAWIN'),

('3175034455667788', 'Maria Ulfa', 'Solo', '1994-07-19', 'PEREMPUAN',
 'Jl. Raya Condet No. 555, RT 027/RW 028', 'Kramat Jati', 'Batu Ampar', 'KRISTEN', 'BELUM KAWIN'),

('3175035566778899', 'Noval Syahputra', 'Bandung', '1987-01-30', 'LAKI_LAKI',
 'Jl. Kalimalang No. 666, RT 029/RW 030', 'Duren Sawit', 'Cipinang Melayu', 'ISLAM', 'KAWIN'),

('3175036677889900', 'Putri Ayu', 'Denpasar', '1999-04-05', 'PEREMPUAN',
 'Jl. Raya Kalibata No. 777, RT 031/RW 032', 'Pancoran', 'Kalibata', 'HINDU', 'BELUM KAWIN'),

('3175037788990011', 'Rizky Pratama', 'Jakarta', '1982-08-14', 'LAKI_LAKI',
 'Jl. Raya Pasar Minggu No. 888, RT 033/RW 034', 'Pasar Minggu', 'Jati Padang', 'ISLAM', 'KAWIN'),

('3175038899001122', 'Sarah Wijayanto', 'Bogor', '1990-11-29', 'PEREMPUAN',
 'Jl. Lebak Bulus Raya No. 999, RT 035/RW 036', 'Cilandak', 'Lebak Bulus', 'BUDDHA', 'KAWIN'),

('3175039900112233', 'Taufik Hidayat', 'Surabaya', '1981-02-17', 'LAKI_LAKI',
 'Jl. Pondok Labu No. 101, RT 037/RW 038', 'Cilandak', 'Pondok Labu', 'ISLAM', 'KAWIN'),

('3175030011223344', 'Umi Kulsum', 'Malang', '1997-06-08', 'PEREMPUAN',
 'Jl. Cirendeu Raya No. 202, RT 039/RW 040', 'Ciputat Timur', 'Cirendeu', 'ISLAM', 'BELUM KAWIN'),

('3175031020304050', 'Vicky Prasetyo', 'Jakarta', '1983-09-23', 'LAKI_LAKI',
 'Jl. Raya Ciputat No. 303, RT 041/RW 042', 'Ciputat', 'Pisangan', 'ISLAM', 'KAWIN'),

('3175032030405060', 'Wulan Guritno', 'Bandung', '1992-12-04', 'PEREMPUAN',
 'Jl. Veteran No. 404, RT 043/RW 044', 'Tanah Abang', 'Kebon Kacang', 'KRISTEN', 'KAWIN'),

('3175033040506070', 'Xavier Putra', 'Padang', '1986-03-11', 'LAKI_LAKI',
 'Jl. Kebon Sirih No. 505, RT 045/RW 046', 'Menteng', 'Kebon Sirih', 'ISLAM', 'BELUM KAWIN'),

('3175034050607080', 'Yuni Shara', 'Jakarta', '1991-05-27', 'PEREMPUAN',
 'Jl. Teuku Umar No. 606, RT 047/RW 048', 'Menteng', 'Gondangdia', 'ISLAM', 'KAWIN'),

('3175035060708090', 'Zaki Anwar', 'Bogor', '1984-07-09', 'LAKI_LAKI',
 'Jl. Diponegoro No. 707, RT 049/RW 050', 'Menteng', 'Menteng', 'ISLAM', 'KAWIN'),

('3175036070809010', 'Aisha Rahma', 'Surabaya', '1996-09-16', 'PEREMPUAN',
 'Jl. Imam Bonjol No. 808, RT 051/RW 052', 'Menteng', 'Cikini', 'ISLAM', 'BELUM KAWIN'),

('3175037080901020', 'Bayu Dirgantara', 'Medan', '1985-11-21', 'LAKI_LAKI',
 'Jl. Gondangdia Lama No. 909, RT 053/RW 054', 'Menteng', 'Cikini', 'BUDDHA', 'KAWIN'),

('3175038090102030', 'Cinta Laura', 'Jakarta', '1993-02-01', 'PEREMPUAN',
 'Jl. Kramat Raya No. 101, RT 055/RW 056', 'Senen', 'Kramat', 'KRISTEN', 'BELUM KAWIN');


-- 7. Verify data
SELECT 'Database fixed successfully!' as status;
SELECT COUNT(*) as total_records FROM ktp_dukcapil;
SELECT nik, nama_lengkap, jenis_kelamin, agama FROM ktp_dukcapil LIMIT 5;