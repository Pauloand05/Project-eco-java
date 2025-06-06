package com.eco.projetoeco.service;

import com.eco.projetoeco.dto.EnderecoDto;
import com.eco.projetoeco.dto.EnderecoRequestDto;

import java.util.List;

public interface EnderecoService {

    EnderecoDto criar(EnderecoRequestDto dto);
    List<EnderecoDto> listar();
    void excluir(String cep);
}
