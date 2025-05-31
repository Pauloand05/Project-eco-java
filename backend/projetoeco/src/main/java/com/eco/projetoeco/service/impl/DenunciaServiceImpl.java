package com.eco.projetoeco.service.impl;


import com.eco.projetoeco.dto.DenunciaDto;
import com.eco.projetoeco.model.Denuncia;
import com.eco.projetoeco.model.StatusDenuncia;
import com.eco.projetoeco.repository.DenunciaRepository;
import com.eco.projetoeco.service.DenunciaService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class DenunciaServiceImpl implements DenunciaService {

    private final DenunciaRepository repository;

    public DenunciaServiceImpl(DenunciaRepository repository) {
        this.repository = repository;
    }

    @Override
    public DenunciaDto criarDenuncia(DenunciaDto dto){
        Denuncia denuncia = new Denuncia();
        denuncia.setTitulo(dto.getTitulo());
        denuncia.setDescricao(dto.getDescricao());
        denuncia.setCategoria(dto.getCategoria());
        denuncia.setDataCriacao(LocalDateTime.now());
        denuncia.setStatus(StatusDenuncia.PENDENTE);

        Denuncia salva = repository.save(denuncia);

        return new DenunciaDto(
                salva.getId(), salva.getTitulo(), salva.getDescricao(),
                salva.getCategoria(), salva.getDataCriacao(), salva.getStatus()
        );
    }

    @Override
    public List<DenunciaDto> listarTodas() {
        return repository.findAll().stream()
                .map(d -> new DenunciaDto(
                        d.getId(), d.getTitulo(), d.getDescricao(),
                        d.getCategoria(), d.getDataCriacao(), d.getStatus()
                ))
                .collect(Collectors.toList());
    }

    @Override
    public Optional<DenunciaDto> buscarPorId(Long id) {
        return repository.findById(id)
                .map(d -> new DenunciaDto(
                        d.getId(), d.getTitulo(), d.getDescricao(),
                        d.getCategoria(), d.getDataCriacao(), d.getStatus()
                ));
    }
}
