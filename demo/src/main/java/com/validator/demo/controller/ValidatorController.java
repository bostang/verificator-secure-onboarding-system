package com.validator.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.validator.demo.dto.ValidationRequest;
import com.validator.demo.model.Penduduk;
import com.validator.demo.service.PendudukService;

@RestController
@RequestMapping("/api/validator")
// Mengizinkan CORS dari frontend React (port 3000)
// @CrossOrigin(origins = "http://localhost:3000", methods = {RequestMethod.POST, RequestMethod.GET})
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:8081"}) // Contoh: Mengizinkan frontend dan backend pertama
public class ValidatorController {

    @Autowired
    private PendudukService pendudukService;

    // Endpoint untuk validasi apakah NIK ada
    @PostMapping("/validate/nik-exists")
    public ResponseEntity<Map<String, Boolean>> validateNikExists(@RequestBody ValidationRequest request) {
        boolean exists = pendudukService.validateNikExists(request.getNik());
        Map<String, Boolean> response = new HashMap<>();
        response.put("nikExists", exists);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    // Endpoint untuk validasi NIK dan nama lengkap
    @PostMapping("/validate/nik-nama")
    public ResponseEntity<Map<String, Boolean>> validateNikAndNamaLengkap(@RequestBody ValidationRequest request) {
        boolean matches = pendudukService.validateNikAndNamaLengkap(request.getNik(), request.getNamaLengkap());
        Map<String, Boolean> response = new HashMap<>();
        response.put("nikNamaMatches", matches);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    // Endpoint untuk mendapatkan detail penduduk berdasarkan NIK (opsional, untuk melihat data)
    @GetMapping("/get-details/{nik}")
    public ResponseEntity<Penduduk> getPendudukDetails(@PathVariable String nik) {
        return pendudukService.getPendudukByNik(nik)
                .map(penduduk -> new ResponseEntity<>(penduduk, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }
}