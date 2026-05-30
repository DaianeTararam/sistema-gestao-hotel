package com.daiane.model;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "quarto")
public class Quarto {
	@Id
	@Column(name = "num", nullable = false)
    private int num;
	
	@Column(name = "andar", nullable = false)
	private int andar;
	
	@Column(name = "descricao", length = 100, nullable = false)
	private String descricao;
		
	@ManyToOne
	@JoinColumn(name = "id_tipo", nullable = false)
	private TipoQuarto tipo;
	
	@OneToMany(mappedBy = "quarto", fetch = FetchType.LAZY)
    private List<Reserva> reservas;

    @OneToMany(mappedBy = "quarto", fetch = FetchType.LAZY)
    private List<Hospedagem> hospedagens;
	
}
