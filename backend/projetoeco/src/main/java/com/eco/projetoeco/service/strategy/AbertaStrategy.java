package com.eco.projetoeco.service.strategy;

public class AbertaStrategy implements StatusStrategy {

    @Override
    public String resolverMensagem() {
        return "A denúncia está em aberto e aguardando avaliação".toUpperCase();
    }
}
