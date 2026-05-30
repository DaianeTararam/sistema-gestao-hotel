package com.daiane.model;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "hospedagem")
public class Hospedagem {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;
	
	@Column(name = "data_entrada", nullable = false)
    private LocalDate dataEntrada;
	
	@Transient
	private String dtEntradaFormatada;
	
	public String getDtEntradaFormatada() {
        if (this.dataEntrada != null) {
            return this.dataEntrada.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }
        return "";
    }
	
	@Column(name = "data_saida", nullable = false)
    private LocalDate dataSaida;
	
	@Transient
	private String dtSaidaFormatada;
	
	public String getDtSaidaFormatada() {
        if (this.dataSaida != null) {
            return this.dataSaida.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }
        return "";
    }
	
	@Column(name = "status", nullable = false)
	private boolean status;
	
	@ManyToOne
	@JoinColumn(name = "cpf_cliente", nullable = false)
    private Cliente cliente;
	
	@ManyToOne
	@JoinColumn(name = "num_quarto", nullable = false)
	private Quarto quarto;
	
	@OneToMany(mappedBy = "hospedagem", fetch = FetchType.LAZY)
	private List<ConsumoServico> consumoServicos;
}
