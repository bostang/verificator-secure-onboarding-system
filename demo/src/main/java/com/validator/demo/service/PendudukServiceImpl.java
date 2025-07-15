package com.validator.demo.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.validator.demo.model.Penduduk;
import com.validator.demo.repository.PendudukRepository;

@Service
public class PendudukServiceImpl implements PendudukService {

    @Autowired
    private PendudukRepository pendudukRepository;

    @Override
    public Optional<Penduduk> getPendudukByNik(String nik) {
        return pendudukRepository.findByNik(nik);
    }

    @Override
    public boolean validateNikExists(String nik) {
        return pendudukRepository.findByNik(nik).isPresent();
    }

    @Override
    public boolean validateNikAndNamaLengkap(String nik, String namaLengkap) {
        return pendudukRepository.findByNikAndNamaLengkap(nik, namaLengkap).isPresent();
    }

    @Override
    public Penduduk savePenduduk(Penduduk penduduk) {
        return pendudukRepository.save(penduduk);
    }
}