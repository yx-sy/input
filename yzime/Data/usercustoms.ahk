; 用户自定义文件 参考示例  https://gitee.com/orz707/Yzime/wikis/%E8%87%AA%E5%AE%9A%E4%B9%89%E8%AE%BE%E7%BD%AE%E8%BF%9B%E9%98%B6?sort_id=1885698
;==============================================================================================================
;修改Shift为单击切换中英文，双击禁用输入法（相当于CTR+Alt+F12）
dobuleDisable(){
	global
	Suspend, Permit
	If !A_IsSuspended
		Gosub srfSwitch
	If (A_PriorHotkey=A_ThisHotkey)&&(A_TimeSincePriorHotkey<400)
		Gosub srfsuspend
}
Hotkey If, !(srf_inputing&&Switch~="Shift")
Hotkey, %Switch%, dobuleDisable          ; Hotkey, %热键变量%, 无必要参数的函数
Hotkey If
;==============================================================================================================
;修改“~”为中文标点"～"
srf_symbol["~",2]:="～"
;修改“/”中文标点”、“
;srf_symbol["/",2]:="、"
;==============================================================================================================
; keylist 589行
;鼠标点击悬浮中英显示时间调整
xuanfuxianshi(){
	global srf_inputing, srf_mode, TSFmode
	If (!srf_inputing){
		If (!srf_mode && !TSFmode)
			SetIMEStatus()
		If (Caret_:=GetCaretPos()).t="Mouse"
			ToolTip
		Else {
			fg:=(!(srf_mode&&srf_inputing)&&GetKeyState("CapsLock", "T")?"Ａ":srf_mode||(!TSFmode&&IME_GETOPENSTATUS())?"中":"英")
			ToolTip, % fg, Caret_.X+5, Caret_.Y+30
			SetYzLogo(fg="中", 0)
			SetTimer, ToolTipOff, -300
		}
	}
}
;==============================================================================================================
; keylist 606行
;鼠标点击悬浮显示中英
Hotkey, ~LButton Up, LBut

LBut(){
	If (!srf_inputing)
		xuanfuxianshi()
}
;==============================================================================================================
; 将;加入码元
; Hotkey If, % cncharmode_funobj
; Hotkey, `;, cninputchar, On
; Hotkey If
;==============================================================================================================
