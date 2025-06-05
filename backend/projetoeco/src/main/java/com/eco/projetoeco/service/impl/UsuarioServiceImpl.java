package com.eco.projetoeco.service.impl;

import com.eco.projetoeco.dto.UsuarioDto;
import com.eco.projetoeco.dto.UsuarioRequestDto;
import com.eco.projetoeco.model.Usuario;
import com.eco.projetoeco.repository.UsuarioRepository;
import com.eco.projetoeco.service.UsuarioService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioRepository repository;
    public UsuarioServiceImpl(UsuarioRepository repository) {this.repository = repository;}


    @Override
    public UsuarioDto criar(UsuarioRequestDto dto) {
        Usuario usuario = new Usuario(
                dto.getCpf(), dto.getNome(), dto.getNickname(),
                dto.getEmail(), dto.getTelefone(), dto.getSenha(),
                null, null);
        Usuario salvo = repository.save(usuario);
        return new UsuarioDto(
                salvo.getCpf(), salvo.getNome(), salvo.getNickname(),
                salvo.getEmail(), salvo.getTelefone()
        );
    }

    @Override
    public List<UsuarioDto> listarTodos() {
        return repository.findAll().stream()
                .map(u -> new UsuarioDto(
                        u.getCpf(), u.getNome(), u.getNickname(),
                        u.getEmail(), u.getTelefone()
                        ))
                .collect(Collectors.toList());
    }

    @Override
    public UsuarioDto buscarPorCpf(String cpf) {
        Usuario usuario = repository.findById(cpf)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
        return new UsuarioDto(
                usuario.getCpf(), usuario.getNome(), usuario.getNickname(),
                usuario.getEmail(), usuario.getTelefone()
                );
    }
}
