package com.eco.projetoeco.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.UpdateTimestamp; // ou CreationTimestamp se fizer mais sentido para ultimo_login no insert

import java.time.LocalDateTime;

@Entity
@Table(name = "tentativas_login")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class TentativasLogin {

    @Id
    @Column(name = "ip", length = 45)
    private String ip;

    @Column(name = "tentativas", columnDefinition = "INT DEFAULT 0")
    private Integer tentativas = 0;

    // `ultimo_login TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP`
    // Pode ser @CreationTimestamp se for definido na primeira tentativa e não mudar,
    // ou @UpdateTimestamp se atualiza a cada tentativa.
    // Ou gerenciado manualmente.
    // Pelo nome "ultimo_login", @UpdateTimestamp parece mais apropriado se a linha já existir.
    // Se a linha é criada na primeira tentativa e o timestamp é dessa criação,
    // ou se é atualizado a cada tentativa, @UpdateTimestamp é bom.
    // Se a cada tentativa a linha é atualizada e o timestamp também, @UpdateTimestamp.
    // O SQL `DEFAULT CURRENT_TIMESTAMP` e não ter `ON UPDATE CURRENT_TIMESTAMP` sugere que é setado na criação.
    // Vamos usar uma abordagem que atualiza o timestamp sempre que a entidade for atualizada


    @UpdateTimestamp
    @Column(name = "ultimo_login")
    private LocalDateTime ultimoLogin;
}