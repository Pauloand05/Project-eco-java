package com.eco.projetoeco.controller;


import com.eco.projetoeco.dto.EnderecoDto;
import com.eco.projetoeco.dto.EnderecoRequestDto;
import com.eco.projetoeco.model.Endereco;
import com.eco.projetoeco.service.EnderecoService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/enderecos")
public class EnderecoController {

    private final EnderecoService service;
    public EnderecoController(EnderecoService service) {this.service = service;}

    @PostMapping
    public ResponseEntity<EnderecoDto> criar(@RequestBody @Valid EnderecoRequestDto dto) {
        EnderecoDto criado = service.criar(dto);
        return ResponseEntity.status(201).body(criado);
    }

    @GetMapping
    public ResponseEntity<List<EnderecoDto>> listar() {
        return ResponseEntity.ok(service.listar());
    }

    @DeleteMapping("/{cep}")
    public ResponseEntity<Void> deletar(@PathVariable String cep) {
        service.excluir(cep);
        return ResponseEntity.noContent().build();
    }
}
