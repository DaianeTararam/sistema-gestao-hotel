package com.daiane.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.daiane.model.Hospedagem;

@Repository
public interface HospedagemRepository extends JpaRepository<Hospedagem, Integer>{
	@Procedure(procedureName = "sp_fazer_checkin")
	public void spFazerCheckin(@Param("cpf_cli") String cpf, @Param("num_quarto") int quarto, @Param("d_saida") LocalDate saida );
	
	@Procedure(procedureName = "sp_fazer_checkout")
	public void spFazerCheckout(@Param("id_hospedagem") int idHospedagem);

	
}
