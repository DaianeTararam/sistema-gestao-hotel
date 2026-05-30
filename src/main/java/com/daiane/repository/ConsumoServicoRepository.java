package com.daiane.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.daiane.model.ConsumoServico;

@Repository
public interface ConsumoServicoRepository extends JpaRepository<ConsumoServico, Integer>{

}
