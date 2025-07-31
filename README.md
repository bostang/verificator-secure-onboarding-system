# 🏛️ Dukcapil KTP Verification Service

Layanan microservice untuk verifikasi data KTP Dukcapil yang digunakan oleh Customer Registration Service.

## Cara Deploy ke CloudRun

1. build & push ke GCR
2. buat deployment cloudrun
3. buat bucket

### Cara push ke GCR

```bash
# build docker image
docker build -t asia.gcr.io/primeval-rune-467212-t9/verificator-secure-onboarding-system .
docker push asia.gcr.io/primeval-rune-467212-t9/verificator-secure-onboarding-system:latest

# login ke gcloud
gcloud auth login

# autentikasi docker
gcloud auth configure-docker


gcloud auth list

gcloud config get-value project

# aktifkan API artifact registry
gcloud services enable artifactregistry.googleapis.com

# CATATAN : APABILA PUSH GAGAL, LAKUKAN MELALUI CLOUD SHELL TERMINAL DI GOOGLE CLOUD
```

## `.env`

```conf
# Password untuk koneksi ke database PostgreSQL
SPRING_DATASOURCE_PASSWORD="..."

# Konfigurasi untuk koneksi ke Cloud SQL
PROJECT_ID="..."
REGION="..."
INSTANCE_NAME="..."
DATABASE_NAME="..."
```

## Mulai Cepat

```bash
# pastikan anda sudah memiliki postgresql dan juga java dengan versi 21 terinstall.

# jika belum punya:
  # sudo apt install postgresql
  # sudo apt install openjdk-21-jdk

# jalankan script :
./setup.sh
```

Contoh untuk testing :

```bash
curl -X POST \
  https://verificator-secure-onboarding-system-wlxypujzrq-as.a.run.app/api/dukcapil/verify-nik \
  -H 'Content-Type: application/json' \
  -d '{
    "nik": "3175031234567890",
    "namaLengkap": "John Doe",
    "tanggalLahir": "1990-05-15"
  }'
```

| **NIK**          | **Nama Lengkap** | **Tanggal Lahir** |
| :--------------- | :--------------- | :---------------- |
| 3175031234567890 | John Doe         | 1990-05-15        |
| 3175032345678901 | Jane Smith       | 1995-08-22        |
| 3175033456789012 | Ahmad Rahman     | 1985-12-10        |
| 3175034567890123 | Siti Nurhaliza   | 1992-03-18        |
| 3175035678901234 | Budi Santoso     | 1988-11-25        |
| 1234567890123456 | Test User One    | 1995-01-01        |
| 1234567890123457 | Test User Two    | 1992-02-02        |
| 3175036789012345 | Dewi Lestari     | 1993-01-01        |
| 3175037890123456 | Fajar Ramadhan   | 1989-07-07        |
| 3175038901234567 | Citra Kirana     | 1991-04-12        |
| 3175039012345678 | Gatot Subroto    | 1978-09-20        |
| 3175030123456789 | Hana Putri       | 1998-02-28        |
| 3175031122334455 | Irfan Hakim      | 1980-06-03        |
| 3175032233445566 | Kartika Sari     | 1996-10-10        |
| 3175033344556677 | Lukman Sardi     | 1975-03-01        |
| 3175034455667788 | Maria Ulfa       | 1994-07-19        |
| 3175035566778899 | Noval Syahputra  | 1987-01-30        |
| 3175036677889900 | Putri Ayu        | 1999-04-05        |
| 3175037788990011 | Rizky Pratama    | 1982-08-14        |
| 3175038899001122 | Sarah Wijayanto  | 1990-11-29        |
| 3175039900112233 | Taufik Hidayat   | 1981-02-17        |
| 3175030011223344 | Umi Kulsum       | 1997-06-08        |
| 3175031020304050 | Vicky Prasetyo   | 1983-09-23        |
| 3175032030405060 | Wulan Guritno    | 1992-12-04        |
| 3175033040506070 | Xavier Putra     | 1986-03-11        |
| 3175034050607080 | Yuni Shara       | 1991-05-27        |
| 3175035060708090 | Zaki Anwar       | 1984-07-09        |
| 3175036070809010 | Aisha Rahma      | 1996-09-16        |
| 3175037080901020 | Bayu Dirgantara  | 1985-11-21        |
| 3175038090102030 | Cinta Laura      | 1993-02-01        |

```

## 📋 Daftar Isi

- [Overview](#overview)
- [Fitur](#fitur)
- [Tech Stack](#tech-stack)
- [Setup](#setup)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)
- [Docker](#docker)
- [Monitoring](#monitoring)

## 🎯 Overview

Dukcapil Service adalah microservice yang mengelola verifikasi data KTP (Kartu Tanda Penduduk) dari database Dukcapil. Service ini menyediakan API untuk:

- ✅ Verifikasi NIK dan nama lengkap
- 🔍 Pengecekan keberadaan NIK
- 📊 Statistik data KTP
- 🔎 Pencarian data berdasarkan nama

## ✨ Fitur

### Core Features

- **NIK Verification**: Verifikasi NIK dengan nama lengkap
- **Case-Insensitive Search**: Pencarian tidak sensitif terhadap huruf besar/kecil
- **Data Validation**: Validasi format NIK 16 digit
- **Performance Optimized**: Database indexing untuk query cepat
- **Error Handling**: Comprehensive error responses

### Security Features

- **CORS Protection**: Configured CORS untuk Customer Service
- **Input Validation**: Strict validation dengan Bean Validation
- **SQL Injection Protection**: Parameterized queries
- **Security Headers**: Security headers pada response

### Monitoring Features

- **Health Check**: Endpoint untuk monitoring
- **Statistics**: Real-time statistics data KTP
- **Performance Metrics**: Response time tracking
- **Audit Logging**: Request/response logging

## 🛠️ Tech Stack

- **Java 21** - Programming language
- **Spring Boot 3.2** - Framework
- **Spring Data JPA** - Data access
- **PostgreSQL 15** - Database
- **Maven** - Build tool
- **Docker** - Containerization

## 🚀 Setup

### Prerequisites

- Java 21
- Maven 3.9+
- PostgreSQL 15+
- Git

### 1. Clone Repository

```bash
git clone <repository-url>
cd dukcapil-service
```

### 2. Database Setup

```bash
# Create database
psql -U postgres -c "CREATE DATABASE dukcapil_ktp;"

# Run setup script
psql -U postgres -d dukcapil_ktp -f create_dukcapil_database.sql
```

### 3. Configuration

```bash
# Copy example config
cp src/main/resources/application.properties.example src/main/resources/application.properties

# Edit database configuration
vim src/main/resources/application.properties
```

### 4. Build & Run

```bash
# Build project
mvn clean compile

# Run application
mvn spring-boot:run

# Or run with specific profile
mvn spring-boot:run -Dspring-boot.run.profiles=development
```

### 5. Verify Installation

```bash
# Health check
curl http://localhost:8081/api/dukcapil/health

# Test verification
curl -X POST http://localhost:8081/api/dukcapil/verify-nik \
  -H "Content-Type: application/json" \
  -d '{"nik": "3175031234567890", "namaLengkap": "John Doe"}'
```

## 📡 API Endpoints

### Health & Info

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/dukcapil/health` | Service health check |
| GET | `/api/dukcapil/ping` | Simple ping test |
| GET | `/api/dukcapil/docs` | API documentation |
| GET | `/api/dukcapil/stats` | Service statistics |

### Core Verification

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/dukcapil/verify-nik` | Verify NIK + name |
| POST | `/api/dukcapil/check-nik` | Check NIK existence |
| GET | `/api/dukcapil/ktp-data/{nik}` | Get KTP data by NIK |

### Search & Analytics

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/dukcapil/search-name?name={name}` | Search by name |
| GET | `/api/dukcapil/stats/comprehensive` | Detailed statistics |

### Request/Response Examples

#### Verify NIK

```bash
# Request
POST /api/dukcapil/verify-nik
{
  "nik": "3175031234567890",
  "namaLengkap": "John Doe"
}

# Response - Success
{
  "valid": true,
  "message": "Data NIK dan nama valid sesuai database Dukcapil",
  "data": {
    "nik": "3175031234567890",
    "namaLengkap": "John Doe",
    "tempatLahir": "Jakarta",
    "tanggalLahir": "1990-05-15",
    "jenisKelamin": "Laki-laki",
    "agama": "Islam",
    "alamat": "Jl. Sudirman No. 123, RT 001/RW 002",
    "kecamatan": "Tanah Abang",
    "kelurahan": "Bendungan Hilir"
  },
  "timestamp": "2024-01-15T10:30:00Z",
  "service": "Dukcapil Service"
}
```

#### Check NIK

```bash
# Request
POST /api/dukcapil/check-nik
{
  "nik": "3175031234567890"
}

# Response
{
  "exists": true,
  "nik": "3175031234567890",
  "message": "NIK terdaftar di database Dukcapil",
  "service": "Dukcapil Service",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

## 🧪 Testing

### Automated Testing

```bash
# Run unit tests
mvn test

# Run integration tests
mvn verify

# Run with coverage
mvn clean test jacoco:report
```

### Manual Testing

```bash
# Run comprehensive test script
chmod +x test_dukcapil_service.sh
./test_dukcapil_service.sh

# Test specific endpoint
curl -X POST http://localhost:8081/api/dukcapil/verify-nik \
  -H "Content-Type: application/json" \
  -d '{"nik": "3175031234567890", "namaLengkap": "John Doe"}'
```

### Test Data

Valid NIKs for testing:

- `3175031234567890` - John Doe
- `3175032345678901` - Jane Smith
- `3175033456789012` - Ahmad Rahman
- `1234567890123456` - Test User One
- `1234567890123457` - Test User Two

## 🐳 Docker
