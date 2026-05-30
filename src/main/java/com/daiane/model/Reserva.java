package com.daiane.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "reserva")
public class Reserva {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;
	
	@Column(name = "data_inicio", nullable = false)
    private LocalDate dataInicio;
	
	@Transient
	private String dtInicioFormatada;
	
	public String getDtInicioFormatada() {
        if (this.dataInicio != null) {
            return this.dataInicio.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }
        return "";
    }
	
	@Column(name = "qtde_dias", nullable = false)
    private int qtdeDias;
	
	@ManyToOne
	@JoinColumn(name = "cpf_cliente", nullable = false)
    private Cliente cliente;
	
	@ManyToOne
	@JoinColumn(name = "num_quarto", nullable = false)
	private Quarto quarto;
	
	
}
