#include 'protheus.ch'
#include 'parmtype.ch'
#Include "Totvs.ch"

/*
	Este fonte pretende facilitar o processo de recuperação de tabelas
	que foram dropadas.
	
	O sistema ira recriar a tabela, caso ela não exita, ao executar a
	função dbSelectArea(). O sistema usa dados do dicionário para definir
	campos, tamanhos e tipos de dados.
	
	A função recriTab() pode ser
	chamada através da tela inicial do smartClient "U_RECRITAB"
*/

#DEFINE EMP "99"				// Coloque aqui o código  da empresa antes de compilar
#DEFINE FIL "01"				// Coloque aqui o código  da filial antes de compilar
#DEFINE USUARIO "admin"		// Coloque aqui o código  do usuário antes de compilar
#DEFINE SENHA ""				// Coloque aqui a senha antes de compilar
#DEFINE AMBIENTE "FIN"			// Coloque aqui o código  referente ao ambiente antes de compilar
#DEFINE ROTINA "FINA100"		// Coloque aqui o nome da rotina antes de compilar
#DEFINE TABELAS {"SB1"}		// Coloque aqui o alias das tabelas a serem usadas antes de compilar

user function recriTab()
	Local cAlias
	Local aArea := FWGetArea()

	cAlias := FWInputBox('Digite o alias da tabela que deseja recriar com 3 caracteres. Ex.: "SB1"', '')
	RpcSetType(3)
	RPCSetEnv(EMP, FIL, USUARIO, SENHA, AMBIENTE, ROTINA, TABELAS)
	dbSelectArea(cAlias)

	FWRestArea(aArea)
	FWAlertInfo("Fim da rotina recupTab()", "Concluido")
return 
