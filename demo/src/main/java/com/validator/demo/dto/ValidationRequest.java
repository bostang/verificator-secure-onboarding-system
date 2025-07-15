package com.validator.demo.dto;

import lombok.AllArgsConstructor; // Lombok
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ValidationRequest {
    private String nik;
    private String namaLengkap;
}