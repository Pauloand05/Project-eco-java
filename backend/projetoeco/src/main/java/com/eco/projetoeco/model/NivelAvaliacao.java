package com.eco.projetoeco.model;

public enum NivelAvaliacao {
    UM("1"),
    DOIS("2"),
    TRES("3"),
    QUATRO("4"),
    CINCO("5");

    private final String valor;
    NivelAvaliacao(String valor) {
        this.valor = valor;
    }

    public String getValor() {
        return valor;
    }

    public static NivelAvaliacao fromValor(String valor){
        for (NivelAvaliacao nivel : NivelAvaliacao.values()){
            if (nivel.valor.equals(valor)){
                return nivel;
            }
        }
        throw new IllegalArgumentException("Valor da avaliação inválida: " + valor);
    }
}
