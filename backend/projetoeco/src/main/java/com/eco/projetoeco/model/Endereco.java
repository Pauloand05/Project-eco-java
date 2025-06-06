package com.eco.projetoeco.model;


import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "endereco")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Endereco {

    @Id
    @Column(name = "cep", length = 8)
    private String cep;

    @Column(name = "estado", nullable = false, length = 45)
    private String estado;

    @Column(name = "cidade", nullable = false, length = 45)
    private String cidade;

    @Column(name = "bairro", nullable = false, length = 45)
    private String bairro;

    @Column(name = "logradouro", nullable = false, length = 100)
    private String logradouro;

    @OneToMany(mappedBy = "endereco",cascade = CascadeType.ALL,
             orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<Denuncia> denuncias = new ArrayList<>();

    @OneToMany(mappedBy = "endereco", cascade = CascadeType.ALL,
            orphanRemoval = true, fetch = FetchType.LAZY)
    private List<HorariosColeta> horariosColetas = new ArrayList<>();

    public Endereco(
            @NotBlank(message = "CEP é obrigatorio") String cep,
            @NotBlank(message = "Estado é obrigatorio") String estado,
            @NotBlank(message = "Cidade é obrigatorio") String cidade,
            @NotBlank(message = "Bairro é obrigatorio") String bairro,
            @NotBlank(message = "Logradouro é obrigatorio") String logradouro) {
        this.cep = cep;
        this.estado = estado;
        this.cidade = cidade;
        this.bairro = bairro;
        this.logradouro = logradouro;
    }
}
