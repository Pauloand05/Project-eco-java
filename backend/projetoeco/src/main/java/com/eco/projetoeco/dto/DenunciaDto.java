package com.eco.projetoeco.dto;

import com.eco.projetoeco.model.StatusDenuncia;
import lombok.*;

import java.time.LocalDateTime;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class DenunciaDto {
    private Long id;
    private String titulo;
    private String descricao;
    private String categoria;
    private LocalDateTime dataCriacao;
    private StatusDenuncia status;
}