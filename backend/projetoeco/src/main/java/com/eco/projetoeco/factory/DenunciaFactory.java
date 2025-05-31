package com.eco.projetoeco.factory;

import com.eco.projetoeco.dto.DenunciaDto;
import com.eco.projetoeco.model.Denuncia;

public class DenunciaFactory {

    public static Denuncia criar(DenunciaDto dto){
        Denuncia d = new Denuncia();
        d.setDescricao(dto.getDescricao());
        d.setStatus(dto.getStatus());
        return d;
    }

    public static DenunciaDto criarDTO(Denuncia denuncia){
        DenunciaDto dto = new DenunciaDto();
        dto.setId(denuncia.getId());
        dto.setDescricao(denuncia.getDescricao());
        dto.setStatus(denuncia.getStatus());
        return dto;
    }
}
