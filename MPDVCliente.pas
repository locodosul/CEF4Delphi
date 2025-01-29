unit MPDVCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, DB, Mask, ExtCtrls, DBCtrls,
  SCProcedure2;

type
  TFMPDVCliente = class(TForm)
    DBGridCliente: TDBGrid;
    LabelNome: TLabel;
    EditNome: TEdit;
    GroupBoxIncluirRes: TGroupBox;
    LabelNomeRes: TLabel;
    LabelTelefoneRes: TLabel;
    EditNomeRes: TEdit;
    MaskEditTelefoneRes: TMaskEdit;
    BitBtnIncluir: TBitBtn;
    GroupBoxIncluirCom: TGroupBox;
    LabelNomeCom: TLabel;
    LabelTelefoneCom1: TLabel;
    LabelRazao: TLabel;
    LabelEmailCom: TLabel;
    LabelEndereco: TLabel;
    LabelNumero: TLabel;
    LabelComplemento: TLabel;
    LabelBairro: TLabel;
    LabelCidade: TLabel;
    LabelUF: TLabel;
    LabelCEP: TLabel;
    GroupBoxJuridica: TGroupBox;
    LabelCNPJ: TLabel;
    MaskEditCNPJ: TMaskEdit;
    GroupBoxFisica: TGroupBox;
    LabelCPF: TLabel;
    LabelRG: TLabel;
    LabelOrgao: TLabel;
    LabelExpedicao: TLabel;
    LabelPai: TLabel;
    LabelMae: TLabel;
    LabelNascimentoCom: TLabel;
    RadioGroupSexo: TRadioGroup;
    EditOrgao: TEdit;
    EditPai: TEdit;
    EditMae: TEdit;
    MaskEditExpedicao: TMaskEdit;
    MaskEditNascimentoCom: TMaskEdit;
    MaskEditCPF: TMaskEdit;
    EditRG: TEdit;
    EditNomeCom: TEdit;
    RadioGroupEspecie: TRadioGroup;
    EditRazao: TEdit;
    EditEmailCom: TEdit;
    EditLogradouro: TEdit;
    EditNumero: TEdit;
    EditComplemento: TEdit;
    EditBairro: TEdit;
    EditCidade: TEdit;
    EditUF: TEdit;
    MaskEditCEP: TMaskEdit;
    EditTipoLogradouro: TEdit;
    MaskEditTelefoneCom1: TMaskEdit;
    MaskEditTelefoneCom2: TMaskEdit;
    LabelTelefoneCom2: TLabel;
    BitBtnCEP: TBitBtn;
    LabelTam: TLabel;
    EditTam: TEdit;
    CheckBoxGlobal: TCheckBox;
    LabelEmailRes: TLabel;
    EditEmailRes: TEdit;
    LabelNascimentoRes: TLabel;
    MaskEditNascimentoRes: TMaskEdit;
    LabelBairroRes: TLabel;
    EditBairroRes: TEdit;
    LabelCidadeRes: TLabel;
    EditCidadeRes: TEdit;
    LabelCartaoRes: TLabel;
    EditCartaoRes: TEdit;
    DBEditCodigo: TDBEdit;
    LabelAdicional1: TLabel;
    LabelAdicional2: TLabel;
    LabelAdicional3: TLabel;
    BitBtnConfirmaDados: TBitBtn;
    BitBtnEditar: TBitBtn;
    LabelOper1: TLabel;
    EditOper1: TEdit;
    LabelOper2: TLabel;
    EditOper2: TEdit;
    ComboBoxProf: TComboBox;
    LabelFidelCartao: TLabel;
    EditFidelCartao: TEdit;
    LabelFidelPontos: TLabel;
    EditFidelPontos: TEdit;
    BitBtnConsultaCPF: TBitBtn;
    MaskEditCPFRes: TMaskEdit;
    Label1: TLabel;
    GroupBoxFilho: TGroupBox;
    Label2: TLabel;
    EditFilho: TEdit;
    Label3: TLabel;
    MaskEditNascFilho: TMaskEdit;
    LabelIndicado: TLabel;
    ComboBoxIndicado: TComboBox;
    MemoCPF: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditNomeChange(Sender: TObject);
    procedure EditNomeKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridClienteDblClick(Sender: TObject);
    procedure RadioGroupEspecieExit(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure BitBtnCEPClick(Sender: TObject);
    procedure MaskEditTelefoneCom1Exit(Sender: TObject);
    procedure EditEmailComKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxGlobalClick(Sender: TObject);
    procedure EditComplementoExit(Sender: TObject);
    procedure EditNomeResExit(Sender: TObject);
    procedure AtivaSQLCliente;
    procedure DBEditCodigoChange(Sender: TObject);
    procedure EditNomeEnter(Sender: TObject);
    procedure MaskEditCPFExit(Sender: TObject);
    procedure EditEmailComExit(Sender: TObject);
    procedure BitBtnConfirmaDadosClick(Sender: TObject);
    procedure GroupBoxIncluirComExit(Sender: TObject);
    procedure BitBtnEditarClick(Sender: TObject);
    procedure BitBtnConsultaCPFClick(Sender: TObject);
    function ValoresChaveJSonArray(StJSon, StChave: String): TStringList;
    procedure Button1Click(Sender: TObject);
    function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
    StCodigoCliente,StNomeCliente,StPlaca: String;
    BoIncluirAutomatico,BoClienteObrigatorio: Boolean;
  end;

var
  FMPDVCliente: TFMPDVCliente;
  BoChamouGuiaCEP: Boolean = False;
  BoAlterarDados,BoConfirmouAlt: Boolean;
  StEndSequencia,StFoneAnt1,StFoneAnt2,StEndAnterior: String;

implementation

{$R *.dfm}

uses SCDMCad, SCDMSql, SCMenuPrincipal, SCProcedure, SCDMFun, SCDMMov, MPDVClienteEnd, SCCPF;

{CRIA O FORMULÁRIO}
procedure TFMPDVCliente.FormCreate(Sender: TObject);
begin
  BoIncluirAutomatico:=False;
  BoClienteObrigatorio:=False;
end;

{ATIVA O FORMULÁRIO}
procedure TFMPDVCliente.FormActivate(Sender: TObject);
var InC: Integer;
begin
  BoAlterarDados:=False; BoConfirmouAlt:=False;

  {Verifica se Está Minimizado}
  if (Self as TForm).WindowState=wsMinimized then (Self as TForm).WindowState:=wsNormal;

  {Altera a Cor do Formulário}
  (Self as TForm).Color:=FSCMenuPrincipal.CoCorMovimentos1;

  {Abre e Posiciona os Clientes}
  AtivaSQL(DMSql.QuGeralCli,'');
  DMSql.QuGeralCli.First;

  {Mostra os Dados da Consulta}
  LabelNome.Visible:=True;
  EditNome.Visible:=True;
  DBGridCliente.Visible:=True;
  GroupBoxIncluirRes.Visible:=False;
  GroupBoxIncluirCom.Visible:=False;
  GroupBoxFilho.Visible:=False;

  {Limpa os Campos}
  for InC:=0 to FMPDVCliente.ComponentCount-1 do
    if (FMPDVCliente.Components[InC] is TEdit) then
      (FMPDVCliente.Components[InC] as TEdit).Clear
    else if (FMPDVCliente.Components[InC] is TMaskEdit) then
      (FMPDVCliente.Components[InC] as TMaskEdit).Clear;
  RadioGroupEspecie.ItemIndex:=0;
  RadioGroupSexo.ItemIndex:=0;
  RadioGroupEspecieExit(Sender);

  {Para a Pérola não passa pelos campos abaixo}
  if FSCMenuPrincipal.InPARA_REGISTRO=4030050 then
  begin
    RadioGroupEspecie.Enabled:=False;
    EditRazao.TabStop:=False;
    MaskEditCPF.TabStop:=False;
    EditRg.TabStop:=False;
    EditPai.TabStop:=False;
    EditMae.TabStop:=False;
    EditOrgao.TabStop:=False;
    MaskEditExpedicao.TabStop:=False;
  end;

  {Sexo Default = Feminino para Dom Doka, Pérola, Orchidea, Jeito e Produzida}
  if (FSCMenuPrincipal.InPARA_REGISTRO=4030050) or (FSCMenuPrincipal.InPARA_REGISTRO=4030048) or (FSCMenuPrincipal.InPARA_REGISTRO=4030109) or
     (FSCMenuPrincipal.InPARA_REGISTRO=4030119) or (FSCMenuPrincipal.InPARA_REGISTRO=4030126)
     then RadioGroupSexo.ItemIndex:=1;

  {Tamanho Somente para Dom Doka/Orchidea/Jeito Incomum/Pure}
  LabelTam.Visible:=(FSCMenuPrincipal.InPARA_REGISTRO=4030048) or (FSCMenuPrincipal.InPARA_REGISTRO=4030109) or (FSCMenuPrincipal.InPARA_REGISTRO=4030119) or (FSCMenuPrincipal.InPARA_REGISTRO=4030168);
  EditTam.Visible:=LabelTam.Visible;

  {Tira Mãe para Makos / Produzida / Babinho / 3313 Brotherhood}
  // Makos ou 3313 Brotherhood e Pai = Carros/Plac/ e coloca operadora
  LabelMae.Visible:=(FSCMenuPrincipal.InPARA_REGISTRO<>4030049) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030126) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030151) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030270);
  EditMae.Visible:=LabelMae.Visible;
  if (FSCMenuPrincipal.InPARA_REGISTRO=4030049) or (FSCMenuPrincipal.InPARA_REGISTRO=4030270) then LabelPai.Caption:='Carro';
  LabelOper1.Visible:=(FSCMenuPrincipal.InPARA_REGISTRO=4030049) or (FSCMenuPrincipal.InPARA_REGISTRO=4030270); EditOper1.Visible:=LabelOper1.Visible;
  LabelOper2.Visible:=LabelOper1.Visible; EditOper2.Visible:=LabelOper1.Visible;

  // Tira Pai para produzida / Babinho
  if (FSCMenuPrincipal.InPARA_REGISTRO=4030126) or (FSCMenuPrincipal.InPARA_REGISTRO=4030151) then
  begin
     LabelPai.Visible:=False; EditPai.Visible:=False;
  end;

  // Dibogart - Tira campos razão social, pai, orgão emissor, dt.expedição e email
  if FSCMenuPrincipal.InPARA_REGISTRO=4030006 then
  begin
     LabelRazao.Visible:=False; EditRazao.Visible:=False; LabelPai.Visible:=False; EditPai.Visible:=False;
     LabelOrgao.Visible:=False; EditOrgao.Visible:=False; LabelExpedicao.Visible:=False; MaskEditExpedicao.Visible:=False;
     LabelEmailCom.Visible:=False; EditEmailCom.Visible:=False;
  end;

  // Jeito Incomum - Profissões e Indicado Por
  ComboBoxProf.Visible:=(FSCMenuPrincipal.InPARA_REGISTRO<>4030049) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030270);
  if FSCMenuPrincipal.InPARA_REGISTRO=4030119 then
  begin
     LabelOper1.Visible:=True; LabelOper1.Caption:='Profissão';
     ComboBoxProf.Items.Clear;
     AtivaSQL(DMCAD.QuAux,'select * from profissao order by prof_descricao');
     while not DMCAD.QuAux.EOF do
     begin
       ComboBoxProf.Items.Add(UpperCase(DMCAD.QuAux.FieldByName('PROF_DESCRICAO').AsString));
       DMCAD.QuAux.Next;
     end;

     ComboBoxIndicado.Visible:=True; LabelIndicado.Visible:=True; ComboBoxIndicado.Width:=195;
     ComboBoxIndicado.Items.Clear;
     AtivaSQL(DMCAD.QuAux,'select * from indicacao order by indi_descricao');
     while not DMCAD.QuAux.EOF do
     begin
       ComboBoxIndicado.Items.Add(UpperCase(DMCAD.QuAux.FieldByName('INDI_DESCRICAO').AsString));
       DMCAD.QuAux.Next;
     end;
  end

  // Outros (-Makos) = Indicado por
  else if (FSCMenuPrincipal.InPARA_REGISTRO<>4030049) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030270) then
  begin
     LabelOper1.Visible:=True; LabelOper1.Caption:='Indicado';
     ComboBoxProf.Items.Clear;
     AtivaSQL(DMCAD.QuAux,'select * from indicacao order by indi_descricao');
     while not DMCAD.QuAux.EOF do
     begin
       ComboBoxProf.Items.Add(UpperCase(DMCAD.QuAux.FieldByName('INDI_DESCRICAO').AsString));
       DMCAD.QuAux.Next;
     end;
  end;

  // Fidelidade - somente para Makos - nível 0
  LabelFidelCartao.Visible:=(FSCMenuPrincipal.InPARA_REGISTRO=4030049) and (FSCMenuPrincipal.StNivelAcessoUsuario='0');
  EditFidelCartao.Visible:=LabelFidelCartao.Visible; LabelFidelPontos.Visible:=LabelFidelCartao.Visible; EditFidelPontos.Visible:=LabelFidelCartao.Visible;

  {Verifica se pode Editar Dados do Cadastro}
  BitBtnEditar.Visible:=ValorCampo('ParamPDV','PARA_INCCLIENTE','')='C';

  // Tira campos para Leve Pizza / Fornello
  if (FSCMenuPrincipal.InPARA_REGISTRO=4030146) or (FSCMenuPrincipal.InPARA_REGISTRO=4030180) then
  begin
     GroupBoxFisica.Visible:=False; GroupBoxJuridica.Visible:=False; RadioGroupEspecie.Visible:=False; LabelRazao.Visible:=False; EditRazao.Visible:=False;
     BitBtnCEP.Top:=BitBtnCEP.Top-100; LabelEmailCom.Top:=LabelEmailCom.Top-100; EditEmailCom.Top:=EditEmailCom.Top-100;
     LabelEndereco.Top:=LabelEndereco.Top-100; EditTipoLogradouro.Top:=EditTipoLogradouro.Top-100; EditLogradouro.Top:=EditLogradouro.Top-100; LabelNumero.Top:=LabelNumero.Top-100; EditNumero.Top:=EditNumero.Top-100;
     LabelComplemento.Top:=LabelComplemento.Top-100; EditComplemento.Top:=EditComplemento.Top-100; LabelBairro.Top:=LabelBairro.Top-100; EditBairro.Top:=EditBairro.Top-100;
     LabelCidade.Top:=LabelCidade.Top-100; EditCidade.Top:=EditCidade.Top-100; LabelUF.Top:=LabelUF.Top-100; EditUF.Top:=EditUF.Top-100; LabelCEP.Top:=LabelCEP.Top-100; MaskEditCEP.Top:=MaskEditCEP.Top-100;
     LabelTelefoneCom1.Top:=LabelTelefoneCom1.Top-100; MaskEditTelefoneCom1.Top:=MaskEditTelefoneCom1.Top-100; LabelTelefoneCom2.Top:=LabelTelefoneCom2.Top-100; MaskEditTelefoneCom2.Top:=MaskEditTelefoneCom2.Top-100;
     LabelOper1.Visible:=False; ComboBoxProf.Visible:=False;
     BoClienteObrigatorio:=False;
  end;

  {Inclui Automático ou Focaliza o Nome/Grid}
  if not BoIncluirAutomatico then
  begin
    if (FSCMenuPrincipal.InPARA_REGISTRO=4030161) or (FSCMenuPrincipal.InPARA_REGISTRO=4030201) then // Mercado do Parque / Mercado Dia a dia
    begin
      if DBGridCliente.Visible then DBGridCliente.SetFocus;
    end
    else
    begin
      if EditNome.Visible then EditNome.SetFocus;
    end;
  end
  else BitBtnIncluir.Click;

end;

{TECLAS DE ATALHO}
procedure TFMPDVCliente.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  {F5 - Incluir Cliente}
  if Chr(Key)='t' then BitBtnIncluir.Click;

  {F10 - Consulta CEP}
  if Chr(Key)='y' then if GroupBoxIncluirCom.Visible then BitBtnCEP.Click;

end;

{COLOCA DEGRADÊ E O NOME DO FORMULÁRIO NA VERTICAL}
procedure TFMPDVCliente.FormPaint(Sender: TObject);
begin
  if FSCMenuPrincipal.StCoresSistema<>'W' then
    PintaDegrade(Self as TForm,NIL,FSCMenuPrincipal.CoCorMovimentos1,FSCMenuPrincipal.CoCorMovimentos2);
  NomeVertical(Self as TForm,'W.Selecionar Cliente');
  RadioGroupEspecie.Color:=GroupBoxIncluirCom.Color;
  RadioGroupSexo.Color:=GroupBoxIncluirCom.Color;
end;

{FECHA O FORMULÁRIO}
procedure TFMPDVCliente.FormClose(Sender: TObject; var Action: TCloseAction);
var StSelecao: String;
begin

  {Retorna o SQL Original de Clientes}
  StSelecao:='select G.GERA_CODIGO,G.GERA_NOME from Geral G join TipoGeral T on G.TGER_CODIGO=T.TGER_CODIGO '+
             'where G.GERA_ATIVO=''S'' and upper(T.TGER_DESCRICAO) like "%'+'CLIENTE'+'%" order by GERA_NOME';
  AtivaSQL(DMSql.QuGeralCli,StSelecao);
  AtivaSQL(DMMOV.QuGeralInat,'');

  {Verifica se Alterou os Dados}
  if (BoAlterarDados) and (not BoConfirmouAlt) then
  begin
     StCodigoCliente:='';
     StNomeCliente:='';
  end;
  
end;

{PROCURA PELO NOME}
procedure TFMPDVCliente.EditNomeChange(Sender: TObject);
begin
  if not CheckBoxGlobal.Checked then
  begin
     if EditNome.Text<>'' then
       DMSql.QuGeralCli.Locate('GERA_NOME',EditNome.Text,[loPartialKey,loCaseInsensitive])
     else
       DMSql.QuGeralCli.First;
  end
  else AtivaSQLCliente;
end;

{SELECIONA O CLIENTE}
procedure TFMPDVCliente.EditNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=Chr(13) then
  begin
    StCodigoCliente:=DMSql.QuGeralCliGERA_CODIGO.Value;
    StNomeCliente:=Trim(DMSql.QuGeralCliGERA_NOME.Value);
    if AtivaSQL(DMCad.QuAux,'select C.CONC_DESCRICAO from Conceito C join Geral G on C.CONC_CODIGO=G.CONC_CODIGO where C.CONC_AVISAR=''S'' and G.GERA_CODIGO='''+StCodigoCliente+'''') then
      Mensagem('ATENÇÃO: Cliente com Conceito '+DMCad.QuAux.FieldByName('CONC_DESCRICAO').AsString,'&Ok','','');

    // Se for Jeito Incomum confirmar dados do cliente
    if (FSCMenuPrincipal.InPARA_REGISTRO=4030119) and (GroupBoxIncluirRes.Visible=False) and not FileExists('C:\Computer.SEC') then
    begin
       BoAlterarDados:=True;
       BoConfirmouAlt:=False;
       GroupBoxIncluirCom.Caption:='Confirmação de dados cadastrais';
       BitBtnIncluirClick(Sender);
       BitBtnIncluir.Visible:=False;
       BitBtnConfirmaDados.Visible:=True;
    end
    else Close;
  end;
end;

{FORÇA UM ENTER SE DER UM DUPLO CLIQUE NO GRID}
procedure TFMPDVCliente.DBGridClienteDblClick(Sender: TObject);
begin
  Keybd_Event(13,0,0,0);
end;

{VERIFICA A ESPÉCIE}
procedure TFMPDVCliente.RadioGroupEspecieExit(Sender: TObject);
begin
  if RadioGroupEspecie.ItemIndex=0 then
  begin
    GroupBoxFisica.Visible:=True;
    GroupBoxJuridica.Visible:=False;
    if Sender=RadioGroupEspecie then MaskEditCPF.SetFocus;
  end
  else
  begin
    GroupBoxFisica.Visible:=False;
    GroupBoxJuridica.Visible:=True;
    if Sender=RadioGroupEspecie then MaskEditCNPJ.SetFocus;
  end;
end;

{INCLUIR CLIENTE}
procedure TFMPDVCliente.BitBtnIncluirClick(Sender: TObject);
var InTipoCliente: Integer;
    StSelecao,StCodigoGeral,StNome,StDtNascimento,StDtExpedicao: String;
    StCarro,StCarroTit,StCartao,StCartaoTit,StTipoFone,StProf, StCodIndicado: String;
    BoCompleto, BoObrigaEnd, BoObrigaRG, BoObrigaCPF, BoObrigaMae, BoIncNovoEnd, BoObrigaIndica: Boolean;
    VaDados: Array[0..4] of Variant;
begin
  // Verifica se pode incluir
  if not BoAlterarDados then
  begin
     AtivaSQL(DMFUN.QuAux,'select NIVE_INCLUIR,NIVE_EXCLUIR,NIVE_EDITAR,NIVE_CANCELAR,NIVE_IMPRIMIR,NIVE_OUTROS '+
                          'from Nivel where SIST_NOME='''+FSCMenuPrincipal.StNomeSistema+''' and NIVE_NIVEL='+FSCMenuPrincipal.StNivelAcessoUsuario+' and NIVE_MODULO="Cadastros\Geral\Geral"');
     if DMFUN.QuAux.FieldByName('NIVE_INCLUIR').AsString='N' then
     begin
        Mensagem('Usuário não autorizado para incluir cliente !','&Ok','','');
        SysUtils.Abort;
     end;
  end;

  {Mostra o GroupBox de Inclusão}
  LabelAdicional1.Caption:=''; LabelAdicional2.Caption:=''; LabelAdicional3.Caption:='';
  if LabelNome.Visible then
  begin

    BitBtnEditar.Visible:=False;

    {Inclusão Resumida ou Completa}
    LabelNome.Visible:=False;
    EditNome.Visible:=False;
    CheckBoxGlobal.Visible:=False;
    DBGridCliente.Visible:=False;
    GroupBoxIncluirRes.Visible:=ValorCampo('ParamPDV','PARA_INCCLIENTE','')='R';
    GroupBoxIncluirCom.Visible:=not GroupBoxIncluirRes.Visible;

    // Caramelo - Filho
    GroupBoxFilho.Visible:=FSCMenuPrincipal.InPARA_REGISTRO=4030152;

    if GroupBoxIncluirRes.Visible then
      EditNomeRes.SetFocus
    else
      EditNomeCom.SetFocus;

    // Makos
    if FSCMenuPrincipal.InPARA_REGISTRO=4030049 then MaskEditCPF.SetFocus;


    // Para Matriz + Campos na inclusão resumida
    if FSCMenuPrincipal.InPARA_REGISTRO=4030021 then GroupBoxIncluirRes.Height:=185;

    // Se for para confirmar dados
    if (BoAlterarDados) and (GroupBoxIncluirRes.Visible=False) then
    begin
       AtivaSQL(DMCAD.QuAux,'select * from geral where gera_codigo="'+StCodigoCliente+'"');
       EditNomeCom.Text:=DMCAD.QuAux.FieldByName('GERA_NOME').AsString;
       EditRazao.Text:=DMCAD.QuAux.FieldByName('GERA_RAZAO').AsString;
       EditEmailCom.Text:=DMCAD.QuAux.FieldByName('GERA_EMAIL').AsString;
       EditFidelCartao.Text:=DMCAD.QuAux.FieldByName('GERA_CARTAOFIDEL').AsString;
       EditFidelPontos.Text:=DMCAD.QuAux.FieldByName('GERA_NUMFIDEL').AsString;
       if DMCAD.QuAux.FieldByName('GERA_NUMFIDEL').IsNull then EditFidelPontos.Text:='0';

       // Indicado por (Não para Makos/ 3313 Britherhood)
       if (FSCMenuPrincipal.InPARA_REGISTRO<>4030049) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030270) and (DMCAD.QuAux.FieldByName('INDI_CODIGO').IsNull=False) then
       begin
          StCodIndicado:=DMCAD.QuAux.FieldByName('INDI_CODIGO').AsString;

          // Jeito Incomum outro campo
          if FSCMenuPrincipal.InPARA_REGISTRO=4030119
             then ComboBoxIndicado.Text:=UpperCase(ValorCampo('indicacao','indi_descricao','indi_codigo='+DMCAD.QuAux.FieldByName('INDI_CODIGO').AsString))
             else ComboBoxProf.Text:=UpperCase(ValorCampo('indicacao','indi_descricao','indi_codigo='+DMCAD.QuAux.FieldByName('INDI_CODIGO').AsString));
       end;

       if DMCAD.QuAux.FieldByName('GERA_FISJUR').AsString='J' then
       begin
          RadioGroupEspecie.ItemIndex:=1;
          MaskEditCNPJ.Text:=DMCAD.QuAux.FieldByName('GERA_CNPJ').AsString;
       end
       else
       begin
          RadioGroupEspecie.ItemIndex:=0;
          MaskEditCPF.Text:=DMCAD.QuAux.FieldByName('GERA_CPF').AsString;
          MaskEditNascimentoCom.Text:=DMCAD.QuAux.FieldByName('GERA_DTNASC').AsString;

          AtivaSQL(DMCAD.QuAux,'select * from gerpfisica where gera_codigo="'+StCodigoCliente+'"');

          EditRG.Text:=DMCAD.QuAux.FieldByName('GERA_DTEXPEDICAO').AsString;
          EditOrgao.Text:=DMCAD.QuAux.FieldByName('GERA_ORGAOEXP').AsString;
          MaskEditExpedicao.Text:=DMCAD.QuAux.FieldByName('GERA_DTEXPEDICAO').AsString;
          EditPai.Text:=DMCAD.QuAux.FieldByName('GERA_NOMEPAI').AsString;
          EditMae.Text:=DMCAD.QuAux.FieldByName('GERA_NOMEMAE').AsString;
          if DMCAD.QuAux.FieldByName('GERA_SEXO').AsString='M'
             then RadioGroupSexo.ItemIndex:=0
             else RadioGroupSexo.ItemIndex:=1;

          // Jeito Incomum - Profissões
          if FSCMenuPrincipal.InPARA_REGISTRO=4030119 then
             if DMCAD.QuAux.FieldByName('PROF_CODIGO').IsNull=False then ComboBoxProf.Text:=UpperCase(ValorCampo('profissao','prof_descricao','prof_codigo='+DMCAD.QuAux.FieldByName('PROF_CODIGO').AsString));
       end;

       // Para Babinho opção de escolher endereço
       if (FSCMenuPrincipal.InPARA_REGISTRO=4030151)
          then AtivaSQL(DMCAD.QuAux,'select * from gerendereco where gera_codigo="'+StCodigoCliente+'"')
          else AtivaSQL(DMCAD.QuAux,'select * from gerendereco where gera_codigo="'+StCodigoCliente+'" and gend_sequencia=1');

       BoIncNovoEnd:=False;
       if (FSCMenuPrincipal.InPARA_REGISTRO=4030151) and (DMCAD.QuAux.RecordCount>1) then
       begin
          Application.CreateForm(TFMPDVClienteEnd,FMPDVClienteEnd);
          FMPDVClienteEnd.ShowModal;
          BoIncNovoEnd:=FMPDVClienteEnd.BoIncNovoEnd;
          FMPDVClienteEnd.Free;
       end;

       if not BoIncNovoEnd then
       begin
          EditTipoLogradouro.Text:=DMCAD.QuAux.FieldByName('TLOG_CODIGO').AsString;
          EditNumero.Text:=DMCAD.QuAux.FieldByName('GEND_NUMERO').AsString;
          EditComplemento.Text:=DMCAD.QuAux.FieldByName('GEND_COMPLEMENTO').AsString;
          Editlogradouro.Text:=DMCAD.QuAux.FieldByName('GEND_LOGRADOURO').AsString;
          StEndAnterior:=EditLogradouro.Text;
          EditBairro.Text:=DMCAD.QuAux.FieldByName('GEND_BAIRRO').AsString;
          EditCidade.Text:=DMCAD.QuAux.FieldByName('GEND_CIDADE').AsString;
          EditUF.Text:=DMCAD.QuAux.FieldByName('GEND_UF').AsString;
          MaskEditCEP.Text:=DMCAD.QuAux.FieldByName('GEND_CEP').AsString;
          StEndSequencia:=DMCAD.QuAux.FieldByName('GEND_SEQUENCIA').AsString;
       end
       else StEndAnterior:='';

       if AtivaSQL(DMCAD.QuAux,'select * from gerfone where gera_codigo="'+StCodigoCliente+'" and gend_sequencia=1') then
       begin
          MaskEditTelefoneCom1.Text:=DMCAD.QuAux.FieldByName('GFON_NUMERO').AsString;
          EditOper1.Text:=DMCAD.QuAux.FieldByName('gfon_tipo').AsString;
          DMCAD.QuAux.Next;

          if DMCAD.QuAux.FieldByName('GFON_NUMERO').AsString<>MaskEditTelefoneCom1.Text then
          begin
             MaskEditTelefoneCom2.Text:=DMCAD.QuAux.FieldByName('GFON_NUMERO').AsString;
             EditOper2.Text:=DMCAD.QuAux.FieldByName('gfon_tipo').AsString;
          end;
       end;
       StFoneAnt1:=''; StFoneAnt2:='';
       if Length(Trim(MaskEditTelefoneCom1.Text))=13 then StFoneAnt1:=MaskEditTelefoneCom1.Text;
       if Length(Trim(MaskEditTelefoneCom2.Text))=13 then StFoneAnt2:=MaskEditTelefoneCom2.Text;

       // Caramelo - Filhos
       if FSCMenuPrincipal.InPARA_REGISTRO=4030152 then
          if AtivaSQL(DMCAD.QuAux,'select * from gercontato where gera_codigo="'+StCodigoCliente+'"') then
          begin
             MaskEditNascFilho.Text:=DMCAD.QuAux.FieldByName('GERC_DTNASC').AsString;
             EditFilho.Text:=DMCAD.QuAux.FieldByName('gerc_nome').AsString;
          end;

    end;

    // Se for Produzida, Cidade e UF padrões
    if FSCMenuPrincipal.InPARA_REGISTRO=4030126 then
    begin
       if EditCidade.Text='' then EditCidade.Text:='PORTO ALEGRE';
       if EditUF.Text='' then EditUF.Text:='RS';
    end;

  end

  {Inclui o Cliente}
  else
  begin

    {Verifica os Dados do Cliente}

    // Campos obrigatórios
    BoObrigaEnd:=True;
    BoObrigaRG:=True;
    BoObrigaCPF:=False;
    BoObrigaMae:=True;
    BoObrigaIndica:=False;

    // Se for Jeito Incomum
    if FSCMenuPrincipal.InPARA_REGISTRO=4030119 then
    begin
       BoClienteObrigatorio:=True;
       BoObrigaEnd:=False; BoObrigaRG:=False; BoObrigaMae:=False; BoObrigaIndica:=True;
    end;

    if BoClienteObrigatorio then
    begin
      BoCompleto:=True;
      if GroupBoxIncluirRes.Visible then
      begin
        if Trim(EditNomeRes.Text)='' then BoCompleto:=False;
        // Não para Dibogart
        if FSCMenuPrincipal.InPARA_REGISTRO<>4030006 then
        begin
           if Trim(EditEmailRes.Text)='' then BoCompleto:=False;
           if Length(Trim(MaskEditTelefoneRes.Text))<>13 then BoCompleto:=False;
           if Length(Trim(MaskEditNascimentoRes.Text))<>8 then BoCompleto:=False;
        end;
      end
      else
      begin
        if EditNomeCom.Text='' then BoCompleto:=False;
        if RadioGroupEspecie.ItemIndex=0 then
        begin
          if BoObrigaCPF then if Copy(MaskEditCPF.Text,1,2)='  ' then BoCompleto:=False;
          if Copy(MaskEditNascimentoCom.Text,1,2)='  ' then BoCompleto:=False;
          if BoObrigaRG then if EditRG.Text='' then BoCompleto:=False;
          if (Copy(MaskEditTelefoneCom1.Text,1,3)='(  ') and (Copy(MaskEditTelefoneCom2.Text,1,3)='(  ') then BoCompleto:=False;
//          if EditOrgao.Text='' then BoCompleto:=False;
//          if Length(MaskEditExpedicao.Text)<>8 then BoCompleto:=False;
//          if EditPai.Text='' then BoCompleto:=False;
          if BoObrigaMae then if EditMae.Text='' then BoCompleto:=False;
          if BoObrigaIndica then if ComboBoxIndicado.Text='' then BoCompleto:=False;
        end
        else
        begin
          if EditRazao.Text='' then BoCompleto:=False;
          if BoObrigaCPF then if Copy(MaskEditCNPJ.Text,1,2)='  ' then BoCompleto:=False;
        end;
//        if EditEmailCom.Text='' then BoCompleto:=False;
        if BoObrigaEnd then
        begin
           if EditTipoLogradouro.Text='' then BoCompleto:=False;
           if EditLogradouro.Text='' then BoCompleto:=False;
           if EditNumero.Text='' then BoCompleto:=False;
           if EditComplemento.Text='' then BoCompleto:=False;
           if EditBairro.Text='' then BoCompleto:=False;
           if EditCidade.Text='' then BoCompleto:=False;
           if EditUF.Text='' then BoCompleto:=False;
           if Length(MaskEditCEP.Text)<>9 then BoCompleto:=False;
           if Length(MaskEditTelefoneCom1.Text)<>13 then BoCompleto:=False;
           if Length(MaskEditTelefoneCom2.Text)<>13 then BoCompleto:=False;
        end;
      end;
      if not BoCompleto then
      begin
        // Se for Jeito Incomum
        if FSCMenuPrincipal.InPARA_REGISTRO=4030119 then Mensagem('Preencher o nome, e-mail, data de nascimento, telefone e indicação.','&Ok','','')
        else Mensagem('Todos os dados do cliente devem ser preenchidos.','&Ok','','');

        SysUtils.Abort;
      end;
    end;

    // Makos - cpf obrigatório
    if (FSCMenuPrincipal.InPARA_REGISTRO=4030049) and (Copy(MaskEditCPF.Text,1,2)='  ') then
    begin
       Mensagem('Preencher o nome e cpf.','&Ok','','');
       SysUtils.Abort;
    end;

    {Inclui o Cliente}
    StCodigoGeral:='';
    if GroupBoxIncluirRes.Visible then
      StNome:=Trim(EditNomeRes.Text)
    else
      StNome:=Trim(EditNomeCom.Text);
    if StNome<>'' then
    begin

      {Tipo Cliente}
      InTipoCliente:=ValorCampo('TipoGeral','TGER_CODIGO','Upper(TGER_DESCRICAO)=''CLIENTE''');

      {Verifica se o Cliente já Existe}
      StSelecao:='select GERA_CODIGO from Geral where GERA_NOME='''+StNome+''' and TGER_CODIGO='+IntToStr(InTipoCliente);
      if not AtivaSQL(DMCad.QuAux,StSelecao) then
      begin

        {Código do Cliente}
        StCodigoGeral:=PoeZero(StrToInt(FSCMenuPrincipal.StFilialUsuaria),2)+'.'+PoeZero(CtrlUltimoCodigo(DMCad.DaGeral,'UltimoCodigo',1,0),8);

        {Controle Acesso}
        ControleAcesso('Geral','Inclusão','Código '+StCodigoGeral+'   Nome '+StNome+' - via PDV');

        {Inclui o Cliente}
        if GroupBoxIncluirRes.Visible then
        begin
          if Copy(MaskEditNascimentoRes.Text,1,2)<>'  ' then StDtNascimento:='"'+DataSQL(StrToDate(MaskEditNascimentoRes.Text))+'"' else StDtNascimento:='Null';
          if EditCartaoRes.Text<>'' then StCartao:='"'+Poezero(StrToInt(EditCartaoRes.Text),5)+'"' else StCartao:='Null';
          StSelecao:='insert into Geral (GERA_CODIGO,GERA_NOME,GERA_FISJUR,GERA_DTNASC,GERA_EMAIL,GERA_ATIVO,TGER_CODIGO,CONC_CODIGO,GERA_CPF,GERA_DTCADASTRO,GERA_CARTAOFIDEL) values ("'+
                     StCodigoGeral+'","'+StNome+'","F",'+StDtNascimento+',"'+Copy(EditEmailRes.Text,1,40)+'","S",'+IntToStr(InTipoCliente)+',0,"'+MaskEditCPFRes.Text+'","'+DataSQL(Date)+'",'+StCartao+')';

        end
        else
        begin
          // Se for Makos / 3313 Brotherhood inclui carro
          StCarro:=''; StCarroTit:='';
          if ((FSCMenuPrincipal.InPARA_REGISTRO=4030049) or (FSCMenuPrincipal.InPARA_REGISTRO=4030270)) and (EditPai.Text<>'') then
          begin
             StCarroTit:=',GERA_CARROS';
             StCarro:=',"'+EditPai.Text+'"';
          end;
          if Copy(MaskEditNascimentoCom.Text,1,2)<>'  ' then StDtNascimento:=''''+DataSQL(StrToDate(MaskEditNascimentoCom.Text))+'''' else StDtNascimento:='Null';

          // Indicado por (Não para Jeito, Makos e 3313Brotherhood)
          if (FSCMenuPrincipal.InPARA_REGISTRO<>4030119) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030049) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030270) and (ComboBoxProf.Text<>'') then StCodIndicado:=','+IntToStr(ValorCampo('indicacao','indi_codigo','upper(indi_descricao)="'+ComboBoxProf.Text+'"'))
          else if (FSCMenuPrincipal.InPARA_REGISTRO=4030119) and (ComboBoxIndicado.Text<>'') then StCodIndicado:=','+IntToStr(ValorCampo('indicacao','indi_codigo','upper(indi_descricao)="'+ComboBoxIndicado.Text+'"'))
          else StCodIndicado:=',Null';

          if EditFidelCartao.Text<>'' then StCartaoTit:=',GERA_CARTAOFIDEL,GERA_NUMFIDEL' else StCartaoTit:='';
          if EditFidelCartao.Text<>'' then StCartao:=',"'+EditFidelCartao.Text+'",'+EditFidelPontos.Text else StCartao:='';

          StSelecao:='insert into Geral (GERA_CODIGO,GERA_NOME,GERA_RAZAO,GERA_FISJUR,GERA_CPF,GERA_CNPJ,GERA_DTNASC,GERA_EMAIL,GERA_ATIVO,TGER_CODIGO,CONC_CODIGO,GERA_DTCADASTRO,INDI_CODIGO'+StCarroTit+StCartaoTit+') values ('''+
                     StCodigoGeral+''','''+StNome+''','''+EditRazao.Text+''','''+Copy(RadioGroupEspecie.Items[RadioGroupEspecie.ItemIndex],1,1)+''','''+MaskEditCPF.Text+''','''+
                     MaskEditCNPJ.Text+''','+StDtNascimento+','''+Copy(EditEmailCom.Text,1,40)+''',''S'','+IntToStr(InTipoCliente)+',0,'''+DataSQL(Date)+''''+StCodIndicado+StCarro+StCartao+')';
        end;
        RodaSQL(DMCad.SQLAux,StSelecao);

        {Inclui os Dados da Pessoa Física}
        if GroupBoxIncluirCom.Visible then
          if RadioGroupEspecie.ItemIndex=0 then
          begin
            if Copy(MaskEditExpedicao.Text,1,2)<>'  ' then StDtExpedicao:=''''+DataSQL(StrToDate(MaskEditExpedicao.Text))+'''' else StDtExpedicao:='Null';
            if (FSCMenuPrincipal.InPARA_REGISTRO=4030119) and (ComboBoxProf.Text<>'') then StProf:=','+IntToStr(ValorCampo('profissao','prof_codigo','upper(prof_descricao)="'+ComboBoxProf.Text+'"')) else StProf:=',Null';
            StSelecao:='insert into GerPFisica (GERA_CODIGO,GERA_RG,GERA_ORGAOEXP,GERA_DTEXPEDICAO,GERA_NOMEPAI,GERA_NOMEMAE,GERA_SEXO,GERA_TAMANHO,PROF_CODIGO) values ("'+
                       StCodigoGeral+'","'+EditRG.Text+'","'+EditOrgao.Text+'",'+StDtExpedicao+',"'+
                       EditPai.Text+'","'+EditMae.Text+'","'+Copy(RadioGroupSexo.Items[RadioGroupSexo.ItemIndex],1,1)+'","'+EditTam.Text+'"'+StProf+')';
            RodaSQL(DMCad.SQLAux,StSelecao);
          end;

        {Inclui o Endereço}
        if GroupBoxIncluirRes.Visible or (EditLogradouro.Text='') then
        begin
          if EditBairroRes.Text=''
             then StSelecao:='insert into GerEndereco (GERA_CODIGO,GEND_SEQUENCIA,GEND_LOGRADOURO,GEND_UF) values ('''+
                              StCodigoGeral+''',1,''Não Cadastrado'',''RS'')'
             else StSelecao:='insert into GerEndereco (GERA_CODIGO,GEND_SEQUENCIA,GEND_LOGRADOURO,GEND_BAIRRO,GEND_CIDADE,GEND_UF) values ('''+
                              StCodigoGeral+''',1,'+'"Não Cadastrado","'+EditBairroRes.Text+'","'+EditCidadeRes.Text+'","RS")';
        end
        else
          StSelecao:='insert into GerEndereco (GERA_CODIGO,GEND_SEQUENCIA,TLOG_CODIGO,GEND_LOGRADOURO,GEND_NUMERO,GEND_COMPLEMENTO,GEND_BAIRRO,GEND_CIDADE,GEND_UF,GEND_CEP) values ('''+
                     StCodigoGeral+''',1,'''+EditTipoLogradouro.Text+''','''+EditLogradouro.Text+''','''+EditNumero.Text+''','''+EditComplemento.Text+''','''+
                     EditBairro.Text+''','''+EditCidade.Text+''','''+EditUF.Text+''','''+MaskEditCEP.Text+''')';
        RodaSQL(DMCad.SQLAux,StSelecao);

        {Inclui o Telefone}
        if GroupBoxIncluirRes.Visible then
        begin
          if Length(Trim(MaskEditTelefoneRes.Text))=13 then
          begin
            if EditOper1.Text='' then StTipoFone:='Fone' else StTipoFone:=EditOper1.Text;
            StSelecao:='insert into GerFone (GERA_CODIGO,GEND_SEQUENCIA,GFON_NUMERO,GFON_TIPO) values ('''+StCodigoGeral+''',1,'''+MaskEditTelefoneRes.Text+''','''+StTipoFone+''')';
            RodaSQL(DMCad.SQLAux,StSelecao);
          end;
        end
        else
        begin
          if Length(Trim(MaskEditTelefoneCom1.Text))=13 then
          begin
            if EditOper1.Text='' then StTipoFone:='Fone' else StTipoFone:=EditOper1.Text;
            StSelecao:='insert into GerFone (GERA_CODIGO,GEND_SEQUENCIA,GFON_NUMERO,GFON_TIPO) values ('''+StCodigoGeral+''',1,'''+MaskEditTelefoneCom1.Text+''','''+StTipoFone+''')';
            RodaSQL(DMCad.SQLAux,StSelecao);
          end;
          if Length(Trim(MaskEditTelefoneCom2.Text))=13 then
          begin
            if EditOper2.Text='' then StTipoFone:='Cel' else StTipoFone:=EditOper2.Text;
            StSelecao:='insert into GerFone (GERA_CODIGO,GEND_SEQUENCIA,GFON_NUMERO,GFON_TIPO) values ('''+StCodigoGeral+''',1,'''+MaskEditTelefoneCom2.Text+''','''+StTipoFone+''')';
            RodaSQL(DMCad.SQLAux,StSelecao);
          end;
        end;

        // Caramelo - Filhos
        if (FSCMenuPrincipal.InPARA_REGISTRO=4030152) and (EditFilho.Text<>'') then
        begin
           if Copy(MaskEditNascFilho.Text,1,2)<>'  '
              then RodaSQL(DMCad.SQLAux,'insert into GerContato (GERA_CODIGO,GERC_TIPO,GERC_NOME,GERC_DTNASC) values ("'+StCodigoGeral+'","Filho","'+EditFilho.Text+'","'+DataSQL(StrToDate(MaskEditNascFilho.Text))+'")')
              else RodaSQL(DMCad.SQLAux,'insert into GerContato (GERA_CODIGO,GERC_TIPO,GERC_NOME) values ("'+StCodigoGeral+'","Filho",'+EditFilho.Text+'")');
        end;

        {Envia E-mail de Confirmação do Cadastro}
        if (ValorCampo('Parametro','PARA_EMAIL_GERALCONF','')='S') then
           if Pos('@',EditEmailCom.Text)>0 then
              if Mensagem('Deseja Enviar um E-mail para Confirmação dos Dados Cadastrados?','&Sim','&Não','')=1 then
                 //  Se for com Anexo manda só o anexo
                 if FileExists(ValorCampo('Parametro','PARA_EMAIL_GERALCONFAnexo','')) then
                 begin
                    VaDados[0]:=EditEmailCom.Text;
                    VaDados[1]:='E-MAIL DO SISTEMA - '+StNome;
                    VaDados[2]:='';
                    VaDados[3]:=1;
                    VaDados[4]:=ValorCampo('Parametro','PARA_EMAIL_GERALCONFAnexo','');
                    EnviarEmailMAPI(VaDados);
                 end;

        {Fecha o Formuário}
        StCodigoCliente:=StCodigoGeral;
        StNomeCliente:=StNome;
        Close;

      end
      else Mensagem('Já Existe um Cliente com Este Nome.','&Ok','','');

    end;

    BitBtnEditar.Visible:=True;

  end;

end;

{CONSULTA CEP}
procedure TFMPDVCliente.BitBtnCEPClick(Sender: TObject);
var StCEP: String;
begin
  BoChamouGuiaCEP:=True;
  StCEP:=MensagemTexto('Informe o CEP do Endereço','','');
  if StCEP<>'' then ValidaCEP(nil,StCEP,'','','','','','');

  EditTipoLogradouro.Text:=DMFun.StTipo;
  EditLogradouro.Text:=Copy(DMFun.StLogradouro,1,40);
  EditNumero.Text:=DMFun.StNumero;
  EditComplemento.Text:=DMFun.StComplemento;
  EditBairro.Text:=DMFun.StBairro;
  EditCidade.Text:=DMFun.StCidade;
  EditUF.Text:=DMFun.StUF;
  MaskEditCEP.Text:=DMFun.StCEP;
  if EditNumero.Text='' then EditNumero.SetFocus else MaskEditTelefoneCom1.SetFocus;
end;

{PREENCHE O FONE COM 51 QUANDO NÃO É INFORMADO}
procedure TFMPDVCliente.MaskEditTelefoneCom1Exit(Sender: TObject);
begin
  if (Copy((Sender as TMaskEdit).Text,12,2)='  ') and (Copy((Sender as TMaskEdit).Text,10,2)<>'  ') then
    (Sender as TMaskEdit).Text:='(51)'+Copy((Sender as TMaskEdit).Text,2,2)+Copy((Sender as TMaskEdit).Text,5,2)+'-'+Copy((Sender as TMaskEdit).Text,7,4);

  if (Copy((Sender as TMaskEdit).Text,13,1)=' ') then
    (Sender as TMaskEdit).Text:=Copy((Sender as TMaskEdit).Text,1,8)+'-'+Copy((Sender as TMaskEdit).Text,9,4);
end;

{LISTA DE PROVEDORES}
procedure TFMPDVCliente.EditEmailComKeyPress(Sender: TObject; var Key: Char);
var DBEditEMail: TDBEdit;
begin
  // Não para Jeito Incomum/Vivar
  if (Key=Chr(64)) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030119) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030130) then
  begin
    DBEditEMail:=TDBEdit.Create(FMPDVCliente);
    DBEditEMail.Name:='DBEditEMail';
    DBEditEMail.Visible:=False;
    DBEditEMail.DataField:='GERA_EMAIL';
    DBEditEMail.DataSource:=DMCAD.DsGeral;
    DBEditEMail.Parent:=GroupBoxIncluirRes;
    DBEditEMail.Text:=(Sender as TEdit).Text;
    ListaProvedores(DBEditEMail);
    (Sender as TEdit).Text:=DBEditEMail.Text;
    (Sender as TEdit).SelStart:=Length((Sender as TEdit).Text);
    DBEditEMail.Free;
    SysUtils.Abort;
  end;
end;

{PESQUISA GLOBAL CLIENTES}
procedure TFMPDVCliente.CheckBoxGlobalClick(Sender: TObject);
begin
  AtivaSQLCliente;
end;

{SE CHAMOU GUIA CEP E CIDADE ESTIVER PREENCHIDA PULA DIRETO PARA O FONE}
procedure TFMPDVCliente.EditComplementoExit(Sender: TObject);
begin
  if (EditCidade.Text<>'') and (BoChamouGuiaCEP) then MaskEditTelefoneCom1.SetFocus;
end;

{VERIFICA SEMELHANTES - MENOS PARA AÇOUGUE, MATRIZ E BABINHO}
procedure TFMPDVCliente.EditNomeResExit(Sender: TObject);
begin
  if (FSCMenuPrincipal.InPARA_REGISTRO<>4030034) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030021) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030151) then
    VerSemelhantes('Geral','GERA_CODIGO','99','GERA_NOME',(Sender as TEdit).Text);
end;

{ATIVA O SQL DE CLENTES}
procedure TFMPDVCliente.AtivaSQLCliente;
var StSelecao: String;
begin

  {Ativa o SQL}
  StSelecao:='select G.GERA_CODIGO,G.GERA_NOME from Geral G join TipoGeral T on G.TGER_CODIGO=T.TGER_CODIGO '+
             'where G.GERA_ATIVO=''S'' and upper(T.TGER_DESCRICAO) like "%'+'CLIENTE'+'%" ';
  if CheckBoxGlobal.Checked then
    if EditNome.Text<>'' then
      StSelecao:=StSelecao+' and GERA_NOME like ''%'+UpperCase(EditNome.Text)+'%'' ';
  StSelecao:=StSelecao+' order by GERA_NOME';
  AtivaSQL(DMSql.QuGeralCli,StSelecao);
  DMSql.QuGeralCli.First;

  // Para Toigo/Auri, se não achou nome procura pela placa
  if (EditNome.Text<>'') and (DMSql.QuGeralCli.RecordCount=0) and ((FSCMenuPrincipal.InPARA_REGISTRO=4030093) or (FSCMenuPrincipal.InPARA_REGISTRO=4030110) or (FSCMenuPrincipal.InPARA_REGISTRO=4030116))then
     if AtivaSQL(DMCAD.QuAux2,'select * from gerveiculo where gerv_placa="'+UpperCase(EditNome.Text)+'"') then
     begin
        StPlaca:=DMCAD.QuAux2.FieldByName('gerv_placa').AsString;
        StSelecao:='select G.GERA_CODIGO,G.GERA_NOME from Geral G join TipoGeral T on G.TGER_CODIGO=T.TGER_CODIGO '+
                   'where G.GERA_ATIVO=''S'' and upper(T.TGER_DESCRICAO)=''CLIENTE'''+
                   ' and GERA_CODIGO="'+DMCAD.QuAux2.FieldByName('gera_codigo').AsString+'"'+
                   ' order by GERA_NOME';
        AtivaSQL(DMSql.QuGeralCli,StSelecao);
        EditNome.Text:=DMSQL.QugeralCli.FieldByName('gera_nome').AsString;
     end;

  // Se for Matriz Pesquisa pelo num. fidelidade
  if (EditNome.Text<>'') and (DMSql.QuGeralCli.RecordCount=0) and (FSCMenuPrincipal.InPARA_REGISTRO=4030021) and (IsNumeric(Trim(EditNome.Text))) then
     if AtivaSQL(DMCAD.QuAux2,'select * from geral where gera_cartaofidel="'+UpperCase(EditNome.Text)+'"') then
     begin
        StSelecao:='select G.GERA_CODIGO,G.GERA_NOME from Geral G join TipoGeral T on G.TGER_CODIGO=T.TGER_CODIGO '+
                   'where G.GERA_ATIVO=''S'' and upper(T.TGER_DESCRICAO)=''CLIENTE'''+
                   ' and GERA_CODIGO="'+DMCAD.QuAux2.FieldByName('gera_codigo').AsString+'"'+
                   ' order by GERA_NOME';
        AtivaSQL(DMSql.QuGeralCli,StSelecao);
        EditNome.Text:=DMSQL.QugeralCli.FieldByName('gera_nome').AsString;
     end;

  // Para LEVE PIZZA / Fornello, se não achou procura pelo telefone
  if (EditNome.Text<>'') and (Length(EditNome.Text)>7) and (DMSql.QuGeralCli.RecordCount=0) and
     ((FSCMenuPrincipal.InPARA_REGISTRO=4030146) or (FSCMenuPrincipal.InPARA_REGISTRO=4030180)) then
     if AtivaSQL(DMCAD.QuAux2,'select * from gerfone where gfon_numero containing "'+UpperCase(EditNome.Text)+'"') then
     begin
        StSelecao:='select G.GERA_CODIGO,G.GERA_NOME from Geral G join TipoGeral T on G.TGER_CODIGO=T.TGER_CODIGO '+
                   'where G.GERA_ATIVO=''S'' and upper(T.TGER_DESCRICAO)=''CLIENTE'''+
                   ' and GERA_CODIGO="'+DMCAD.QuAux2.FieldByName('gera_codigo').AsString+'"'+
                   ' order by GERA_NOME';
        AtivaSQL(DMSql.QuGeralCli,StSelecao);
//        EditNome.Text:=DMSQL.QugeralCli.FieldByName('gera_nome').AsString;
     end;

  // Se não achou procura pelo CPF
  if (EditNome.Text<>'') and (Length(EditNome.Text)=11) and (DMSql.QuGeralCli.RecordCount=0) then
  begin
     StSelecao:='select G.GERA_CODIGO,G.GERA_NOME from Geral G join TipoGeral T on G.TGER_CODIGO=T.TGER_CODIGO '+
                'where G.GERA_ATIVO=''S'' and upper(T.TGER_DESCRICAO)=''CLIENTE'''+
                ' and GERA_CPF="'+Copy(EditNome.Text,1,3)+'.'+Copy(EditNome.Text,4,3)+'.'+Copy(EditNome.Text,7,3)+'-'+Copy(EditNome.Text,10,2)+'"'+
                ' order by GERA_NOME';
     AtivaSQL(DMSql.QuGeralCli,StSelecao);
     EditNome.Text:=DMSQL.QugeralCli.FieldByName('gera_nome').AsString;
  end;

  {Focaliza o Nome ou o Grid}
  if (FSCMenuPrincipal.InPARA_REGISTRO=4030161)  or (FSCMenuPrincipal.InPARA_REGISTRO=4030201) then // Mercado do Parque, Mercado Dia a Dia
  begin
    if DBGridCliente.Visible then DBGridCliente.SetFocus;
  end
  else
  begin
    if EditNome.Visible then EditNome.SetFocus;
  end;

end;

// Mostra dados adicionais do cliente
procedure TFMPDVCliente.DBEditCodigoChange(Sender: TObject);
var StAdicional, StAdicional1, StAdicional2, StAdicional3: String;
    InI: Integer;
begin
   StAdicional1:='select first 1 "Endereço: "||gend_logradouro||" "||case when gend_numero is not null then gend_numero else " " end '+
                 '||" "||case when gend_complemento is not null then "/"|| gend_complemento else " " end||" - "||gend_cidade||" - "||gend_uf from gerendereco';
   StAdicional2:='select "Fone "||gfon_numero from gerfone';

   // Se for Matriz mostra fidelização
   if FSCMenuPrincipal.InPARA_REGISTRO=4030021
      then StAdicional3:='select "Cartão Fidel. "||gera_cartaofidel||" Pontos: "||gera_numfidel from geral'
      else StAdicional3:='select case when gera_cpf is null then "CNPJ: "||gera_cnpj else "CPF: "||gera_cpf end from geral';
   for InI:=1 to 3 do
   begin
      if TLabel(FindComponent('LabelAdicional'+IntToStr(InI))).Visible then
      begin
         if InI=1 then StAdicional:=StAdicional1 else if InI=2 then StAdicional:=StAdicional2 else StAdicional:=StAdicional3;
         AtivaSQL(DMCAD.QuAux,StAdicional+' where '+DbEditCodigo.DataField+'="'+DBEditCodigo.Text+'"');
         TLabel(FindComponent('LabelAdicional'+IntToStr(InI))).Caption:=DMCAD.QuAux.Fields[0].AsString;
         DMCAD.QuAux.Next;
         while not DMCAD.QuAux.Eof do
         begin
            TLabel(FindComponent('LabelAdicional'+IntToStr(InI))).Caption:=TLabel(FindComponent('LabelAdicional'+IntToStr(InI))).Caption+' - '+DMCAD.QuAux.Fields[0].AsString;
            DMCAD.QuAux.Next;
         end;
      end;
   end;
end;

// Quando entra no edit de pesquisa, adicional=''
procedure TFMPDVCliente.EditNomeEnter(Sender: TObject);
begin
   LabelAdicional1.Caption:=''; LabelAdicional2.Caption:=''; LabelAdicional3.Caption:='';
end;

// Verifica se CPF já existe
procedure TFMPDVCliente.MaskEditCPFExit(Sender: TObject);
var StNome: String;
begin
   if BitBtnIncluir.Visible then
   if Copy((Sender as TMaskEdit).Text,1,2)<>'  ' then
   begin
      if AtivaSQL(DMCad.QuAux,'select GERA_NOME from Geral where GERA_CPF="'+(Sender as TMaskEdit).Text+'"') then
      begin
         Mensagem('ATENÇÃO: CPF Já cadastrado para o cliente '+DMCad.QuAux.FieldByName('GERA_NOME').AsString+' !','&Ok','','');
         (Sender as TMaskEdit).SetFocus;
      end;
      // Se for Jeito Incomum não deixa cpf com erro
      if (FSCMenuPrincipal.InPARA_REGISTRO=4030119) then
      begin
         if not CPF((Sender as TMaskEdit).Text, False) then
         begin
            Mensagem('CPF incorreto !','&Ok','','');
            (Sender as TMaskEdit).SetFocus;
         end;
      end
      else
      begin
         if not CPF((Sender as TMaskEdit).Text, True) then (Sender as TMaskEdit).SetFocus;
      end;

      // Busca nome atracés do cpf
      if (Length(SomenteNumeros((Sender as TMaskEdit).Text))=11) and (EditNomeCom.Text='') then
      begin
         if (FSCMenuPrincipal.InPARA_REGISTRO<>4030049) then
         begin
            if Sender=MaskEditCPF then
            begin
               StNome:=ValidaCPF((Sender as TMaskEdit).Text,MaskEditNascimentoCom.Text);
               if StNome<>'' then EditNomeCom.Text:=StNome;
            end
            else
            begin
               StNome:=ValidaCPF((Sender as TMaskEdit).Text,MaskEditNascimentoRes.Text);
               if StNome<>'' then EditNomeRes.Text:=StNome;
            end;
         end;   
      end;

   end;
end;

// Verifica se não excedeu os 40 caracteres
procedure TFMPDVCliente.EditEmailComExit(Sender: TObject);
begin
   if length(Trim((Sender as TEdit).Text))>40 then
      Mensagem('ATENÇÃO: e-mail excedeu os 40 caracteres, verifique !','&Ok','','');
end;

// Confirma dados cadastrais
procedure TFMPDVCliente.BitBtnConfirmaDadosClick(Sender: TObject);
var StSelecao, StDtNascimento, StDtExpedicao, StProf, StIndicado, StCartao: String;
    BoEndNovo: Boolean;
begin

   if Copy(MaskEditNascimentoCom.Text,1,2)<>'  ' then StDtNascimento:=''''+DataSQL(StrToDate(MaskEditNascimentoCom.Text))+'''' else StDtNascimento:='Null';

   // Indicado por (não para Jeito, Makos e 3313Brotherhood )
   if (FSCMenuPrincipal.InPARA_REGISTRO<>4030119) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030049) and (FSCMenuPrincipal.InPARA_REGISTRO<>4030270) and (ComboBoxProf.Text<>'') then StIndicado:=',INDI_CODIGO='+IntToStr(ValorCampo('indicacao','indi_codigo','upper(indi_descricao)="'+ComboBoxProf.Text+'"'))+' '
   else if (FSCMenuPrincipal.InPARA_REGISTRO=4030119) and (ComboBoxIndicado.Text<>'') then StIndicado:=',INDI_CODIGO='+IntToStr(ValorCampo('indicacao','indi_codigo','upper(indi_descricao)="'+ComboBoxIndicado.Text+'"'))+' '
   else StIndicado:=' ';

   if EditFidelCartao.Text<>'' then StCartao:=',GERA_CARTAOFIDEL="'+EditFidelCartao.Text+'",GERA_NUMFIDEL='+EditFidelPontos.Text+' ' else StCartao:=' ';

   StSelecao:='update Geral set GERA_NOME="'+EditNomeCom.Text+'",GERA_RAZAO="'+EditRazao.Text+'",GERA_FISJUR="'+Copy(RadioGroupEspecie.Items[RadioGroupEspecie.ItemIndex],1,1)+'",'+
              'GERA_CPF="'+MaskEditCPF.Text+'",GERA_CNPJ="'+MaskEditCNPJ.Text+'",GERA_DTNASC='+StDtNascimento+',GERA_EMAIL="'+Copy(EditEmailCom.Text,1,40)+'" '+StIndicado+StCartao+
              'where gera_codigo="'+StCodigoCliente+'"';
   RodaSQL(DMCad.SQLAux,StSelecao);

   if RadioGroupEspecie.ItemIndex=0 then
   begin
      if Copy(MaskEditExpedicao.Text,1,2)<>'  ' then StDtExpedicao:=''''+DataSQL(StrToDate(MaskEditExpedicao.Text))+'''' else StDtExpedicao:='Null';
      if (FSCMenuPrincipal.InPARA_REGISTRO=4030119) and (ComboBoxProf.Text<>'') then StProf:=',PROF_CODIGO='+IntToStr(ValorCampo('profissao','prof_codigo','upper(prof_descricao)="'+ComboBoxProf.Text+'"')) else StProf:='';
      StSelecao:='update GerPFisica set GERA_RG="'+EditRG.Text+'",GERA_ORGAOEXP="'+EditOrgao.Text+'",GERA_DTEXPEDICAO='+StDtExpedicao+','+
                 'GERA_NOMEPAI="'+EditPai.Text+'",GERA_NOMEMAE="'+EditMae.Text+'",GERA_SEXO="'+Copy(RadioGroupSexo.Items[RadioGroupSexo.ItemIndex],1,1)+'" '+StProf+
                  'where gera_codigo="'+StCodigoCliente+'"';
      if RodaSQL(DMCad.SQLAux,StSelecao)=0 then
      begin
         if (FSCMenuPrincipal.InPARA_REGISTRO=4030119) and (ComboBoxProf.Text<>'') then StProf:=','+IntToStr(ValorCampo('profissao','prof_codigo','upper(prof_descricao)="'+ComboBoxProf.Text+'"')) else StProf:=',Null';
         StSelecao:='insert into GerPFisica (GERA_CODIGO,GERA_RG,GERA_ORGAOEXP,GERA_DTEXPEDICAO,GERA_NOMEPAI,GERA_NOMEMAE,GERA_SEXO,GERA_TAMANHO,PROF_CODIGO) values ("'+
                    StCodigoCliente+'","'+EditRG.Text+'","'+EditOrgao.Text+'",'+StDtExpedicao+',"'+
                    EditPai.Text+'","'+EditMae.Text+'","'+Copy(RadioGroupSexo.Items[RadioGroupSexo.ItemIndex],1,1)+'","'+EditTam.Text+'"'+StProf+')';
         RodaSQL(DMCad.SQLAux,StSelecao);
      end;
   end;

   if EditNumero.Text='' then EditNumero.Text:='0';

   if StEndSequencia<>'' then
   begin
      // Se mudou o endereço pergunta se quer incluir novo
      BoEndNovo:=False;
      if StEndAnterior<>EditLogradouro.Text then
         BoEndNovo:=Mensagem('Endereço foi modificado, manter o anterior e incluir um novo endereço?','&Sim','&Não','')=1;

      if BoEndNovo then
      begin
         StEndSequencia:=IntToStr(ValorCampo('gerendereco','max(gend_sequencia)','gera_codigo="'+StCodigoCliente+'"')+1);
         StSelecao:='insert into GerEndereco (GERA_CODIGO,GEND_SEQUENCIA,TLOG_CODIGO,GEND_LOGRADOURO,GEND_NUMERO,GEND_COMPLEMENTO,GEND_BAIRRO,GEND_CIDADE,GEND_UF,GEND_CEP) values ("'+
                    StCodigoCliente+'",'+StEndSequencia+',"'+EditTipoLogradouro.Text+'","'+EditLogradouro.Text+'",'+EditNumero.Text+',"'+
                    EditComplemento.Text+'","'+EditBairro.Text+'","'+EditCidade.Text+'","'+EditUF.Text+'","'+MaskEditCEP.Text+'")';
      end
      else StSelecao:='update GerEndereco set TLOG_CODIGO="'+EditTipoLogradouro.Text+'",GEND_LOGRADOURO="'+EditLogradouro.Text+'",GEND_NUMERO='+EditNumero.Text+','+
                      'GEND_COMPLEMENTO="'+EditComplemento.Text+'",GEND_BAIRRO="'+EditBairro.Text+'",GEND_CIDADE="'+EditCidade.Text+'",GEND_UF="'+EditUF.Text+'",GEND_CEP="'+MaskEditCEP.Text+'"'+
                      'where gera_codigo="'+StCodigoCliente+'" and gend_sequencia='+StEndSequencia;
      RodaSQL(DMCad.SQLAux,StSelecao);

      // Se for Babinho guarda qual endereço escolheu
      if (FSCMenuPrincipal.InPARA_REGISTRO=4030151) and (DMMOV.DaNfAluguel.State in [dsEdit, dsInsert]) then DMMOV.DaNfAluguelNFAL_ACERTO.Value:=StrToInt(StEndSequencia);

   end
   else if EditLogradouro.Text<>'' then
   begin
      StEndSequencia:=IntToStr(ValorCampo('gerendereco','max(gend_sequencia)','gera_codigo="'+StCodigoCliente+'"')+1);
      RodaSQL(DMCad.SQLAux,'insert into GerEndereco (GERA_CODIGO,GEND_SEQUENCIA,TLOG_CODIGO,GEND_LOGRADOURO,GEND_NUMERO,GEND_COMPLEMENTO,GEND_BAIRRO,GEND_CIDADE,GEND_UF,GEND_CEP) values ("'+
                            StCodigoCliente+'",'+StEndSequencia+',"'+EditTipoLogradouro.Text+'","'+EditLogradouro.Text+'",'+EditNumero.Text+',"'+
                            EditComplemento.Text+'","'+EditBairro.Text+'","'+EditCidade.Text+'","'+EditUF.Text+'","'+MaskEditCEP.Text+'")');

      // Se for Babinho guarda qual endereço escolheu
      if (FSCMenuPrincipal.InPARA_REGISTRO=4030151) and (DMMOV.DaNfAluguel.State in [dsEdit, dsInsert]) then DMMOV.DaNfAluguelNFAL_ACERTO.Value:=StrToInt(StEndSequencia);
   end;

   if Length(Trim(MaskEditTelefoneCom1.Text))=13 then
   begin
      if not AtivaSQL(DMCAD.QuAux,'select gfon_numero from GerFone where gfon_numero="'+MaskEditTelefoneCom1.Text+'" '+
                              'and gera_codigo="'+StCodigoCliente+'"')
         then RodaSQL(DMCad.SQLAux,'insert into GerFone (GERA_CODIGO,GEND_SEQUENCIA,GFON_NUMERO,gfon_tipo) values ("'+
                          StCodigoCliente+'",1,"'+MaskEditTelefoneCom1.Text+'","'+EditOper1.Text+'")');
   end;

   if Length(Trim(MaskEditTelefoneCom2.Text))=13 then
   begin
      if not AtivaSQL(DMCAD.QuAux,'select gfon_numero from GerFone where gfon_numero="'+MaskEditTelefoneCom2.Text+'" '+
                              'and gera_codigo="'+StCodigoCliente+'"')
         then RodaSQL(DMCad.SQLAux,'insert into GerFone (GERA_CODIGO,GEND_SEQUENCIA,GFON_NUMERO,gfon_tipo) values ("'+
                          StCodigoCliente+'",1,"'+MaskEditTelefoneCom2.Text+'","'+EditOper2.Text+'")');
   end;

   // Caramelo - Filhos
   if (FSCMenuPrincipal.InPARA_REGISTRO=4030152) and (EditFilho.Text<>'') then
      if not AtivaSQL(DMCAD.QuAux,'select * from GerContato where gerc_nome="'+EditFilho.Text+'" and gera_codigo="'+StCodigoCliente+'"') then
      begin
         if Copy(MaskEditNascFilho.Text,1,2)<>'  '
             then RodaSQL(DMCad.SQLAux,'insert into GerContato (GERA_CODIGO,GERC_TIPO,GERC_NOME,GERC_DTNASC) values ("'+StCodigoCliente+'","Filho","'+EditFilho.Text+'","'+DataSQL(StrToDate(MaskEditNascFilho.Text))+'")')
             else RodaSQL(DMCad.SQLAux,'insert into GerContato (GERA_CODIGO,GERC_TIPO,GERC_NOME) values ("'+StCodigoCliente+'","Filho",'+EditFilho.Text+'")');
      end;

   BoConfirmouAlt:=True;
   Close;
end;

procedure TFMPDVCliente.GroupBoxIncluirComExit(Sender: TObject);
begin
   // Se for Jeito Incomum não deixa cpf em branco
   if (BitBtnConfirmaDados.Visible) and (FSCMenuPrincipal.InPARA_REGISTRO=4030119) then
   begin
//      if Copy(MaskEditCPF.Text,1,2)='  ' then
//      begin
//         Mensagem('Preencher o cpf !','&Ok','','');
//         MaskEditCPF.SetFocus;
//      end;

      // Se for Jeito Incomum não deixa cpf com erro
      if Copy(MaskEditCPF.Text,1,2)<>'  ' then
      if not CPF(MaskEditCPF.Text, False) then
      begin
         Mensagem('CPF incorreto !','&Ok','','');
         MaskEditCPF.SetFocus;
      end;
   end;
end;

// Editar dados do cliente
procedure TFMPDVCliente.BitBtnEditarClick(Sender: TObject);
begin
   StCodigoCliente:=DMSql.QuGeralCliGERA_CODIGO.Value;
   StNomeCliente:=Trim(DMSql.QuGeralCliGERA_NOME.Value);
   BoAlterarDados:=True;
   BoConfirmouAlt:=False;
   GroupBoxIncluirCom.Caption:='Confirmação de dados cadastrais';
   BitBtnIncluirClick(Sender);
   BitBtnIncluir.Visible:=False;
   BitBtnConfirmaDados.Visible:=True;
end;

// Busca dados através do CPF/CNPJ
procedure TFMPDVCliente.BitBtnConsultaCPFClick(Sender: TObject);
var StVar,StEnd,StLograd,StTpLograd: String; InI: Integer;
begin
   // Makos
   if (FSCMenuPrincipal.InPARA_REGISTRO=4030049) and (Length(SomenteNumeros(MaskEditCPF.Text))=11) then
   begin
      ValidaCPFCompleta(Nil, Nil, Nil, Nil, MaskEditCPF.Text,'','','','','','','','','','','','','','',MemoCPF);

      EditNomeCom.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'nomeCompleto'),2,40));
      EditRazao.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'nomeCompleto'),2,40));
      StVar:=SomenteNumeros((ValorChaveJSon(MemoCPF.Lines.Text,'dataDeNascimento')));
      StVar:=Copy(StVar,1,2)+'/'+Copy(StVar,3,2)+'/'+Copy(StVar,5,4);
      MaskEditNascimentoCom.Text:=StVar;
      EditEmailCom.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'enderecoEmail'),2,50));

      StEnd:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'logradouro'),2,50));
      if (StEnd<>'') then
      begin
         StTpLograd:=''; StLograd:=Copy(StEnd,1,40);
         for InI:=1 to 40 do
         begin
            if Copy(StEnd,InI,1)=' ' then
            begin
               StLograd:=Copy(StEnd,InI+1,40);
               Break;
            end;
            StTpLograd:=StTpLograd+Copy(StEnd,InI,1);
         end;
         EditTipoLogradouro.Text:=Copy(StTpLograd,1,4);
         EditLogradouro.Text:=StLograd;
         if Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'numero'),2,10))<>'' then
            EditNumero.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'numero'),2,10))
         else EditNumero.Text:='0';
         EditComplemento.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'complemento'),2,10));
         EditBairro.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'bairro'),2,35));
         EditCidade.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'cidade'),2,30));
         EditUF.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'uf'),2,2));
         MaskEditCEP.Text:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'cep'),2,10));
         StVar:=Trim(Copy(ValorChaveJSon(MemoCPF.Lines.Text,'telefoneComDDD'),2,20));
         StVar:=Copy(StVar,1,4)+SomenteNumeros(Copy(StVar,5,15));
         if (StVar<>'') then MaskEditTelefoneCom1.Text:=StVar;
      end;
   end;
end;

function TFMPDVCliente.PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I, X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
  begin
    Result := Pos(SubStr, S);
    Exit;
  end;

  LenSubStr := Length(SubStr);
  Len := Length(S);

  if (LenSubStr = 0) or (Len = 0) or (Offset > Cardinal(Len)) then
  begin
    Result := 0;
    Exit;
  end;

  for I := Offset to Len - LenSubStr + 1 do
  begin
    X := 1;
    while (X <= LenSubStr) and (S[I + X - 1] = SubStr[X]) do
      Inc(X);
    if X > LenSubStr then
    begin
      Result := I;
      Exit;
    end;
  end;

  Result := 0;
end;

// Função para extrair os valores da chave JSON dentro de um array
function TFMPDVCliente.ValoresChaveJSonArray(StJSon, StChave: String): TStringList;
var
  InPos, InC, InStart, InEnd: Integer;
  TempStr, Value: String;
begin
  Result := TStringList.Create;
  try
    // Remove espaços desnecessários
    StJSon := StringReplace(StJSon, ' :', ':', [rfReplaceAll]);
    StJSon := StringReplace(StJSon, ': ', ':', [rfReplaceAll]);
    StJSon := StringReplace(StJSon, '},', '}|', [rfReplaceAll]); // Separador para arrays

    // Encontra a posição da chave
    InPos := Pos(StChave, StJSon);
    if InPos > 0 then
    begin
      // Encontra o início e o fim do array
      InStart := PosEx('[', StJSon, InPos) + 1;
      InEnd := PosEx(']', StJSon, InStart) - 1;
      TempStr := Copy(StJSon, InStart, InEnd - InStart + 1);

      InC := 1;
      while InC <= Length(TempStr) do
      begin
        if TempStr[InC] = '{' then
        begin
          InStart := InC + 1;
          InEnd := PosEx('}', TempStr, InStart) - 1;
          Value := Copy(TempStr, InStart, InEnd - InStart + 1);

          // Extraímos o valor da chave "enderecoEmail"
          Result.Add(ValorChaveJSon(Value, 'enderecoEmail'));
          InC := InEnd + 1; // Avança o índice para além do final do objeto atual
        end
        else
        begin
          Inc(InC);
        end;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TFMPDVCliente.Button1Click(Sender: TObject);
var
  Emails: TStringList;
  InI: Integer;
begin
  Emails := ValoresChaveJSonArray(MemoCPF.Lines.Text, 'listaEmails');
  try
    for InI := 0 to Emails.Count - 1 do
    begin
      ShowMessage(Emails[InI]);
    end;
  finally
    Emails.Free;
  end;
end;

end.
