<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-titulo">GESTÃO DO HOTEL</div>
        <ul class="menu-lista">
            <li><a href="${pageContext.request.contextPath}/">🏠 Home</a></li>
            <li><a href="${pageContext.request.contextPath}/reservas">📅 Reservas</a></li>
            <li><a href="${pageContext.request.contextPath}/quartos">🛏️ Quartos</a></li>
            <li><a href="${pageContext.request.contextPath}/hospedagens">🔑 Hospedagem</a></li>
            <li><a href="${pageContext.request.contextPath}/servicos">🍽️ Serviços</a></li>
            <li><a href="${pageContext.request.contextPath}/relatorios">📊 Relatórios</a></li>
        </ul>
    </div>

    <div class="conteudo-principal">
        <div class="container">
            <h1 class="mb-4">${cliente.cpf != null ? 'Editar Hóspede' : 'Novo Hóspede'}</h1>
            <hr>

            <form action="${pageContext.request.contextPath}/cliente/salvar" method="post" class="row g-3">
                
                <div class="col-md-6">
                    <label class="form-label">CPF</label>
                    <input type="text" name="cpf" value="${cliente.cpf}" class="form-control" 
                           placeholder="00000000000" maxlength="11" required 
                           ${cliente.cpf != null ? 'readonly' : ''}>
                    <small class="text-muted">Apenas números.</small>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Nome Completo</label>
                    <input type="text" name="nome" value="${cliente.nome}" 
                    	   class="form-control" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Telefone</label>
                    <input type="text" name="telefone" value="${cliente.telefone}" 
                    	   class="form-control" placeholder="11999999999" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Cidade</label>
                    <input type="text" name="cidade" value="${cliente.cidade}" 
                    	   class="form-control" required>
                </div>

                <div class="col-12 mt-4">
                    <button type="submit" class="btn-hotel">Salvar Hóspede</button>
                    <a href="${pageContext.request.contextPath}/clientes" 
                       class="btn btn-secondary ms-2" style="border-radius: 15px; 
                       padding: 10px 20px;">Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>