package com.daiane.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.daiane.model.Quarto;

@Repository
public interface QuartoRepository extends JpaRepository<Quarto, Integer>{
	//Native query para buscar quartos que estejam disponíveis atrávés da UDF no banco de dados
	@Query(value =  "SELECT * FROM fn_quartos_disponiveis(:data, :dias)", nativeQuery = true)
	List<Quarto> findQuartosDisponiveis(@Param("data") LocalDate data, @Param("dias") int dias);
}
