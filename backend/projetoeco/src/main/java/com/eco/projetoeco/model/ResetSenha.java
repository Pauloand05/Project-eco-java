package com.eco.projetoeco.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "reset_senha", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"email"}) // email_UNIQUE
})
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ResetSenha {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "email", nullable = false, length = 100) // É único
    private String email;

    @Column(name = "token", nullable = false, length = 255)
    private String token;

    @CreationTimestamp
    @Column(name = "data_criacao", updatable = false)
    private LocalDateTime dataCriacao;
}
