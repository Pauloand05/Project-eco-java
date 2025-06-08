package com.eco.projetoeco.service;

import com.eco.projetoeco.dto.UsuarioDto;
import com.eco.projetoeco.dto.UsuarioRequestDto;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface UsuarioService {

    UsuarioDto criar(UsuarioRequestDto dto);
    List<UsuarioDto> listarTodos();
    UsuarioDto buscarPorCpf(String cpf);
    UsuarioDto autenticar(String cpf, String senha);
}
