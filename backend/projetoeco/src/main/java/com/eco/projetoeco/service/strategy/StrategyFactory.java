package com.eco.projetoeco.service.strategy;

public class StrategyFactory {
    public static StatusStrategy getStrategy(String status) {
        return switch (status.toUpperCase()) {
            case "ABERTA" -> new AbertaStrategy();
            case "RESOLVIDA" -> new ResolvidaStrategy();
            default -> () -> "Status desconhecido.";
        };
    }
}
