
_MCU_Init:

;weather.c,23 :: 		void MCU_Init()
;weather.c,25 :: 		ANSELA = 0x00;
	CLRF        ANSELA+0 
;weather.c,26 :: 		ANSELB = 0x00;
	CLRF        ANSELB+0 
;weather.c,27 :: 		ANSELC = 0x00;
	CLRF        ANSELC+0 
;weather.c,28 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;weather.c,29 :: 		ANSELE = 0x00;
	CLRF        ANSELE+0 
;weather.c,31 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;weather.c,32 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;weather.c,33 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;weather.c,34 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;weather.c,35 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;weather.c,37 :: 		LATA = 0x00;
	CLRF        LATA+0 
;weather.c,38 :: 		LATB = 0x00;
	CLRF        LATB+0 
;weather.c,39 :: 		LATC = 0x00;
	CLRF        LATC+0 
;weather.c,40 :: 		LATD = 0x00;
	CLRF        LATD+0 
;weather.c,41 :: 		LATE = 0x00;
	CLRF        LATE+0 
;weather.c,43 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_MCU_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_MCU_Init0
	DECFSZ      R12, 1, 1
	BRA         L_MCU_Init0
	NOP
;weather.c,45 :: 		I2C1_Init(10000);
	MOVLW       200
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;weather.c,46 :: 		Delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_MCU_Init1:
	DECFSZ      R13, 1, 1
	BRA         L_MCU_Init1
	DECFSZ      R12, 1, 1
	BRA         L_MCU_Init1
	DECFSZ      R11, 1, 1
	BRA         L_MCU_Init1
;weather.c,48 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;weather.c,49 :: 		Delay_ms(150);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_MCU_Init2:
	DECFSZ      R13, 1, 1
	BRA         L_MCU_Init2
	DECFSZ      R12, 1, 1
	BRA         L_MCU_Init2
	DECFSZ      R11, 1, 1
	BRA         L_MCU_Init2
;weather.c,50 :: 		}
L_end_MCU_Init:
	RETURN      0
; end of _MCU_Init

_BME280_Init:

;weather.c,52 :: 		void BME280_Init()
;weather.c,55 :: 		id = BME280_GetID();
	CALL        _BME280_GetID+0, 0
	MOVF        R0, 0 
	MOVWF       BME280_Init_id_L0+0 
;weather.c,57 :: 		if(id == BME280_ID)
	MOVF        R0, 0 
	XORLW       96
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Init3
;weather.c,59 :: 		BME280_SoftReset();
	CALL        _BME280_SoftReset+0, 0
;weather.c,60 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_BME280_Init4:
	DECFSZ      R13, 1, 1
	BRA         L_BME280_Init4
	DECFSZ      R12, 1, 1
	BRA         L_BME280_Init4
	DECFSZ      R11, 1, 1
	BRA         L_BME280_Init4
	NOP
	NOP
;weather.c,61 :: 		BME280_GetCalibData();
	CALL        _BME280_GetCalibData+0, 0
;weather.c,62 :: 		BME280_SetTemperatureOversamp(OVERSAMP_X1);
	MOVLW       1
	MOVWF       FARG_BME280_SetTemperatureOversamp_value+0 
	CALL        _BME280_SetTemperatureOversamp+0, 0
;weather.c,63 :: 		BME280_SetPressureOversamp(OVERSAMP_X2);
	MOVLW       2
	MOVWF       FARG_BME280_SetPressureOversamp_value+0 
	CALL        _BME280_SetPressureOversamp+0, 0
;weather.c,64 :: 		BME280_SetHumidityOversamp(OVERSAMP_X1);
	MOVLW       1
	MOVWF       FARG_BME280_SetHumidityOversamp_value+0 
	CALL        _BME280_SetHumidityOversamp+0, 0
;weather.c,65 :: 		}
	GOTO        L_BME280_Init5
L_BME280_Init3:
;weather.c,68 :: 		while(1)
L_BME280_Init6:
;weather.c,70 :: 		LATB = id;
	MOVF        BME280_Init_id_L0+0, 0 
	MOVWF       LATB+0 
;weather.c,71 :: 		LATD = ~LATD;
	COMF        LATD+0, 1 
;weather.c,72 :: 		UART1_Write_Text(" Wrong chip ID!!! ");
	MOVLW       ?lstr1_weather+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_weather+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,73 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,74 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,75 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_BME280_Init8:
	DECFSZ      R13, 1, 1
	BRA         L_BME280_Init8
	DECFSZ      R12, 1, 1
	BRA         L_BME280_Init8
	DECFSZ      R11, 1, 1
	BRA         L_BME280_Init8
	NOP
	NOP
;weather.c,76 :: 		}
	GOTO        L_BME280_Init6
;weather.c,77 :: 		}
L_BME280_Init5:
;weather.c,78 :: 		}
L_end_BME280_Init:
	RETURN      0
; end of _BME280_Init

_main:

;weather.c,80 :: 		void main()
;weather.c,88 :: 		MCU_Init();
	CALL        _MCU_Init+0, 0
;weather.c,89 :: 		BME280_Init();
	CALL        _BME280_Init+0, 0
;weather.c,91 :: 		while(1)
L_main9:
;weather.c,94 :: 		BME280_SetWorkingMode(FORCED_MODE);
	MOVLW       1
	MOVWF       FARG_BME280_SetWorkingMode_value+0 
	CALL        _BME280_SetWorkingMode+0, 0
;weather.c,95 :: 		BME280_BurstRead();
	CALL        _BME280_BurstRead+0, 0
;weather.c,96 :: 		temperature = BME280_GetTemperature();
	CALL        _BME280_GetTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       main_temperature_L0+0 
	MOVF        R1, 0 
	MOVWF       main_temperature_L0+1 
	MOVF        R2, 0 
	MOVWF       main_temperature_L0+2 
	MOVF        R3, 0 
	MOVWF       main_temperature_L0+3 
;weather.c,97 :: 		pressure = BME280_GetPressure();
	CALL        _BME280_GetPressure+0, 0
	MOVF        R0, 0 
	MOVWF       main_pressure_L0+0 
	MOVF        R1, 0 
	MOVWF       main_pressure_L0+1 
	MOVF        R2, 0 
	MOVWF       main_pressure_L0+2 
	MOVF        R3, 0 
	MOVWF       main_pressure_L0+3 
;weather.c,98 :: 		humidity = BME280_GetHumidity();
	CALL        _BME280_GetHumidity+0, 0
	MOVF        R0, 0 
	MOVWF       main_humidity_L0+0 
	MOVF        R1, 0 
	MOVWF       main_humidity_L0+1 
	MOVF        R2, 0 
	MOVWF       main_humidity_L0+2 
	MOVF        R3, 0 
	MOVWF       main_humidity_L0+3 
;weather.c,100 :: 		sprintf(tmp, "%.2f", temperature);
	MOVLW       main_tmp_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_tmp_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_2_weather+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_2_weather+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_2_weather+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_temperature_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_temperature_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        main_temperature_L0+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        main_temperature_L0+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;weather.c,101 :: 		UART1_Write_Text("0000");
	MOVLW       ?lstr3_weather+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_weather+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,102 :: 		UART1_Write_Text(tmp);
	MOVLW       main_tmp_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_tmp_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,103 :: 		UART1_Write('T');
	MOVLW       84
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,104 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,105 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,107 :: 		sprintf(press, "%.2f", pressure);
	MOVLW       main_press_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_press_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_4_weather+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_4_weather+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_4_weather+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_pressure_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_pressure_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        main_pressure_L0+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        main_pressure_L0+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;weather.c,108 :: 		UART1_Write_Text("000");
	MOVLW       ?lstr5_weather+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_weather+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,109 :: 		UART1_Write_Text(press);
	MOVLW       main_press_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_press_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,110 :: 		UART1_Write_Text("P");
	MOVLW       ?lstr6_weather+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_weather+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,111 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,112 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,114 :: 		sprintf(hum, "%.2f", humidity);
	MOVLW       main_hum_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_hum_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_7_weather+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_7_weather+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_7_weather+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_humidity_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_humidity_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        main_humidity_L0+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        main_humidity_L0+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;weather.c,115 :: 		UART1_Write_Text("0000");
	MOVLW       ?lstr8_weather+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_weather+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,116 :: 		UART1_Write_Text(hum);
	MOVLW       main_hum_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_hum_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,117 :: 		UART1_Write_Text("H");
	MOVLW       ?lstr9_weather+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_weather+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;weather.c,118 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,119 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;weather.c,121 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	DECFSZ      R11, 1, 1
	BRA         L_main11
	NOP
	NOP
;weather.c,122 :: 		}
	GOTO        L_main9
;weather.c,125 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
