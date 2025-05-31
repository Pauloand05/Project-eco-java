package com.eco.projetoeco.service.strategy;

public class ResolvidaStrategy implements StatusStrategy{
    @Override
    public String resolverMensagem() {
        return "Denúncia resolvida com sucesso !".toUpperCase();
    }
}
