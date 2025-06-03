package com.eco.projetoeco.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "empresa", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"email"}),
        @UniqueConstraint(columnNames = {"telefone"})
})
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Empresa {

    @Id
    @Column(name = "cnpj", nullable = false, length = 14)
    private String cnpj;

    @Column(name = "nome", nullable = false, length = 100)
    private String nome;

    @Column(name = "email", nullable = false, length = 100)
    private String email;

    @Column(name = "telefone", nullable = false, length = 15)
    private String telefone;

    @Column(name = "senha", nullable = false, length = 45)
    private String senha;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "endereco_cep", nullable = false)
    private Endereco endereco;

    @OneToMany(mappedBy = "empresa", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Admin> admins = new ArrayList<>();
}