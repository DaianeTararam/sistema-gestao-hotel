package com.daiane.model;

import java.util.List;

import org.hibernate.validator.constraints.br.CPF;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "cliente")
public class Cliente {
	@Id
	@CPF(message = "O CPF informado é inválido")
	@Column(name = "cpf", length = 11, nullable = false)
	private String cpf;
	
	@Column(name = "nome", length = 50, nullable = false)
	private String nome;
	
	@Column(name = "telefone",length = 11, nullable = false)
	private String telefone;
	
	@Column(name = "cidade", length = 50, nullable = false)
	private String cidade;
	
	@OneToMany(mappedBy = "cliente", fetch = FetchType.LAZY)
	private List<Reserva> reservas;
	
	@OneToMany(mappedBy = "cliente", fetch = FetchType.LAZY)
	private List<Hospedagem> hospedagens;
	
	
}
