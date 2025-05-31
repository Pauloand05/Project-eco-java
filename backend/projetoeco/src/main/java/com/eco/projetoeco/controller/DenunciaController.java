package com.eco.projetoeco.controller;


import com.eco.projetoeco.dto.DenunciaDTO;
import com.eco.projetoeco.service.DenunciaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/denuncias")
public class DenunciaController {

    private final DenunciaService denunciaService;

    public DenunciaController(DenunciaService denunciaService) {this.denunciaService = denunciaService;}

    @PostMapping("/criar")
    public ResponseEntity<DenunciaDTO> criar(@RequestBody DenunciaDTO dto){
        return ResponseEntity.ok(denunciaService.criarDenuncia(dto));
    }
}