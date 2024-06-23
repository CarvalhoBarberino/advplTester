#Include 'Protheus.CH'
#include 'RWMAKE.CH'
#include 'parmtype.ch'
#Include 'Totvs.ch'

#DEFINE senhaChumbadaNofonte '1234' // Coloque aqui a senha que vc deseja antes de compilar
#DEFINE funcaoChubadaNoFonte 'altMovBanc' // Coloque aqui a fun��o que vc deseja executar autom�ticamente antes de compilar

Static Function fOK()
	If ALLTRIM(cSenha)<> cSenhAce
		MsgStop('Senha n�o Confere !!!')
		cSenha := Space(10)
		dlgRefresh(Senhadlg)
	Else
		_lReturn := .T.
		Senhadlg:End()
	Endif
Return

Static Function fDigSenha()
	Private Senhadlg, oGet
	Private cSenha   := Space(20)

	DEFINE DIALOG Senhadlg TITLE OemToAnsi('Libera��o de Acesso') FROM 80,80 TO 200,300 PIXEL
	@ 010,010 Say OemToAnsi('Informe a senha para o acesso ?')		Size 150,8 OF Senhadlg PIXEL
	@ 020,010 GET oGet VAR cSenha									SIZE 50,12 OF Senhadlg PIXEL PASSWORD
	@ 040,060 BUTTON 'Ok'											SIZE 30,14 PIXEL ACTION (fOK())
	@ 040,010 BUTTON 'Sair'											SIZE 30,14 PIXEL ACTION Senhadlg:End()
	ACTIVATE DIALOG Senhadlg CENTERED

Return(_lReturn)

user function Chamafun()
	Local cFunc
	Private _lReturn	:= .F.
	Private cSenhAce	:= senhaChumbadaNofonte
	IF !fDigSenha()
		Return
	Endif
	cFunc:=	ALLTRIM(FWInputBox('Digite a User Function que deseja chamar', ''))
	IF !Empty(cFunc)
		IF UPPER(LEFT(cFunc,2)) == 'U_'
			cFunc := substr(cFunc,3,len(cFunc)-2)
		ENDIF
		IF ExistBlock(cFunc)
			ExecBlock(cFunc)
		ELSE
			ALERT('User Function' + cFunc + ' n�o compilada.')
		ENDIF
	else
		MsgStop('Nome de fun��o vazio.' + CRLF + 'Ent�o vai rodar a funcao chubada no fonte.' + CRLF + 'Que no caso � "' + funcaoChubadaNoFonte + '"')
		IF ExistBlock(funcaoChubadaNoFonte)
			ExecBlock(funcaoChubadaNoFonte)
		ELSE
			ALERT('User Function' + funcaoChubadaNoFonte + ' n�o compilada.')
		ENDIF
	endif
return
