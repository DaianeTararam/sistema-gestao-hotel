package com.daiane.controller;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
 
// S - Responsabilidade única: responsável apenas por abrir a tela de relatórios
@Controller
public class RelatorioController {
 
    @GetMapping("/relatorios")
    public String abrirTela() {
        return "relatorios";
    }
}
 
