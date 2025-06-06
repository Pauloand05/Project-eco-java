package com.eco.projetoeco.service.impl;

import com.eco.projetoeco.dto.EnderecoDto;
import com.eco.projetoeco.dto.EnderecoRequestDto;
import com.eco.projetoeco.model.Endereco;
import com.eco.projetoeco.repository.EnderecoRepository;
import com.eco.projetoeco.service.EnderecoService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class EnderecoServiceImpl implements EnderecoService {

    private final EnderecoRepository repository;
    public EnderecoServiceImpl(EnderecoRepository repository) {this.repository = repository;}

    @Override
    public EnderecoDto criar(EnderecoRequestDto dto) {
        Endereco endereco = new Endereco(
                dto.getCep(),
                dto.getEstado(),
                dto.getCidade(),
                dto.getBairro(),
                dto.getLogradouro()
        );

        Endereco salvo = repository.save(endereco);
        return new EnderecoDto(
                salvo.getCep(),
                salvo.getEstado(),
                salvo.getCidade(),
                salvo.getBairro(),
                salvo.getLogradouro()
        );
    }

    @Override
    public List<EnderecoDto> listar() {
        return repository.findAll().stream().map(
                e -> new EnderecoDto(
                        e.getCep(),
                        e.getEstado(),
                        e.getCidade(),
                        e.getBairro(),
                        e.getLogradouro()
                )).collect(Collectors.toList());
    }

    @Override
    public void excluir(String cep) {
        repository.deleteById(cep);
    }
}
