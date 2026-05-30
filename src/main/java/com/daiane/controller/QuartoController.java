// S - trata apenas requisições relacionadas a Quarto
// D - depende de interfaces de repositório, não de implementações
package com.daiane.controller;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.daiane.model.Hospedagem;
import com.daiane.model.Quarto;
import com.daiane.model.Reserva;
import com.daiane.repository.HospedagemRepository;
import com.daiane.repository.QuartoRepository;
import com.daiane.repository.ReservaRepository;


@Controller
public class QuartoController {

    @Autowired
    private QuartoRepository qRepo;

    @Autowired
    private HospedagemRepository hRepo;

    @Autowired
    private ReservaRepository rRepo;

    @GetMapping("/quartos")
    public String listar(Model model) {
        List<Quarto> quartos = qRepo.findAll();
        List<Hospedagem> hospedagens = hRepo.findAll();
        List<Reserva> reservas = rRepo.findAll();

        // Coleta os números dos quartos ocupados (hospedagem com status ativo)
        Set<Integer> ocupados = new HashSet<>();
        for (Hospedagem h : hospedagens) {
            if (h.isStatus()) {
                ocupados.add(h.getQuarto().getNum());
            }
        }

        // Coleta os números dos quartos com reserva
        Set<Integer> reservados = new HashSet<>();
        for (Reserva r : reservas) {
            reservados.add(r.getQuarto().getNum());
        }

        model.addAttribute("quartos", quartos);
        model.addAttribute("hospedagens", hospedagens);
        model.addAttribute("reservas", reservas);
        model.addAttribute("ocupados", ocupados);
        model.addAttribute("reservados", reservados);

        return "quarto";
    }

    @GetMapping("/quartos/disponibilidade")
    public String verificarDisponibilidade(
            @RequestParam("data") String data,
            @RequestParam("dias") int dias,
            Model model) {
        List<Quarto> disponiveis = qRepo.findQuartosDisponiveis(LocalDate.parse(data), dias);
        model.addAttribute("quartos", disponiveis);
        return "listaQuartos";
    }
}