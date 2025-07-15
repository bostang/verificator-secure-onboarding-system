package com.validator.demo.service;

import java.util.Optional;

import com.validator.demo.model.Penduduk;

public interface PendudukService {
    Optional<Penduduk> getPendudukByNik(String nik);
    boolean validateNikExists(String nik);
    boolean validateNikAndNamaLengkap(String nik, String namaLengkap);
    Penduduk savePenduduk(Penduduk penduduk); // Untuk menambahkan data dummy
}
