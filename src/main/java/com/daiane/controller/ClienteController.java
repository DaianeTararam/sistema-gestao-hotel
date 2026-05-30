package com.daiane.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.daiane.model.Cliente;
import com.daiane.repository.ClienteRepository;

@Controller
public class ClienteController {
	@Autowired
    private ClienteRepository cRepo;
	
	@GetMapping("/cliente/inserir")
	public String inserir(Model model) {
	    model.addAttribute("cliente", new Cliente()); 
	    return "cliente_formulario";
	}

    @GetMapping("/clientes")
    public String listar(Model model) {
        model.addAttribute("clientes", cRepo.findAll());
        return "cliente_lista";
    }

    @PostMapping("/cliente/salvar")
    public String salvar(Cliente cliente) {
        cRepo.save(cliente);
        return "redirect:/clientes";
    }

    @GetMapping("/cliente/excluir/{cpf}")
    public String excluir(@PathVariable("cpf") String cpf) {
        cRepo.deleteById(cpf);
        return "redirect:/clientes";
    }
    
    @GetMapping("/cliente/editar/{cpf}")
    public String editar(@PathVariable("cpf") String cpf, Model model) {
        Cliente cliente = cRepo.findById(cpf).orElse(null);
        model.addAttribute("cliente", cliente);
        return "cliente_formulario";
    }
}
