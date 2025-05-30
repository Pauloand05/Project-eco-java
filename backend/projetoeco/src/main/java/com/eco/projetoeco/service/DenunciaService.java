package com.eco.projetoeco.service;


import com.eco.projetoeco.repository.DenunciaRepository;
import org.springframework.stereotype.Service;

@Service
public class DenunciaService {

    private final DenunciaRepository denunciaRepository;

    public DenunciaService(DenunciaRepository denunciaRepository) {
        this.denunciaRepository = denunciaRepository;
    }
}
