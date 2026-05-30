package com.daiane.model;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
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
@Table(name = "tipo_quarto")
public class TipoQuarto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;
	
    @Column(name = "nome", length= 30, nullable = false)
    private String nome;
    
    @Column(name = "preco_diaria", nullable = false)
    private float precoDiaria;
    
    @OneToMany(mappedBy = "tipo", fetch = FetchType.LAZY)
    private List<Quarto> quartos;
}
