package com.daiane.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.daiane.repository.ClienteRepository;
import com.daiane.repository.HospedagemRepository;
import com.daiane.repository.QuartoRepository;
import com.daiane.repository.ServicoRepository;

// S - Single Responsibility: trata apenas requisições relacionadas a Hospedagem
// D - Dependency Inversion: depende da interface do repositório, não da implementação
@Controller
public class HospedagemController {

    @Autowired
    private HospedagemRepository hRepo;
    @Autowired
    private ClienteRepository cRepo;
    @Autowired
    private QuartoRepository qRepo;
    @Autowired
    private ServicoRepository sRepo;

    @GetMapping("/hospedagens")
    public String listar(
            @RequestParam(value = "cpf", required = false) String cpf,
            @RequestParam(value = "quarto", required = false) Integer quarto,
            @RequestParam(value = "idHospedagem", required = false) Integer idHospedagem,
            Model model) {

        model.addAttribute("hospedagens", hRepo.findAll());
        model.addAttribute("clientes", cRepo.findAll());
        model.addAttribute("quartos", qRepo.findAll());
        
        model.addAttribute("listaServicos", sRepo.findAll());
        
        model.addAttribute("cpfParam", cpf);
        model.addAttribute("quartoParam", quarto);
        model.addAttribute("idHospedagemParam", idHospedagem);
        return "hospedagem";
    }

    @PostMapping("/hospedagem/checkin")
    public String realizarCheckin(
            @RequestParam("cpf_cli") String cpf,
            @RequestParam("n_quarto") int quarto,
            @RequestParam("saida") String dataSaida) {
        hRepo.spFazerCheckin(cpf, quarto, LocalDate.parse(dataSaida));
        return "redirect:/hospedagens";
    }

    @PostMapping("/hospedagem/checkout")
    public String checkout(@RequestParam("id") int id) {
        hRepo.spFazerCheckout(id);
        return "redirect:/hospedagens";
    }
    
    
}