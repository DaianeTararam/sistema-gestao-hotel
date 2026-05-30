package com.daiane.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daiane.model.Cliente;
import com.daiane.model.Quarto;
import com.daiane.model.Servico;
import com.daiane.model.TipoQuarto;
import com.daiane.repository.ClienteRepository;
import com.daiane.repository.QuartoRepository;
import com.daiane.repository.ServicoRepository;
import com.daiane.repository.TipoQuartoRepository;

// S - responsável apenas por inicializar os dados do sistema
@Controller
public class InicializarController {

    @Autowired
    private TipoQuartoRepository tRepo;

    @Autowired
    private QuartoRepository qRepo;

    @Autowired
    private ServicoRepository sRepo;
    
    @Autowired 
    private ClienteRepository cRepo;

    @GetMapping("/inicializar")
    public ModelAndView inicializar() {

        try {
            // Insere tipos de quarto apenas se a tabela estiver vazia
            if (tRepo.count() == 0) {
                InputStream isTipo = getClass().getResourceAsStream("/tipos_quarto.txt");
                BufferedReader brTipo = new BufferedReader(new InputStreamReader(isTipo, "UTF-8"));
                String linhaTipo;
                while ((linhaTipo = brTipo.readLine()) != null) {
                    String[] dados = linhaTipo.split(";");
                    TipoQuarto t = new TipoQuarto();
                    t.setNome(dados[0]);
                    t.setPrecoDiaria(Float.parseFloat(dados[1]));
                    tRepo.save(t);
                }
                brTipo.close();
            }

            // Insere quartos apenas se a tabela estiver vazia
            if (qRepo.count() == 0) {
                List<TipoQuarto> tipos = tRepo.findAll();
                InputStream isQuarto = getClass().getResourceAsStream("/quartos.txt");
                BufferedReader brQuarto = new BufferedReader(new InputStreamReader(isQuarto, "UTF-8"));
                String linhaQuarto;
                while ((linhaQuarto = brQuarto.readLine()) != null) {
                    String[] dados = linhaQuarto.split(";");
                    Quarto q = new Quarto();
                    q.setNum(Integer.parseInt(dados[0]));
                    q.setAndar(Integer.parseInt(dados[1]));
                    q.setDescricao(dados[2]);
                    // Busca o tipo pelo índice (1=Standard, 2=Executivo, 3=Master VIP)
                    int idTipo = Integer.parseInt(dados[3]) - 1;
                    q.setTipo(tipos.get(idTipo));
                    qRepo.save(q);
                }
                brQuarto.close();
            }

            // Insere serviços apenas se a tabela estiver vazia
            if (sRepo.count() == 0) {
                InputStream isServico = getClass().getResourceAsStream("/servicos.txt");
                BufferedReader brServico = new BufferedReader(new InputStreamReader(isServico, "UTF-8"));
                String linhaServico;
                while ((linhaServico = brServico.readLine()) != null) {
                    String[] dados = linhaServico.split(";");
                    Servico s = new Servico();
                    s.setNome(dados[0]);
                    s.setDescricao(dados[1]);
                    s.setValor(Double.parseDouble(dados[2]));
                    sRepo.save(s);
                }
                brServico.close();
            }
            
            if (cRepo.count() == 0) {
                InputStream isCliente = getClass().getResourceAsStream("/clientes_teste.txt");
                BufferedReader brCliente = new BufferedReader(new InputStreamReader(isCliente, "UTF-8"));
                String linhaCliente;
                while ((linhaCliente = brCliente.readLine()) != null) {
                    String[] dados = linhaCliente.split(";");
                    Cliente c = new Cliente();
                    c.setCpf(dados[0]);
                    c.setNome(dados[1]);
                    c.setTelefone(dados[2]);
                    c.setCidade(dados[3]);
                    cRepo.save(c);
                }
                brCliente.close();
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/");
    }
}