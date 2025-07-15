package com.validator.demo.repository;

// src/main/java/com/example/nikvalidator/repository/PendudukRepository.java

import com.validator.demo.model.Penduduk;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PendudukRepository extends JpaRepository<Penduduk, String> {
    // Spring Data JPA akan otomatis membuat implementasi untuk method ini
    Optional<Penduduk> findByNik(String nik);

    // Kita juga bisa menambahkan method untuk mencari NIK dan nama_lengkap
    Optional<Penduduk> findByNikAndNamaLengkap(String nik, String namaLengkap);
}