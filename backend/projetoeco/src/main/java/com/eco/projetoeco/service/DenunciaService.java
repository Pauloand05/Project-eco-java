package com.eco.projetoeco.service;

import com.eco.projetoeco.dto.DenunciaDto;

import java.util.List;
import java.util.Optional;

public interface DenunciaService {
    DenunciaDto criarDenuncia(DenunciaDto denunciaDto);
    List<DenunciaDto> listarTodas();
    Optional<DenunciaDto> buscarPorId(Long id);
}
