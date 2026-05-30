package com.daiane.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.daiane.model.Servico;

@Repository
public interface ServicoRepository extends JpaRepository<Servico, Integer>{

}
