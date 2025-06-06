package com.eco.projetoeco.dto;


import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EnderecoRequestDto {


    @NotBlank(message = "CEP é obrigatorio")
    private String cep;

    @NotBlank(message = "Estado é obrigatorio")
    private String estado;

    @NotBlank(message = "Cidade é obrigatorio")
    private String cidade;

    @NotBlank(message = "Bairro é obrigatorio")
    private String bairro;

    @NotBlank(message = "Logradouro é obrigatorio")
    private String logradouro;
}
