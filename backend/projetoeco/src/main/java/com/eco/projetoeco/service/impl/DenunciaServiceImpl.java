package com.eco.projetoeco.service.impl;


import com.eco.projetoeco.dto.DenunciaDTO;
import com.eco.projetoeco.factory.DenunciaFactory;
import com.eco.projetoeco.model.Denuncia;
import com.eco.projetoeco.repository.DenunciaRepository;
import com.eco.projetoeco.service.DenunciaService;
import com.eco.projetoeco.service.strategy.StatusStrategy;
import com.eco.projetoeco.service.strategy.StrategyFactory;
import org.springframework.stereotype.Service;

@Service
public class DenunciaServiceImpl implements DenunciaService {

    private final DenunciaRepository repository;

    public DenunciaServiceImpl(DenunciaRepository repository) {
        this.repository = repository;
    }

    @Override
    public DenunciaDTO criarDenuncia(DenunciaDTO dto){
        Denuncia denuncia = DenunciaFactory.criar(dto);
        repository.save(denuncia);

        StatusStrategy strategy = StrategyFactory.getStrategy(denuncia.getStatus());
        System.out.println(strategy.resolverMensagem());

        return DenunciaFactory.criarDTO(denuncia);
    }
}
