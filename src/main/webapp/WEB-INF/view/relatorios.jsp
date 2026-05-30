<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relatórios</title>
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
            <li><a href="${pageContext.request.contextPath}/hospedagens">🔑 Hospedagem</a></li>
            <li><a href="${pageContext.request.contextPath}/servicos">🍽️ Serviços</a></li>
            <li><a href="${pageContext.request.contextPath}/">🏠 Home</a></li>
        </ul>
    </div>

    <div class="conteudo-principal">
        <div class="container">
            <h1>Relatórios</h1>
            <p class="text-muted">Selecione o relatório que deseja gerar (Formato PDF).</p>
            <hr>

            <div class="row g-4">

                <!-- Relatório 1: Quartos disponíveis por data -->
                <div class="col-md-6">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title">Quartos Disponíveis</h5>
                            <p class="card-text small">Lista quartos disponíveis com tipo e valor para uma data específica.</p>
                            <%-- method POST conforme o professor, target _blank abre em nova aba --%>
                            <form action="${pageContext.request.contextPath}/relatorio/quartos"
                                  method="post" target="_blank" class="d-flex gap-2">
                                <input type="date" name="data" class="form-control form-control-sm" required>
                                <button type="submit" class="btn-hotel btn-sm">Gerar</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Relatório 2: Extrato do cliente -->
                <div class="col-md-6">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title">Extrato de Consumo</h5>
                            <p class="card-text small">Dados do cliente, hospedagem e total de serviços consumidos.</p>
                            <form action="${pageContext.request.contextPath}/relatorio/consumo"
                                  method="post" target="_blank" class="d-flex gap-2">
                                <input type="text" name="cpf" class="form-control form-control-sm"
                                       placeholder="CPF do Hóspede" required>
                                <button type="submit" class="btn-hotel btn-sm">Gerar</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Relatório 3: Reservas do dia -->
                <div class="col-md-6">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title">Reservas do Dia</h5>
                            <p class="card-text small">Lista clientes, quartos, tipo e valor de todas as reservas de uma data.</p>
                            <form action="${pageContext.request.contextPath}/relatorio/reservas"
                                  method="post" target="_blank" class="d-flex gap-2">
                                <input type="date" name="data" class="form-control form-control-sm" required>
                                <button type="submit" class="btn-hotel btn-sm">Gerar</button>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
