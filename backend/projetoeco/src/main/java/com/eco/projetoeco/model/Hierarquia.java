package com.eco.projetoeco.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "hierarquia")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Hierarquia {

    @Id
    @Column(name = "admin_codigo")
    private String adminCodigo;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "admin_codigo")
    private Admin admin;

    @Enumerated(EnumType.STRING)
    @Column(name = "hierarquia", length = 10)
    private NivelHierarquia nivel;
}
