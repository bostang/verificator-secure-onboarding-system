package com.validator.demo.model;

import jakarta.persistence.*; // Gunakan jakarta.persistence untuk Spring Boot 3+
import lombok.Data; // Dari Lombok, untuk mengurangi boilerplate
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "penduduk") // Nama tabel di database
@Data // Lombok: Otomatis membuat getters, setters, toString, equals, hashCode
@NoArgsConstructor // Lombok: Konstruktor tanpa argumen
@AllArgsConstructor // Lombok: Konstruktor dengan semua argumen
public class Penduduk {

    @Id
    @Column(name = "nik", unique = true, nullable = false, length = 16) // NIK sebagai PK, unik, tidak boleh null
    private String nik;

    @Column(name = "nama_lengkap", nullable = false)
    private String namaLengkap; // nama_lengkap

    @Column(name = "tempat_lahir")
    private String tempatLahir;

    @Column(name = "tanggal_lahir")
    private LocalDate tanggalLahir; // Gunakan LocalDate untuk tanggal

    @Column(name = "jenis_kelamin")
    private String jenisKelamin;

    @Column(name = "nama_alamat")
    private String namaAlamat; // nama_alamat (misal: nama jalan, nomor rumah)

    @Column(name = "kecamatan")
    private String kecamatan;

    @Column(name = "kelurahan")
    private String kelurahan;

    @Column(name = "agama")
    private String agama;

    @Column(name = "status_perkawinan")
    private String statusPerkawinan;

    @Column(name = "kewarganegaraan")
    private String kewarganegaraan;

    @Column(name = "berlaku_hingga")
    private LocalDate berlakuHingga;
}