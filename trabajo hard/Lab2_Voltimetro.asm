
_TX_High:

;Lab2_Voltimetro.mpas,7 :: 		begin
;Lab2_Voltimetro.mpas,8 :: 		GPIO := GPIO or $20;     { GP5 = 1 }
	BSF        GPIO+0, 5
;Lab2_Voltimetro.mpas,9 :: 		end;
L_end_TX_High:
	RETURN
; end of _TX_High

_TX_Low:

;Lab2_Voltimetro.mpas,12 :: 		begin
;Lab2_Voltimetro.mpas,13 :: 		GPIO := GPIO and $DF;    { GP5 = 0 }
	MOVLW      223
	ANDWF      GPIO+0, 1
;Lab2_Voltimetro.mpas,14 :: 		end;
L_end_TX_Low:
	RETURN
; end of _TX_Low

_Serial_Write_Byte:

;Lab2_Voltimetro.mpas,19 :: 		begin
;Lab2_Voltimetro.mpas,20 :: 		TX_Low;                  { bit de inicio }
	CALL       _TX_Low+0
;Lab2_Voltimetro.mpas,21 :: 		Delay_us(BIT_TIME);
	MOVLW      34
	MOVWF      R13+0
L__Serial_Write_Byte3:
	DECFSZ     R13+0, 1
	GOTO       L__Serial_Write_Byte3
	NOP
;Lab2_Voltimetro.mpas,23 :: 		for i := 0 to 7 do
	CLRF       Serial_Write_Byte_i+0
L__Serial_Write_Byte5:
;Lab2_Voltimetro.mpas,25 :: 		if (dato and 1) = 1 then
	MOVLW      1
	ANDWF      FARG_Serial_Write_Byte_dato+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__Serial_Write_Byte10
;Lab2_Voltimetro.mpas,26 :: 		TX_High
	CALL       _TX_High+0
	GOTO       L__Serial_Write_Byte11
;Lab2_Voltimetro.mpas,27 :: 		else
L__Serial_Write_Byte10:
;Lab2_Voltimetro.mpas,28 :: 		TX_Low;
	CALL       _TX_Low+0
L__Serial_Write_Byte11:
;Lab2_Voltimetro.mpas,30 :: 		Delay_us(BIT_TIME);
	MOVLW      34
	MOVWF      R13+0
L__Serial_Write_Byte12:
	DECFSZ     R13+0, 1
	GOTO       L__Serial_Write_Byte12
	NOP
;Lab2_Voltimetro.mpas,31 :: 		dato := dato shr 1;
	RRF        FARG_Serial_Write_Byte_dato+0, 1
	BCF        FARG_Serial_Write_Byte_dato+0, 7
;Lab2_Voltimetro.mpas,32 :: 		end;
	MOVF       Serial_Write_Byte_i+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L__Serial_Write_Byte8
	INCF       Serial_Write_Byte_i+0, 1
	GOTO       L__Serial_Write_Byte5
L__Serial_Write_Byte8:
;Lab2_Voltimetro.mpas,35 :: 		Delay_us(BIT_TIME);
	MOVLW      34
	MOVWF      R13+0
L__Serial_Write_Byte13:
	DECFSZ     R13+0, 1
	GOTO       L__Serial_Write_Byte13
	NOP
;Lab2_Voltimetro.mpas,36 :: 		end;
L_end_Serial_Write_Byte:
	RETURN
; end of _Serial_Write_Byte

_main:

;Lab2_Voltimetro.mpas,38 :: 		begin
;Lab2_Voltimetro.mpas,39 :: 		CMCON := 7;      { apaga comparadores }
	MOVLW      7
	MOVWF      CMCON+0
;Lab2_Voltimetro.mpas,40 :: 		ANSEL := 0;      { por ahora todo digital }
	CLRF       ANSEL+0
;Lab2_Voltimetro.mpas,41 :: 		TRISIO := $1F;   { GP0-GP4 entradas, GP5 salida }
	MOVLW      31
	MOVWF      TRISIO+0
;Lab2_Voltimetro.mpas,42 :: 		GPIO := 0;
	CLRF       GPIO+0
;Lab2_Voltimetro.mpas,44 :: 		TX_High;
	CALL       _TX_High+0
;Lab2_Voltimetro.mpas,45 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L__main15:
	DECFSZ     R13+0, 1
	GOTO       L__main15
	DECFSZ     R12+0, 1
	GOTO       L__main15
	DECFSZ     R11+0, 1
	GOTO       L__main15
	NOP
	NOP
;Lab2_Voltimetro.mpas,48 :: 		Serial_Write_Byte(254);
	MOVLW      254
	MOVWF      FARG_Serial_Write_Byte_dato+0
	CALL       _Serial_Write_Byte+0
;Lab2_Voltimetro.mpas,49 :: 		Serial_Write_Byte(1);
	MOVLW      1
	MOVWF      FARG_Serial_Write_Byte_dato+0
	CALL       _Serial_Write_Byte+0
;Lab2_Voltimetro.mpas,50 :: 		Delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L__main16:
	DECFSZ     R13+0, 1
	GOTO       L__main16
	DECFSZ     R12+0, 1
	GOTO       L__main16
	NOP
;Lab2_Voltimetro.mpas,53 :: 		Serial_Write_Byte(72);   { H }
	MOVLW      72
	MOVWF      FARG_Serial_Write_Byte_dato+0
	CALL       _Serial_Write_Byte+0
;Lab2_Voltimetro.mpas,54 :: 		Serial_Write_Byte(79);   { O }
	MOVLW      79
	MOVWF      FARG_Serial_Write_Byte_dato+0
	CALL       _Serial_Write_Byte+0
;Lab2_Voltimetro.mpas,55 :: 		Serial_Write_Byte(76);   { L }
	MOVLW      76
	MOVWF      FARG_Serial_Write_Byte_dato+0
	CALL       _Serial_Write_Byte+0
;Lab2_Voltimetro.mpas,56 :: 		Serial_Write_Byte(65);   { A }
	MOVLW      65
	MOVWF      FARG_Serial_Write_Byte_dato+0
	CALL       _Serial_Write_Byte+0
;Lab2_Voltimetro.mpas,58 :: 		while true do
L__main18:
	GOTO       L__main18
;Lab2_Voltimetro.mpas,61 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
