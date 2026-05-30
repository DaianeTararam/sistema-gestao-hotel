package com.daiane.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.daiane.model.Reserva;
import com.daiane.repository.ClienteRepository;
import com.daiane.repository.QuartoRepository;
import com.daiane.repository.ReservaRepository;

// S - trata apenas requisições relacionadas a Reserva
// D - depende de interfaces de repositório, não de implementações
@Controller
public class ReservaController {

    @Autowired
    private ReservaRepository rRepo;

    @Autowired
    private ClienteRepository cRepo;

    @Autowired
    private QuartoRepository qRepo;

    @GetMapping("/reservas")
    public String listar(Model model) {
        model.addAttribute("reservas", rRepo.findAll());
        model.addAttribute("clientes", cRepo.findAll());
        model.addAttribute("quartos", qRepo.findAll());
        return "reservas";
    }

    @PostMapping("/reserva/salvar")
    public String salvarReserva(Reserva reserva) {
        rRepo.save(reserva);
        return "redirect:/reservas";
    }

    @GetMapping("/reserva/excluir/{id}")
    public String excluir(@PathVariable("id") int id) {
        rRepo.deleteById(id);
        return "redirect:/reservas";
    }
}