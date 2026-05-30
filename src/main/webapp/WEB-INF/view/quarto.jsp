<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<title>Quartos</title>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-titulo">GESTÃO DO HOTEL</div>
        <ul class="menu-lista">
            <li><a href="${pageContext.request.contextPath}/clientes">👥 Hóspedes</a></li>
            <li><a href="${pageContext.request.contextPath}/">🏠 Home</a></li>
            <li><a href="${pageContext.request.contextPath}/reservas">📅 Reservas</a></li>
            <li><a href="${pageContext.request.contextPath}/hospedagens">🔑 Hospedagem</a></li>
            <li><a href="${pageContext.request.contextPath}/servicos">🍽️ Serviços</a></li>
            <li><a href="${pageContext.request.contextPath}/relatorios">📊 Relatórios</a></li>
        </ul>
    </div>

    <div class="conteudo-principal">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1>Gestão de Quartos</h1>
                <form action="${pageContext.request.contextPath}/quartos/disponibilidade" method="get" class="d-flex gap-2">
                    <input type="date" name="data" class="form-control" required>
                    <input type="number" name="dias" placeholder="Dias" class="form-control" style="width: 80px;" required>
                    <button type="submit" class="btn-hotel">Pesquisar</button>
                </form>
            </div>

            <div class="d-flex gap-3 mb-3">
                <span class="badge bg-success fs-6">🟢 Livre</span>
                <span class="badge bg-danger fs-6">🔴 Ocupado</span>
                <span class="badge bg-warning text-dark fs-6">🟡 Reservado</span>
            </div>
            <hr>

            <div class="row row-cols-1 row-cols-md-4 g-4">
                <c:forEach var="q" items="${quartos}">

                    <c:set var="ocupado"   value="${ocupados.contains(q.num)}"/>
                    <c:set var="reservado" value="${reservados.contains(q.num)}"/>

                    <%-- Busca o CPF do hóspede que está no quarto (se ocupado) --%>
                    <c:set var="cpfHospede" value=""/>
                    <c:set var="idHospedagem" value=""/>
                    <c:forEach var="h" items="${hospedagens}">
                        <c:if test="${h.quarto.num == q.num and h.status}">
                            <c:set var="cpfHospede" value="${h.cliente.cpf}"/>
                            <c:set var="idHospedagem" value="${h.id}"/>
                        </c:if>
                    </c:forEach>

                    <%-- Busca o CPF do cliente que tem reserva no quarto --%>
                    <c:set var="cpfReserva" value=""/>
                    <c:forEach var="r" items="${reservas}">
                        <c:if test="${r.quarto.num == q.num}">
                            <c:set var="cpfReserva" value="${r.cliente.cpf}"/>
                        </c:if>
                    </c:forEach>

                    <div class="col">
                        <div class="card h-100 shadow-sm border-0">

                            <c:choose>
                                <c:when test="${ocupado}">
                                    <div class="card-header text-white text-center" style="background-color: #dc3545;">
                                        🔴 Quarto ${q.num} — Ocupado
                                    </div>
                                </c:when>
                                <c:when test="${reservado}">
                                    <div class="card-header text-dark text-center" style="background-color: #ffc107;">
                                        🟡 Quarto ${q.num} — Reservado
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="card-header text-white text-center" style="background-color: #198754;">
                                        🟢 Quarto ${q.num} — Livre
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="card-body text-center">
                                <p class="mb-1"><strong>Andar:</strong> ${q.andar}º</p>
                                <p class="small text-muted">${q.descricao}</p>
                                <span class="badge bg-info text-dark">${q.tipo.nome}</span>
                                <p class="mt-2 fw-bold text-success">
                                    R$ <c:out value="${String.format('%.2f', q.tipo.precoDiaria)}"/> /diária
                                </p>
                            </div>

                            <div class="card-footer bg-light d-flex justify-content-center gap-2">
                                <c:choose>
                                    <c:when test="${ocupado}">
                                        <%-- Checkout: passa o id da hospedagem direto --%>
                                        <form action="${pageContext.request.contextPath}/hospedagem/checkout"
                                              method="post">
                                            <input type="hidden" name="id" value="${idHospedagem}">
                                            <button type="submit" class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Confirmar checkout do quarto ${q.num}?')">
                                                Fazer Check-out
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${reservado}">
                                        <%-- Check-in com reserva: passa cpf e quarto na URL --%>
                                        <a href="${pageContext.request.contextPath}/hospedagens?cpf=${cpfReserva}&quarto=${q.num}"
                                           class="btn btn-sm btn-warning text-dark">
                                            Confirmar Check-in
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- Check-in livre: passa só o número do quarto --%>
                                        <a href="${pageContext.request.contextPath}/hospedagens?quarto=${q.num}"
                                           class="btn btn-sm btn-success">
                                            Fazer Check-in
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>
