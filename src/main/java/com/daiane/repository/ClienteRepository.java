package com.daiane.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.daiane.model.Cliente;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, String>{
	List<Cliente> findByNome(String nome);
}
