
drop user salon_service cascade;

create user salon_service identified by passwd;
grant connect, resource to salon_service;

conn salon_service/passwd@localhost:1521/xe

------------------------------------------
-- Export file for user SALAO           --
-- Created by ds on 29/7/2015, 00:21:44 --
------------------------------------------

spool INSTALACAO.log

prompt
prompt Creating table CAIXA
prompt ====================
prompt
create table CAIXA
(
  CODIGO           NUMBER(10),
  USUARIO          VARCHAR2(30),
  VALOR_INICIAL    NUMBER(15,2),
  VALOR_FECHAMENTO NUMBER(15,2),
  VALOR_SISTEMA    NUMBER(15,2),
  DTHR_ABERTURA    DATE,
  DTHR_FECHAMENTO  DATE
)
;

prompt
prompt Creating table CONDICOES_PAGAMENTOS
prompt ===================================
prompt
create table CONDICOES_PAGAMENTOS
(
  CODIGO    NUMBER(10) not null,
  DESCRICAO VARCHAR2(40)
)
;
alter table CONDICOES_PAGAMENTOS
  add primary key (CODIGO);

prompt
prompt Creating table CONTAS
prompt =====================
prompt
create table CONTAS
(
  CODIGO         NUMBER(10) not null,
  DESCRICAO      VARCHAR2(200),
  AGENCIA        VARCHAR2(6),
  CONTA_CORRENTE VARCHAR2(10)
)
;
alter table CONTAS
  add primary key (CODIGO);

prompt
prompt Creating table GTT_ETIQUETAS
prompt ============================
prompt
create global temporary table GTT_ETIQUETAS
(
  DESCRICAO VARCHAR2(200),
  VALOR     VARCHAR2(10),
  CODIGO    NUMBER
)
on commit preserve rows;

prompt
prompt Creating table PESSOAS
prompt ======================
prompt
create table PESSOAS
(
  CODIGO      NUMBER(10) not null,
  TIPO_PESSOA CHAR(1) not null,
  NOME        VARCHAR2(100) not null,
  DATA_NASC   DATE,
  CPF_CNPJ    VARCHAR2(20),
  RG_INSC     VARCHAR2(20),
  ENDERECO    VARCHAR2(100),
  BAIRRO      VARCHAR2(30),
  CEP         VARCHAR2(10),
  TELEFONE    VARCHAR2(200),
  CELULAR     VARCHAR2(15),
  EMAIL       VARCHAR2(60),
  CIDADE      VARCHAR2(30),
  UF          CHAR(2)
)
;
alter table PESSOAS
  add primary key (CODIGO);

prompt
prompt Creating table PEDIDOS
prompt ======================
prompt
create table PEDIDOS
(
  CODIGO                      NUMBER(10) not null,
  CONDICOES_PAGAMENTOS_CODIGO NUMBER(10),
  PESSOAS_CODIGO              NUMBER(10) not null,
  DATA_PEDIDO                 DATE,
  NUMERO_DOCUMENTO            VARCHAR2(10),
  TIPO_PEDIDO                 CHAR(1),
  STATUS                      CHAR(1) default 'A'
)
;
alter table PEDIDOS
  add primary key (CODIGO);
alter table PEDIDOS
  add foreign key (CONDICOES_PAGAMENTOS_CODIGO)
  references CONDICOES_PAGAMENTOS (CODIGO);
alter table PEDIDOS
  add foreign key (PESSOAS_CODIGO)
  references PESSOAS (CODIGO);

prompt
prompt Creating table PRODUTOS
prompt =======================
prompt
create table PRODUTOS
(
  CODIGO              NUMBER(10) not null,
  DESCRICAO           VARCHAR2(100),
  PERCENTUAL_COMISSAO NUMBER(5,2),
  VALOR_COMPRA        NUMBER(15,2),
  VALOR_VENDA         NUMBER(15,2),
  QUANTIDADE_MINIMA   NUMBER(10),
  QUANTIDADE_ATUAL    NUMBER(10),
  CODIGO_DE_BARRAS    VARCHAR2(14),
  STATUS              VARCHAR2(1) default 'A'
)
;

prompt
prompt Creating sequence PRODUTOS_SEQ
prompt ==============================================
prompt
create sequence PRODUTOS_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;


alter table PRODUTOS
  add primary key (CODIGO);

prompt
prompt Creating table SERVICOS
prompt =======================
prompt
create table SERVICOS
(
  CODIGO    NUMBER(10) not null,
  DESCRICAO VARCHAR2(100),
  VALOR     NUMBER(15,2),
  STATUS    VARCHAR2(1) default 'A'
)
;
alter table SERVICOS
  add primary key (CODIGO);

prompt
prompt Creating table ITENS_PEDIDOS
prompt ============================
prompt
create table ITENS_PEDIDOS
(
  CODIGO           NUMBER(10) not null,
  PRODUTOS_CODIGO  NUMBER(10),
  PEDIDOS_CODIGO   NUMBER(10) not null,
  VALOR_UNITARIO   NUMBER(15,2),
  QUANTIDADE       NUMBER(3),
  DESCONTO         NUMBER(15,2),
  SERVICOS_CODIGO  NUMBER(10),
  ATENDENTE_CODIGO NUMBER(10),
  VALOR_COMISSAO   NUMBER(15,2)
)
;
alter table ITENS_PEDIDOS
  add primary key (CODIGO);
alter table ITENS_PEDIDOS
  add constraint FK_PESS_ATEND foreign key (ATENDENTE_CODIGO)
  references PESSOAS (CODIGO);
alter table ITENS_PEDIDOS
  add constraint FK_SERVICOS foreign key (SERVICOS_CODIGO)
  references SERVICOS (CODIGO);
alter table ITENS_PEDIDOS
  add foreign key (PRODUTOS_CODIGO)
  references PRODUTOS (CODIGO);
alter table ITENS_PEDIDOS
  add foreign key (PEDIDOS_CODIGO)
  references PEDIDOS (CODIGO);

prompt
prompt Creating table LOG_MOVIMENTACOES_FINANCEIRAS
prompt ============================================
prompt
create table LOG_MOVIMENTACOES_FINANCEIRAS
(
  CODIGO               NUMBER(10) not null,
  ITENS_PEDIDOS_CODIGO NUMBER(10),
  PEDIDOS_CODIGO       NUMBER(10),
  PESSOAS_CODIGO       NUMBER(10) not null,
  TIPO_MOVIMENTO       CHAR(1),
  NUMERO_DOCUMENTO     VARCHAR2(30),
  DESCRICAO            VARCHAR2(100),
  VALOR_DOCUMENTO      NUMBER(15,2),
  DATA_LANCAMENTO      DATE,
  DATA_VENCIMENTO      DATE,
  VALOR_PAGO           NUMBER(15,2),
  DATA_PAGAMENTO       DATE,
  OBSERVACAO           VARCHAR2(200),
  CONTA_MOVIMENTO      NUMBER(10),
  DTHR_MOVIMENTO       DATE default SYSDATE not null,
  USUARIO              VARCHAR2(100) default USER not null,
  OPERACAO             VARCHAR2(100) not null
)
;

prompt
prompt Creating table MOVIMENTACOES_FINANCEIRAS
prompt ========================================
prompt
create table MOVIMENTACOES_FINANCEIRAS
(
  CODIGO               NUMBER(10) not null,
  ITENS_PEDIDOS_CODIGO NUMBER(10),
  PEDIDOS_CODIGO       NUMBER(10),
  PESSOAS_CODIGO       NUMBER(10) not null,
  TIPO_MOVIMENTO       CHAR(1),
  NUMERO_DOCUMENTO     VARCHAR2(30),
  DESCRICAO            VARCHAR2(100),
  VALOR_DOCUMENTO      NUMBER(15,2),
  DATA_LANCAMENTO      DATE,
  DATA_VENCIMENTO      DATE,
  VALOR_PAGO           NUMBER(15,2),
  DATA_PAGAMENTO       DATE,
  OBSERVACAO           VARCHAR2(200),
  CONTA_MOVIMENTO      NUMBER(10)
)
;
alter table MOVIMENTACOES_FINANCEIRAS
  add primary key (CODIGO);
alter table MOVIMENTACOES_FINANCEIRAS
  add constraint FK_CONTA foreign key (CONTA_MOVIMENTO)
  references CONTAS (CODIGO);
alter table MOVIMENTACOES_FINANCEIRAS
  add foreign key (ITENS_PEDIDOS_CODIGO)
  references ITENS_PEDIDOS (CODIGO);
alter table MOVIMENTACOES_FINANCEIRAS
  add foreign key (PEDIDOS_CODIGO)
  references PEDIDOS (CODIGO);
alter table MOVIMENTACOES_FINANCEIRAS
  add foreign key (PESSOAS_CODIGO)
  references PESSOAS (CODIGO);

prompt
prompt Creating table PRAZOS_CONDICOES
prompt ===============================
prompt
create table PRAZOS_CONDICOES
(
  CODIGO                      NUMBER(10) not null,
  CONDICOES_PAGAMENTOS_CODIGO NUMBER(10) not null,
  DIA                         NUMBER(2),
  JUROS                       NUMBER(15,2)
)
;
alter table PRAZOS_CONDICOES
  add primary key (CODIGO);
alter table PRAZOS_CONDICOES
  add foreign key (CONDICOES_PAGAMENTOS_CODIGO)
  references CONDICOES_PAGAMENTOS (CODIGO);
create index PRAZOS_CONDICOES_FKINDEX1 on PRAZOS_CONDICOES (CONDICOES_PAGAMENTOS_CODIGO);

prompt
prompt Creating table PRODUTOS_PESSOAS
prompt ===============================
prompt
create table PRODUTOS_PESSOAS
(
  PRODUTOS_CODIGO   NUMBER(10) not null,
  PESSOAS_CODIGO    NUMBER(10) not null,
  VALOR             NUMBER(15,2),
  ULTIMA_COMPRA     DATE,
  CODIGO_FORNECEDOR VARCHAR2(20)
)
;
alter table PRODUTOS_PESSOAS
  add primary key (PRODUTOS_CODIGO, PESSOAS_CODIGO);
alter table PRODUTOS_PESSOAS
  add foreign key (PESSOAS_CODIGO)
  references PESSOAS (CODIGO);
alter table PRODUTOS_PESSOAS
  add foreign key (PRODUTOS_CODIGO)
  references PRODUTOS (CODIGO);

prompt
prompt Creating table RENTABILIDADE_PROD_SERV
prompt ======================================
prompt
create table RENTABILIDADE_PROD_SERV
(
  PRODUTO_CODIGO     NUMBER(10),
  SERVICO_CODIGO     NUMBER(10),
  DATA_INICIAL       DATE,
  DATA_FINAL         DATE,
  QUANTIDADE_SERVICO NUMBER
)
;

prompt
prompt Creating table SERVICOS_PESSOAS
prompt ===============================
prompt
create table SERVICOS_PESSOAS
(
  SERVICOS_CODIGO NUMBER(10) not null,
  PESSOAS_CODIGO  NUMBER(10) not null,
  PERCENTUAL      NUMBER(5,2),
  VALOR           NUMBER(15,2)
)
;
alter table SERVICOS_PESSOAS
  add primary key (SERVICOS_CODIGO, PESSOAS_CODIGO);
alter table SERVICOS_PESSOAS
  add constraint FK_PESSOAS_01 foreign key (PESSOAS_CODIGO)
  references PESSOAS (CODIGO);
alter table SERVICOS_PESSOAS
  add constraint FK_SERVICOS_01 foreign key (SERVICOS_CODIGO)
  references SERVICOS (CODIGO);

prompt
prompt Creating table SERVICOS_PESSOAS_ITENS_PEDIDOS
prompt =============================================
prompt
create table SERVICOS_PESSOAS_ITENS_PEDIDOS
(
  SERVICOS_PESSOAS     NUMBER(10) not null,
  ITENS_PEDIDOS_CODIGO NUMBER(10) not null,
  SERVICOS_CODIGO      NUMBER(10) not null,
  VALOR                NUMBER(15,2)
)
;
alter table SERVICOS_PESSOAS_ITENS_PEDIDOS
  add primary key (SERVICOS_PESSOAS, ITENS_PEDIDOS_CODIGO, SERVICOS_CODIGO);
alter table SERVICOS_PESSOAS_ITENS_PEDIDOS
  add constraint FK_ITPD_PESS foreign key (ITENS_PEDIDOS_CODIGO)
  references ITENS_PEDIDOS (CODIGO);
alter table SERVICOS_PESSOAS_ITENS_PEDIDOS
  add constraint FK_SERVICO_PESSOAS foreign key (SERVICOS_CODIGO, SERVICOS_PESSOAS)
  references SERVICOS_PESSOAS (SERVICOS_CODIGO, PESSOAS_CODIGO);

prompt
prompt Creating table SERVICOS_PRODUTOS
prompt ================================
prompt
create table SERVICOS_PRODUTOS
(
  SERVICOS_CODIGO NUMBER(10) not null,
  PRODUTOS_CODIGO NUMBER(10) not null
)
;
alter table SERVICOS_PRODUTOS
  add primary key (SERVICOS_CODIGO, PRODUTOS_CODIGO);
alter table SERVICOS_PRODUTOS
  add constraint FK_PROD foreign key (PRODUTOS_CODIGO)
  references PRODUTOS (CODIGO);
alter table SERVICOS_PRODUTOS
  add constraint FK_SERV foreign key (SERVICOS_CODIGO)
  references SERVICOS (CODIGO);

prompt
prompt Creating sequence MOVIMENTACOES_FINANCEIRAS_SQ
prompt ==============================================
prompt
create sequence MOVIMENTACOES_FINANCEIRAS_SQ
minvalue 1
maxvalue 999999999999999999999999999
start with 28321
increment by 1
cache 20;

prompt
prompt Creating function FNC_CODIGO_FORNECEDOR
prompt =======================================
prompt
create or replace function fnc_codigo_fornecedor(p_codigo_pessoa number, p_codigo_produto number) return varchar2 is
  cursor c_prod is
   select pp.Codigo_Fornecedor
    from Produtos_Pessoas pp
    where pp.Produtos_Codigo = p_codigo_produto
      and pp.Pessoas_Codigo = p_codigo_pessoa;
   --
   rc_prod   c_prod%rowtype;
begin
  open c_prod;
  fetch c_prod into rc_prod;
  close c_prod;
  --
  return nvl(rc_prod.Codigo_Fornecedor,to_char(p_codigo_produto));
end;
/

prompt
prompt Creating procedure PRC_MOVIMENTACAO_FINANCEIRA
prompt ==============================================
prompt
create or replace procedure prc_movimentacao_financeira(p_conta_movimento      movimentacoes_financeiras.conta_movimento%type,
                                                        p_tipo_movimento       movimentacoes_financeiras.tipo_movimento%type,
                                                        p_pessoas_codigo       movimentacoes_financeiras.pessoas_codigo%type,
                                                        p_numero_documento     movimentacoes_financeiras.numero_documento%type,
                                                        p_valor_documento      movimentacoes_financeiras.valor_documento%type,
                                                        p_data_vencimento      movimentacoes_financeiras.data_vencimento%type,
                                                        p_condicoes_pagamento  number default null,
                                                        p_itens_pedidos_codigo number default null,
                                                        p_pedidos_codigo       number default null,
                                                        p_descricao            varchar2 default null) is

  cursor c_prazos is
    select pr.dia, pr.juros
      from prazos_condicoes pr
     where pr.condicoes_pagamentos_codigo = p_condicoes_pagamento;
  --
  cursor c_parcelas is
    select count(*) parcelas
      from prazos_condicoes pr
     where pr.condicoes_pagamentos_codigo = p_condicoes_pagamento;
  --
  rc_parcelas c_parcelas%rowtype;
  --
  v_parc number := 0;
  --
  procedure prc_cria_movimento(p_juros    number default null,
                               p_dias     number default 0,
                               p_parcelas number default 1) is
  begin
    insert into movimentacoes_financeiras
      (conta_movimento,
       tipo_movimento,
       pessoas_codigo,
       numero_documento,
       itens_pedidos_codigo,
       pedidos_codigo,
       valor_documento,
       data_vencimento,
       data_lancamento,
       descricao)
    values
      (p_conta_movimento,
       p_tipo_movimento,
       p_pessoas_codigo,
       lpad(p_numero_documento, 5, '0') || '/' || v_parc,
       p_itens_pedidos_codigo,
       p_pedidos_codigo,
       (((nvl(p_juros, 0) / 100) * p_valor_documento) + p_valor_documento) /
       p_parcelas,
       sysdate + p_dias,
       sysdate,
       nvl(p_descricao,
           'Registro referente a solicitação' || p_numero_documento));
  end;
begin
  if p_condicoes_pagamento is not null then
    for reg in c_prazos loop
      --
      open c_parcelas;
      fetch c_parcelas
        into rc_parcelas;
      close c_parcelas;
      --
      v_parc := v_parc + 1;
      --
      prc_cria_movimento(reg.juros, reg.dia, rc_parcelas.parcelas);

    end loop;
  else
    prc_cria_movimento;
  end if;
end;
/

prompt
prompt Creating trigger TRG_BI_MOV_FINANCEIRAS
prompt =======================================
prompt
Create Or Replace Trigger trg_bi_Mov_Financeiras Before Insert
On Movimentacoes_Financeiras For Each Row
Begin
  Select Movimentacoes_Financeiras_SQ.Nextval Into   :New.codigo  From dual;
End;
/

prompt
prompt Creating trigger TRG_MOV_FINC_LOG
prompt =================================
prompt
create or replace trigger trg_mov_finc_log
  after insert or update or delete on movimentacoes_financeiras
  FOR EACH ROW

begin
  if inserting then
    insert into log_movimentacoes_financeiras
      (codigo,
       itens_pedidos_codigo,
       pedidos_codigo,
       pessoas_codigo,
       tipo_movimento,
       numero_documento,
       descricao,
       valor_documento,
       data_lancamento,
       data_vencimento,
       valor_pago,
       data_pagamento,
       observacao,
       conta_movimento,
       operacao)
    values
      ( :new.codigo,
        :new.itens_pedidos_codigo,
        :new.pedidos_codigo,
        :new.pessoas_codigo,
        :new.tipo_movimento,
        :new.numero_documento,
        :new.descricao,
        :new.valor_documento,
        :new.data_lancamento,
        :new.data_vencimento,
        :new.valor_pago,
        :new.data_pagamento,
        :new.observacao,
        :new.conta_movimento,
       'NOVO REGISTRO');
  elsif updating then
    insert into log_movimentacoes_financeiras
      (codigo,
       itens_pedidos_codigo,
       pedidos_codigo,
       pessoas_codigo,
       tipo_movimento,
       numero_documento,
       descricao,
       valor_documento,
       data_lancamento,
       data_vencimento,
       valor_pago,
       data_pagamento,
       observacao,
       conta_movimento,
       operacao)
    values
      ( :new.codigo,
        :new.itens_pedidos_codigo,
        :new.pedidos_codigo,
        :new.pessoas_codigo,
        :new.tipo_movimento,
        :new.numero_documento,
        :new.descricao,
        :new.valor_documento,
        :new.data_lancamento,
        :new.data_vencimento,
        :new.valor_pago,
        :new.data_pagamento,
        :new.observacao,
        :new.conta_movimento,
       'ALTERANDO');
  else
    insert into log_movimentacoes_financeiras
      (codigo,
       itens_pedidos_codigo,
       pedidos_codigo,
       pessoas_codigo,
       tipo_movimento,
       numero_documento,
       descricao,
       valor_documento,
       data_lancamento,
       data_vencimento,
       valor_pago,
       data_pagamento,
       observacao,
       conta_movimento,
       operacao)
    values
      ( :old.codigo,
        :old.itens_pedidos_codigo,
        :old.pedidos_codigo,
        :old.pessoas_codigo,
        :old.tipo_movimento,
        :old.numero_documento,
        :old.descricao,
        :old.valor_documento,
        :old.data_lancamento,
        :old.data_vencimento,
        :old.valor_pago,
        :old.data_pagamento,
        :old.observacao,
        :old.conta_movimento,
       'EXCLUINDO');
  end if;
end;
/


spool off