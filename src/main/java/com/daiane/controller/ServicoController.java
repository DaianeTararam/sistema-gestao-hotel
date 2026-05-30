package com.daiane.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.daiane.model.Servico;
import com.daiane.repository.ServicoRepository;

@Controller
public class ServicoController {

    @Autowired
    private ServicoRepository sRepo;

    @GetMapping("/servicos")
    public String listar(Model model) {
        model.addAttribute("servicos", sRepo.findAll());
        return "servicos";
    }

    @PostMapping("/servico/salvar")
    public String salvar(Servico servico) {
        sRepo.save(servico);
        return "redirect:/servicos";
    }
}
