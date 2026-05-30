<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hóspedes</title>
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
        <h1>Gestão de Hóspedes</h1>
        <p class="text-muted">Lista de clientes cadastrados no sistema.</p>
        <hr>
        
        <div style="margin-bottom: 20px; text-align: right;">
            <a href="${pageContext.request.contextPath}/cliente/inserir" class="btn-hotel" style="text-decoration: none;">
                + Cadastrar Novo Hóspede
            </a>
        </div>

        <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden;">
            <thead style="background-color: #1b263b; color: #e0c097;">
                <tr>
                    <th style="padding: 15px;">CPF</th>
                    <th style="padding: 15px;">Nome</th>
                    <th style="padding: 15px;">Telefone</th>
                    <th style="padding: 15px;">Cidade</th>
                    <th style="padding: 15px;">Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${clientes}">
                    <tr style="border-bottom: 1px solid #eee;">
                        <td style="padding: 15px;">${c.cpf}</td>
                        <td style="padding: 15px;">${c.nome}</td>
                        <td style="padding: 15px;">${c.telefone}</td>
                        <td style="padding: 15px;">${c.cidade}</td>
                        <td style="padding: 15px;">
                            <a href="${pageContext.request.contextPath}/cliente/editar/${c.cpf}" style="color: #1b263b; margin-right: 10px;">Editar</a>
                            <form action="${pageContext.request.contextPath}/relatorio/consumo" method="post" target="_blank" style="display: inline;">
						        <input type="hidden" name="cpf" value="${c.cpf}">
						        <button type="submit" style="background: none; border: none; color: #1b263b; padding: 0; margin-right: 10px; cursor: pointer; text-decoration: underline; font-family: inherit; font-size: inherit;">
						            Extrato
						        </button>
						    </form>
    						<a href="${pageContext.request.contextPath}/cliente/excluir/${c.cpf}" style="color: #d9534f;" onclick="return confirm('Excluir este hóspede?')">Excluir</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>