package com.eco.projetoeco.dto;

import com.eco.projetoeco.model.Endereco;
import com.eco.projetoeco.model.StatusDenuncia;
import com.eco.projetoeco.model.Usuario;
import lombok.*;

import java.time.LocalDateTime;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class DenunciaDto {
    private Long id;
    private String titulo;
    private String descricao;
    private StatusDenuncia status;
    private String anexo;
    private LocalDateTime dataCriacao;
    private LocalDateTime dataAtualizacao;
    private Usuario usuario;
    private Endereco endereco;

}