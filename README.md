# Validator Service 📖

Layanan ini menyediakan endpoint untuk melakukan validasi data kependudukan, seperti Nomor Induk Kependudukan (NIK) dan nama lengkap, serta untuk mengambil detail data penduduk.

## Base URL

`http://localhost:8082/api/validator`

---

### Endpoints

#### 1\. Validasi Keberadaan NIK

Memeriksa apakah NIK yang diberikan terdaftar dalam sistem.

- **URL**: `/validate/nik-exists`
- **Method**: `POST`
- **Header**:
  - `Content-Type`: `application/json`
- **Request Body**:

    ```json
    {
        "nik": "string"
    }
    ```

  - `nik` (string, **required**): Nomor Induk Kependudukan yang akan divalidasi.

- **Response**:
  - **Status Code**: `200 OK`
  - **Body**:

    ```json
    {
        "nikExists": true
    }
    ```

  - `nikExists` (boolean): `true` jika NIK ditemukan, `false` jika tidak.

    - **Contoh Response `200 OK` (NIK Ditemukan)**:

        ```json
        {
            "nikExists": true
        }
        ```

    - **Contoh Response `200 OK` (NIK Tidak Ditemukan)**:

        ```json
        {
            "nikExists": false
        }
        ```

- contoh testing API dengan cURL

    ```bash
    curl -X POST \
    http://localhost:8082/api/validator/validate/nik-exists \
    -H 'Content-Type: application/json' \
    -d '{
        "nik": "1234567890123456"
    }'
    ```

---

#### 2\. Validasi NIK dan Nama Lengkap

Memeriksa apakah kombinasi NIK dan nama lengkap sesuai dengan data yang terdaftar dalam sistem.

- **URL**: `/validate/nik-nama`
- **Method**: `POST`
- **Header**:
  - `Content-Type`: `application/json`
- **Request Body**:

```json
{
    "nik": "string",
    "namaLengkap": "string"
}
```

- `nik` (string, **required**): Nomor Induk Kependudukan.
- `namaLengkap` (string, **required**): Nama lengkap yang akan divalidasi bersama NIK.

- **Response**:
  - **Status Code**: `200 OK`
  - **Body**:

    ```json
    {
        "nikNamaMatches": true
    }
    ```

    - `nikNamaMatches` (boolean): `true` jika kombinasi NIK dan nama lengkap cocok, `false` jika tidak.
    - **Contoh Response `200 OK` (Cocok)**:

      ```json
      {
          "nikNamaMatches": true
      }
      ```

    - **Contoh Response `200 OK` (Tidak Cocok)**:

      ```json
      {
          "nikNamaMatches": false
      }
      ```

- contoh testing API dengan cURL

    ```bash
    curl -X POST \
    http://localhost:8082/api/validator/validate/nik-nama \
    -H 'Content-Type: application/json' \
    -d '{
        "nik": "1234567890123456",
        "namaLengkap": "Budi Santoso"
    }'
    ```

---

#### 3\. Mendapatkan Detail Penduduk Berdasarkan NIK

Mengambil seluruh detail data penduduk berdasarkan NIK.

- **URL**: `/get-details/{nik}`
- **Method**: `GET`
- **Path Parameters**:
  - `nik` (string, **required**): Nomor Induk Kependudukan dari penduduk yang detailnya ingin diambil.
- **Response**:
  - **Status Code**: `200 OK`
  - **Body**: (Objek `Penduduk`)

    ```json
    {
        "nik": "string",
        "namaLengkap": "string",
        "tempatLahir": "string",
        "tanggalLahir": "YYYY-MM-DD",
        "jenisKelamin": "string",
        "alamat": "string",
        "rtRw": "string",
        "kelDesa": "string",
        "kecamatan": "string",
        "agama": "string",
        "statusPerkawinan": "string",
        "pekerjaan": "string",
        "kewarganegaraan": "string",
        "berlakuHingga": "YYYY-MM-DD"
    }
    ```

  - **Contoh Response `200 OK`**:

    ```json
    {
        "nik": "1234567890123456",
        "namaLengkap": "Budi Santoso",
        "tempatLahir": "Jakarta",
        "tanggalLahir": "1990-05-15",
        "jenisKelamin": "Laki-laki",
        "alamat": "Jl. Merdeka No. 10",
        "rtRw": "001/001",
        "kelDesa": "Kebon Kacang",
        "kecamatan": "Tanah Abang",
        "agama": "Islam",
        "statusPerkawinan": "Menikah",
        "pekerjaan": "Swasta",
        "kewarganegaraan": "WNI",
        "berlakuHingga": "2030-12-31"
    }
    ```

  - **Status Code**: `404 Not Found`
  - **Description**: Jika NIK yang diminta tidak ditemukan dalam sistem.
  - **Contoh Response `404 Not Found`**: (Biasanya tidak ada body)

- contoh testing API dengan cURL

    ```bash
    curl -X GET \
        http://localhost:8082/api/validator/get-details/1234567890123456
    ```
