package com.eco.projetoeco.dto;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EnderecoDto {

    private String cep;
    private String estado;
    private String cidade;
    private String bairro;
    private String logradouro;
}
