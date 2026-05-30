<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservas</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-titulo">GESTÃO DO HOTEL</div>
        <ul class="menu-lista">
            <li><a href="${pageContext.request.contextPath}/clientes">👥 Hóspedes</a></li>
            <li><a href="${pageContext.request.contextPath}/">🏠 Home</a></li>
            <li><a href="${pageContext.request.contextPath}/quartos">🛏️ Quartos</a></li>
            <li><a href="${pageContext.request.contextPath}/hospedagens">🔑 Hospedagem</a></li>
            <li><a href="${pageContext.request.contextPath}/servicos">🍽️ Serviços</a></li>
            <li><a href="${pageContext.request.contextPath}/relatorios">📊 Relatórios</a></li>
        </ul>
    </div>

    <div class="conteudo-principal">
        <div class="container">
            <h2>Reservas</h2>
            <hr>

            <%-- Formulário de nova reserva --%>
            <h5>Nova Reserva</h5>
            <form action="${pageContext.request.contextPath}/reserva/salvar" method="post" class="row g-3 mb-5">

                <div class="col-md-4">
                    <label class="form-label">Hóspede</label>
                    <select name="cliente.cpf" class="form-select" required>
                        <option value="">Selecione o hóspede...</option>
                        <c:forEach var="c" items="${clientes}">
                            <option value="${c.cpf}">${c.nome} — ${c.cpf}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Quarto</label>
                    <select name="quarto.num" class="form-select" required>
                        <option value="">Selecione o quarto...</option>
                        <c:forEach var="q" items="${quartos}">
                            <option value="${q.num}">Quarto ${q.num} — ${q.tipo.nome}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Data de Início</label>
                    <input type="date" name="dataInicio" class="form-control" required>
                </div>

                <div class="col-md-2">
                    <label class="form-label">Quantidade de Dias</label>
                    <input type="number" name="qtdeDias" class="form-control" min="1" required>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn-hotel">Confirmar Reserva</button>
                </div>
            </form>

            <%-- Lista de reservas --%>
            <h5>Reservas Cadastradas</h5>
            <table class="table table-hover mt-2">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Hóspede</th>
                        <th>Quarto</th>
                        <th>Tipo</th>
                        <th>Data Início</th>
                        <th>Dias</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty reservas}">
                            <tr>
                                <td colspan="7" class="text-center text-muted">Nenhuma reserva cadastrada.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="r" items="${reservas}">
                                <tr>
                                    <td>${r.id}</td>
                                    <td>${r.cliente.nome}</td>
                                    <td>Quarto ${r.quarto.num} — ${r.quarto.andar}º andar</td>
                                    <td>${r.quarto.tipo.nome}</td>
                                    <td>${r.dtInicioFormatada}</td>
                                    <td>${r.qtdeDias} dia(s)</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/reserva/excluir/${r.id}"
                                           class="text-danger"
                                           onclick="return confirm('Deseja cancelar a reserva de ${r.cliente.nome}?')">
                                            Cancelar
                                        </a>
                                    </td>
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
