package com.eco.projetoeco.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "Denuncia")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Denuncia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titulo;
    private String descricao;
    private String categoria;
    private LocalDateTime dataCriacao;

    @Enumerated(EnumType.STRING)
    private StatusDenuncia status;

    // Comentado por enquanto—relacionamentos serão adicionados depois:
    // @ManyToOne
    // @JoinColumn(name = "usuario_cpf")
    // private Usuario usuario;
    //
    // @ManyToOne
    // @JoinColumn(name = "endereco_cep")
    // private Endereco endereco;
}
