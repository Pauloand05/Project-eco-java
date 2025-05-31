package com.eco.projetoeco.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "denuncia")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Denuncia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "titulo", nullable = false)
    private String titulo;

    @Column(name = "descricao", nullable = false, columnDefinition = "TEXT")
    private String descricao;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private StatusDenuncia status = StatusDenuncia.PENDENTE;

    @Column(name = "anexo")
    private String anexo;

    @CreationTimestamp
    @Column(name = "data_criacao", updatable = false)
    private LocalDateTime dataCriacao;

    @UpdateTimestamp
    @Column(name = "data_atualizacao")
    private LocalDateTime dataAtualizacao;

//    @ManyToOne
//    @JoinColumn(name = "usuario_cpf", nullable = false)
//    private Usuario usuario;
//
//    @ManyToOne
//    @JoinColumn(name = "endereco_cep", nullable = false)
//    private Endereco endereco;
}
