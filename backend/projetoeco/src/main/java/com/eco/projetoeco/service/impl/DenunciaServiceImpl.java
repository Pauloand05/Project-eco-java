package com.eco.projetoeco.service.impl;


import com.eco.projetoeco.dto.DenunciaDto;
import com.eco.projetoeco.dto.DenunciaRequestDto;
import com.eco.projetoeco.model.Denuncia;
import com.eco.projetoeco.model.Endereco;
import com.eco.projetoeco.model.StatusDenuncia;
import com.eco.projetoeco.model.Usuario;
import com.eco.projetoeco.repository.DenunciaRepository;
import com.eco.projetoeco.repository.EnderecoRepository;
import com.eco.projetoeco.repository.UsuarioRepository;
import com.eco.projetoeco.service.DenunciaService;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class DenunciaServiceImpl implements DenunciaService {

    private final DenunciaRepository repository;
    private final UsuarioRepository usuarioRepository;
    private final EnderecoRepository enderecoRepository;

    public DenunciaServiceImpl(DenunciaRepository repository,
                               UsuarioRepository usuarioRepository,
                               EnderecoRepository enderecoRepository)
                               {
        this.repository = repository;
        this.usuarioRepository = usuarioRepository;
        this.enderecoRepository = enderecoRepository;
    }

    @Override
    @Transactional
    public DenunciaDto criarDenuncia(DenunciaRequestDto request){

        /* 1) buscar o Usuario pelo CPF*/
        Usuario usuario = usuarioRepository.findById(request.getUsuarioCpf())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        /* 2) buscar o Endereco pelo CEP */
        Endereco endereco = enderecoRepository.findById(request.getEnderecoCep())
                .orElseThrow(() -> new RuntimeException("Endereço não encontrado"));

        Denuncia denuncia = new Denuncia();
        denuncia.setTitulo(request.getTitulo());
        denuncia.setDescricao(request.getDescricao());
        denuncia.setAnexo(request.getAnexo());
        denuncia.setStatus(StatusDenuncia.PENDENTE);
        denuncia.setUsuario(usuario);
        denuncia.setEndereco(endereco);

        Denuncia salva = repository.save(denuncia);
        return new DenunciaDto(
                salva.getId(), salva.getTitulo(), salva.getDescricao(),
                salva.getStatus(), salva.getAnexo(), salva.getDataCriacao(),
                salva.getDataAtualizacao(), salva.getUsuario(), salva.getEndereco()
        );
    }

    @Override
    public List<DenunciaDto> listarTodas() {
        return repository.findAll().stream()
                .map(d -> new DenunciaDto(
                        d.getId(), d.getTitulo(), d.getDescricao(),
                        d.getStatus(), d.getAnexo(), d.getDataCriacao(),
                        d.getDataAtualizacao(), d.getUsuario(), d.getEndereco()
                ))
                .collect(Collectors.toList());
    }

    @Override
    public Optional<DenunciaDto> buscarPorId(Long id) {
        return repository.findById(id)
                .map(d -> new DenunciaDto(
                        d.getId(), d.getTitulo(), d.getDescricao(),
                        d.getStatus(), d.getAnexo(), d.getDataCriacao(),
                        d.getDataAtualizacao(), d.getUsuario(), d.getEndereco()
                ));
    }
}
