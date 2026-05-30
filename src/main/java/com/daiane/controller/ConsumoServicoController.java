package com.daiane.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import com.daiane.model.ConsumoServico;
import com.daiane.repository.ConsumoServicoRepository;

@Controller
public class ConsumoServicoController {

    @Autowired
    private ConsumoServicoRepository cRepo;

    @PostMapping("/consumo/registrar")
    public String registrar(ConsumoServico consumo) {
        cRepo.save(consumo);
        return "redirect:/hospedagens";
    }
}