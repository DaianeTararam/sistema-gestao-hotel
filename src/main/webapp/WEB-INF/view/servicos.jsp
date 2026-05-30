<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Serviços</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-titulo">GESTÃO DO HOTEL</div>
        <ul class="menu-lista">
            <li><a href="${pageContext.request.contextPath}/clientes">👥 Hóspedes</a></li>
            <li><a href="${pageContext.request.contextPath}/reservas">📅 Reservas</a></li>
            <li><a href="${pageContext.request.contextPath}/quartos">🛏️ Quartos</a></li>
            <li><a href="${pageContext.request.contextPath}/hospedagens">🔑 Hospedagems</a></li>
            <li><a href="${pageContext.request.contextPath}/">🏠 Home</a></li>
            <li><a href="${pageContext.request.contextPath}/relatorios">📊 Relatórios</a></li>
        </ul>
    </div>

    <div class="conteudo-principal">
        <div class="container">
            <h2>Serviços do Hotel</h2>
            <hr>

            <%-- Formulário de cadastro --%>
            <form action="${pageContext.request.contextPath}/servico/salvar" method="post" class="row g-3 mb-5">
                <div class="col-md-6">
                    <label class="form-label">Nome do Serviço</label>
                    <input type="text" name="nome" class="form-control" placeholder="Ex: Jantar Executivo, Lavanderia..." required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Descrição</label>
                    <input type="text" name="descricao" class="form-control" placeholder="Breve descrição...">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Preço (R$)</label>
                    <input type="number" step="0.01" name="valor" class="form-control" required>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn-hotel">Salvar Serviço</button>
                </div>
            </form>

            <%-- Lista de serviços cadastrados --%>
            <h5>Serviços Cadastrados</h5>
            <table class="table table-hover mt-2">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Nome</th>
                        <th>Descrição</th>
                        <th>Valor</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty servicos}">
                            <tr>
                                <td colspan="4" class="text-center text-muted">Nenhum serviço cadastrado.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="s" items="${servicos}">
                                <tr>
                                    <td>${s.id}</td>
                                    <td>${s.nome}</td>
                                    <td>${s.descricao}</td>
                                    <td class="fw-bold text-success">R$ <c:out value="${String.format('%.2f', s.valor)}"/></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

        </div>
    </div>
</body>
</html>
