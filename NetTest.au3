;AutoItSetOption("MustDeclareVars", 1)
#include <Debug.au3>
;_DebugSetup ("Debug ativado",true)

#NoTrayIcon

TraySetState()

_DebugReport ("Entrando no While", false)
While 1
	
	_DebugReport ("    Carregando destino...", false)
	$destino = _loadNetTestHostDestConfig();
	_DebugReport ("    destino carregado: "& $destino, false)
	_DebugReport ("    Carregando pingTestReturnTime... ", false)
	$pingTestReturnTime = _sinalTestPingExecuting($destino)
	_DebugReport ("    pingTestReturnTime carregado: "& $pingTestReturnTime, false)
	_DebugReport ("    Executando _sinalOnTime... ", false)
	_sinalOnTime($pingTestReturnTime)
	_DebugReport ("    _sinalOnTime executado.", false)
Wend

Func _sinalOnTime($time)
	_DebugReport ("		Func _sinalOnTime("&$time&")", false)
	If $time = 0 Then
		_DebugReport ("		Func _sinalOnTime("&$time&") --- Chamando _trayIconFail()", false)
		_trayIconFail()

	Else
		_DebugReport ("		Func _sinalOnTime("&$time&") --- Chamando _trayIconOK()", false)
		_trayIconOK()
	EndIf	
	Sleep(8000)
EndFunc

Func _sinalTestPingExecuting($destino)
	_trayIconBusy()
	Return _pingTest($destino)
EndFunc

Func _trayIconFail()
	TraySetIcon("OnLineBusy.ico")
EndFunc

Func _trayIconOK()
	TraySetIcon("ONLINE.ICO")
EndFunc

Func _trayIconBusy()
	TraySetIcon("OnLineIdle.ico")
EndFunc

Func _pingTest($dest)
	_DebugReport ("		Func _pingTest($dest))", false)		
	Ping($dest)
	$error = @error
	_DebugReport ("		Func _pingTest($dest) --> $pingVar = Ping($dest)", false)	
	_DebugReport ("		Func _pingTest($dest) --> $pingVar = "& $error, false)	
	If $error Then
		$pingVar = 0
	Else
		$pingVar = 1
	EndIf
	Return $pingVar
EndFunc

Func _LoadConfig($goup,$iten,$failCase)
	return IniRead("config.ini", $goup, $iten,$failCase)
EndFunc

Func _loadNetTestHostDestConfig()
	return _LoadConfig("nettest","host","8.8.8.8")
EndFunc
