package com.eco.projetoeco.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "avaliacoes")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Avaliacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long Id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "usuario_cpf", nullable = false)
    private Usuario usuario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "jogos_id", nullable = false)
    private Jogos jogo;

    @Enumerated(EnumType.STRING)
    @Column(name = "avaliacao", nullable = false, length = 15)
    private NivelAvaliacao avaliacao;

    @Column(name = "comentario", columnDefinition = "TEXT")
    private String comentario;

    @CreationTimestamp
    @Column(name = "data_criacao", updatable = false)
    private LocalDateTime dataCriacao;
}
