create database db_Hotel
go
use db_Hotel
go
create user usuario for login usuario
go
alter role db_owner add member usuario
go
create function fn_quartos_disponiveis(@data_inicio date, @qtde_dias int)
returns @tab_livres table(
num int,
andar int,
descricao varchar(100),
preco_diaria decimal(7,2)
)
as 
begin
	declare @num int, @andar int, @descricao varchar(100), @id_tipo_quarto int,
			@preco_diaria decimal(7,2), @data_fim date, @c_reservas int, @c_hospedagens int
	set @data_fim = dateadd(day, @qtde_dias, @data_inicio)
	declare cursor_quartos cursor for
		select q.num, q.andar, q.descricao, q.id_tipo, t.preco_diaria
		from quarto q
		inner join tipo_quarto t
		on q.id_tipo = t.id
	open cursor_quartos
	fetch next from cursor_quartos into @num, @andar, @descricao, @id_tipo_quarto, @preco_diaria
	while @@fetch_status = 0
	begin
	-- utilizei o count para checar se o quarto esta ocupado
		select @c_reservas = count(*) from reserva
		where 
			num_quarto = @num and ((@data_inicio between data_inicio and dateadd(day, qtde_dias, data_inicio)) or
								   (@data_fim between data_inicio and dateadd(day, qtde_dias, data_inicio)))
		select @c_hospedagens = count(*) from hospedagem
		where
			num_quarto = @num and status = 1 and ((@data_inicio between data_entrada and data_saida) or
												 (@data_fim between data_entrada and data_saida))
		if (@c_reservas = 0 and @c_hospedagens = 0)
		begin 
			insert into @tab_livres values
			(@num, @andar, @descricao, @preco_diaria)
		end
		fetch next from cursor_quartos into @num, @andar, @descricao, @id_tipo_quarto, @preco_diaria			
	end
	close cursor_quartos
	deallocate cursor_quartos
	return
end
go
create procedure sp_fazer_reserva (
@cpf varchar(11),
@num_quarto int,
@data_inicio date,
@qtde_dias int
)
as
begin
    -- verificação simples: o cliente existe?
    if exists (select 1 from cliente where cpf = @cpf)
    begin
        insert into reserva (data_inicio, qtde_dias, cpf_cliente, num_quarto)
        values (@data_inicio, @qtde_dias, @cpf, @num_quarto)
        print 'Reserva efetuada com sucesso!'
    end
    else
    begin
        raiserror('Erro: Cliente não cadastrado.', 16, 1)
    end
end
go
create procedure sp_fazer_checkin (
@cpf_cli    varchar(11),
@n_quarto   int,
@d_saida    date
)
as
begin
    -- registra a entrada na tabela hospedagem
    insert into hospedagem (data_entrada, data_saida, status, cpf_cliente, num_quarto)
    values (getdate(), @d_saida, 1, @cpf_cli, @n_quarto)
    -- 2. remove a reserva anterior para esse cliente e quarto
    delete from reserva 
    where cpf_cliente = @cpf_cli 
    and num_quarto = @n_quarto
    print 'Check-in realizado com sucesso!'
end
go
create procedure sp_fazer_checkout (
@id_hospedagem int
)
as
begin
    -- checa se a hospedagem existe e está ativa
    if exists (select 1 from hospedagem where id = @id_hospedagem and status = 1)
    begin
        update hospedagem 
        set status = 0, 
            data_saida = getdate() 
        where id = @id_hospedagem
        print 'Check-out realizado com sucesso! Quarto liberado.'
    end
    else
    begin
        print 'Erro: Hospedagem não encontrada ou já finalizada.'
    end
end

select * from tipo_quarto
select * from quarto

SELECT * FROM hospedagem
SELECT * FROM reserva  
SELECT * FROM consumo_servico

SELECT * from servico
