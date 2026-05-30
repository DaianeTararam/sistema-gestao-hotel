<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospedagens</title>
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
            <li><a href="${pageContext.request.contextPath}/">🏠 Home</a></li>
            <li><a href="${pageContext.request.contextPath}/servicos">🍽️ Serviços</a></li>
            <li><a href="${pageContext.request.contextPath}/relatorios">📊 Relatórios</a></li>
        </ul>
    </div>

    <div class="conteudo-principal">
        <div class="container">

            <%-- Formulário de Check-in --%>
            <h2>Realizar Check-in</h2>
            <hr>
            <form action="${pageContext.request.contextPath}/hospedagem/checkin" method="post" class="row g-3 mb-5">
                <div class="col-md-4">
                    <label class="form-label">Hóspede</label>
                    <select name="cpf_cli" class="form-select" required>
                        <option value="">Selecione o hóspede...</option>
                        <c:forEach var="c" items="${clientes}">
                            <option value="${c.cpf}">${c.nome} — ${c.cpf}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Quarto</label>
                    <select name="n_quarto" class="form-select" required>
                        <option value="">Selecione o quarto...</option>
                        <c:forEach var="q" items="${quartos}">
                            <%-- Se veio um quarto pré-selecionado, ele deixa marcado automaticamente --%>
                            <option value="${q.num}" ${q.num == quartoParam ? 'selected' : ''}>
                                Quarto ${q.num} — ${q.tipo.nome}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Previsão de Saída</label>
                    <input type="date" name="saida" class="form-control" required>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn-hotel">Confirmar Entrada</button>
                    <a href="${pageContext.request.contextPath}/quartos" class="btn btn-secondary ms-2">Cancelar</a>
                </div>
            </form>

            <h5>Estadias em Andamento</h5>
            <table class="table table-hover mt-2">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>CPF</th>
                        <th>Hóspede</th>
                        <th>Quarto</th>
                        <th>Entrada</th>
                        <th>Saída Prevista</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty hospedagens}">
                            <tr>
                                <td colspan="6" class="text-center text-muted">Nenhuma estadia em andamento.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="h" items="${hospedagens}">
                                <c:if test="${h.status}">
                                    <tr>
                                        <td>${h.id}</td>
                                        <td>${h.cliente.cpf}</td>
                                        <td>${h.cliente.nome}</td>
                                        <td>Quarto ${h.quarto.num} — ${h.quarto.andar}º andar</td>
                                        <td>${h.dtEntradaFormatada}</td>
                                        <td>${h.dtSaidaFormatada}</td>
                                        <td>
											<form action="${pageContext.request.contextPath}/consumo/registrar" 
												  method="post" class="d-flex gap-1" style="max-width: 250px;">
    											  <input type="hidden" name="hospedagem.id" value="${h.id}"> 
											    	    <select name="servico.id" class="form-select form-select-sm" required>
												        <option value="">Adicione um Serviço</option>
												        <c:forEach var="s" items="${listaServicos}">
												            <option value="${s.id}">${s.nome} - R$ ${String.format('%.2f', s.valor)}</option>
												        </c:forEach>
												    </select>
											    <button type="submit" class="btn btn-sm btn-success">Add</button>
											</form>
                                            <form action="${pageContext.request.contextPath}/hospedagem/checkout"
                                                  method="post" style="display:inline">
                                                <input type="hidden" name="id" value="${h.id}">
                                                <button type="submit" class="btn btn-sm btn-danger"
                                                        onclick="return confirm('Confirmar checkout de ${h.cliente.nome}?')">
                                                    Fazer Check-out
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

        </div>
    </div>
</body>
</html>
