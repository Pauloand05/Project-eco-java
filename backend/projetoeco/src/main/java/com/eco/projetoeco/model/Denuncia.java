package com.eco.projetoeco.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table()
@Data
@NoArgsConstructor
public class Denuncia {
    @Id
    @GeneratedValue()
    private Long id;
}
