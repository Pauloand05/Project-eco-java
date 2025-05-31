package com.eco.projetoeco.factory;

import com.eco.projetoeco.dto.DenunciaDTO;
import com.eco.projetoeco.model.Denuncia;

public class DenunciaFactory {

    public static Denuncia criar(DenunciaDTO dto){
        Denuncia d = new Denuncia();
        d.setDescricao(dto.getDescricao());
        d.setStatus(dto.getStatus());
        return d;
    }

    public static DenunciaDTO criarDTO(Denuncia denuncia){
        DenunciaDTO dto = new DenunciaDTO();
        dto.setId(denuncia.getId());
        dto.setDescricao(denuncia.getDescricao());
        dto.setStatus(denuncia.getStatus());
        return dto;
    }
}
