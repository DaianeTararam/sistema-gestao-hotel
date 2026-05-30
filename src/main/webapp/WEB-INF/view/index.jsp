<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<title>Gestão do Hotel - Início</title>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-titulo">GESTÃO DO HOTEL</div>
        <ul class="menu-lista">
            <li><a href="${pageContext.request.contextPath}/clientes">👥 Hóspedes</a></li>
            <li><a href="${pageContext.request.contextPath}/reservas">📅 Reservas</a></li>
            <li><a href="${pageContext.request.contextPath}/quartos">🛏️ Quartos</a></li>
            <li><a href="${pageContext.request.contextPath}/hospedagens">🔑 Hospedagem</a></li>
            <li><a href="${pageContext.request.contextPath}/servicos">🍽️ Serviços</a></li>
            <li><a href="${pageContext.request.contextPath}/relatorios">📊 Relatórios</a></li>
        </ul>
    </div>

    <div class="conteudo-principal">
        <div class="container-fluid">
            <h1 class="display-5">Painel de Controle</h1>
            <p class="text-muted">Gerencie as operações do hotel abaixo.</p>
            <hr>

            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="p-5 bg-white border rounded shadow-sm">
                        <h3>Acesso Rápido</h3>
                        <p>Inicie um novo atendimento agora mesmo.</p>
                        <a href="${pageContext.request.contextPath}/hospedagens" class="btn btn-hotel mt-2">
                            Realizar Check-in
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>