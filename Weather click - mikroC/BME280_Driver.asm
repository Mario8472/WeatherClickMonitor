
BME280_Driver_BME280_Write:

;BME280_Driver.c,21 :: 		static void BME280_Write(unsigned short reg_addr, unsigned short wData)
;BME280_Driver.c,23 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;BME280_Driver.c,24 :: 		I2C1_Wr(BME280_W);
	MOVLW       236
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,25 :: 		I2C1_Wr(reg_addr);
	MOVF        FARG_BME280_Driver_BME280_Write_reg_addr+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,26 :: 		I2C1_Wr(wData);
	MOVF        FARG_BME280_Driver_BME280_Write_wData+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,27 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;BME280_Driver.c,28 :: 		}
L_end_BME280_Write:
	RETURN      0
; end of BME280_Driver_BME280_Write

BME280_Driver_BME280_Read:

;BME280_Driver.c,31 :: 		static unsigned short BME280_Read(unsigned short reg_addr)
;BME280_Driver.c,35 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;BME280_Driver.c,36 :: 		I2C1_Wr(BME280_W);
	MOVLW       236
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,37 :: 		I2C1_Wr(reg_addr);
	MOVF        FARG_BME280_Driver_BME280_Read_reg_addr+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,38 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;BME280_Driver.c,39 :: 		I2C1_Wr(BME280_R);
	MOVLW       237
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,40 :: 		value = I2C1_Rd(0u);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       BME280_Driver_BME280_Read_value_L0+0 
;BME280_Driver.c,41 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;BME280_Driver.c,43 :: 		return value;
	MOVF        BME280_Driver_BME280_Read_value_L0+0, 0 
	MOVWF       R0 
;BME280_Driver.c,44 :: 		}
L_end_BME280_Read:
	RETURN      0
; end of BME280_Driver_BME280_Read

_BME280_BurstRead:

;BME280_Driver.c,48 :: 		void BME280_BurstRead()
;BME280_Driver.c,53 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;BME280_Driver.c,54 :: 		I2C1_Wr(BME280_W);
	MOVLW       236
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,55 :: 		I2C1_Wr(PRESS_MSB);
	MOVLW       247
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,56 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;BME280_Driver.c,57 :: 		I2C1_Wr(BME280_R);
	MOVLW       237
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;BME280_Driver.c,59 :: 		for (i = 0; i <= 6; i++)
	CLRF        BME280_BurstRead_i_L0+0 
	CLRF        BME280_BurstRead_i_L0+1 
L_BME280_BurstRead0:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       BME280_BurstRead_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BME280_BurstRead13
	MOVF        BME280_BurstRead_i_L0+0, 0 
	SUBLW       6
L__BME280_BurstRead13:
	BTFSS       STATUS+0, 0 
	GOTO        L_BME280_BurstRead1
;BME280_Driver.c,61 :: 		burst_data[i] =  I2C1_Rd(1);
	MOVLW       BME280_BurstRead_burst_data_L0+0
	ADDWF       BME280_BurstRead_i_L0+0, 0 
	MOVWF       FLOC__BME280_BurstRead+0 
	MOVLW       hi_addr(BME280_BurstRead_burst_data_L0+0)
	ADDWFC      BME280_BurstRead_i_L0+1, 0 
	MOVWF       FLOC__BME280_BurstRead+1 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__BME280_BurstRead+0, FSR1L+0
	MOVFF       FLOC__BME280_BurstRead+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;BME280_Driver.c,59 :: 		for (i = 0; i <= 6; i++)
	INFSNZ      BME280_BurstRead_i_L0+0, 1 
	INCF        BME280_BurstRead_i_L0+1, 1 
;BME280_Driver.c,62 :: 		}
	GOTO        L_BME280_BurstRead0
L_BME280_BurstRead1:
;BME280_Driver.c,63 :: 		burst_data[i+1] = I2C1_Rd(0u);
	MOVLW       1
	ADDWF       BME280_BurstRead_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      BME280_BurstRead_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       BME280_BurstRead_burst_data_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__BME280_BurstRead+0 
	MOVLW       hi_addr(BME280_BurstRead_burst_data_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__BME280_BurstRead+1 
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__BME280_BurstRead+0, FSR1L+0
	MOVFF       FLOC__BME280_BurstRead+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;BME280_Driver.c,66 :: 		adc_p  = (unsigned long)burst_data[0] << 12;      //PRESS_MSB
	MOVF        BME280_BurstRead_burst_data_L0+0, 0 
	MOVWF       _adc_p+0 
	MOVLW       0
	MOVWF       _adc_p+1 
	MOVWF       _adc_p+2 
	MOVWF       _adc_p+3 
	MOVLW       12
	MOVWF       R0 
	MOVF        R0, 0 
L__BME280_BurstRead14:
	BZ          L__BME280_BurstRead15
	RLCF        _adc_p+0, 1 
	BCF         _adc_p+0, 0 
	RLCF        _adc_p+1, 1 
	RLCF        _adc_p+2, 1 
	RLCF        _adc_p+3, 1 
	ADDLW       255
	GOTO        L__BME280_BurstRead14
L__BME280_BurstRead15:
;BME280_Driver.c,67 :: 		adc_p |= (unsigned long)burst_data[1] << 4;       //PRESS_LSB
	MOVF        BME280_BurstRead_burst_data_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVLW       4
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__BME280_BurstRead16:
	BZ          L__BME280_BurstRead17
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__BME280_BurstRead16
L__BME280_BurstRead17:
	MOVF        R0, 0 
	IORWF       _adc_p+0, 1 
	MOVF        R1, 0 
	IORWF       _adc_p+1, 1 
	MOVF        R2, 0 
	IORWF       _adc_p+2, 1 
	MOVF        R3, 0 
	IORWF       _adc_p+3, 1 
;BME280_Driver.c,68 :: 		adc_p |= (unsigned long)burst_data[2] >> 4;       //PRESS_XLSB
	MOVF        BME280_BurstRead_burst_data_L0+2, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVLW       4
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__BME280_BurstRead18:
	BZ          L__BME280_BurstRead19
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L__BME280_BurstRead18
L__BME280_BurstRead19:
	MOVF        R0, 0 
	IORWF       _adc_p+0, 1 
	MOVF        R1, 0 
	IORWF       _adc_p+1, 1 
	MOVF        R2, 0 
	IORWF       _adc_p+2, 1 
	MOVF        R3, 0 
	IORWF       _adc_p+3, 1 
;BME280_Driver.c,70 :: 		adc_t  = (unsigned long)burst_data[3] << 12;      //TEMP_MSB
	MOVF        BME280_BurstRead_burst_data_L0+3, 0 
	MOVWF       _adc_t+0 
	MOVLW       0
	MOVWF       _adc_t+1 
	MOVWF       _adc_t+2 
	MOVWF       _adc_t+3 
	MOVLW       12
	MOVWF       R0 
	MOVF        R0, 0 
L__BME280_BurstRead20:
	BZ          L__BME280_BurstRead21
	RLCF        _adc_t+0, 1 
	BCF         _adc_t+0, 0 
	RLCF        _adc_t+1, 1 
	RLCF        _adc_t+2, 1 
	RLCF        _adc_t+3, 1 
	ADDLW       255
	GOTO        L__BME280_BurstRead20
L__BME280_BurstRead21:
;BME280_Driver.c,71 :: 		adc_t |= (unsigned long)burst_data[4] << 4;       //TEMP_LSB
	MOVF        BME280_BurstRead_burst_data_L0+4, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVLW       4
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__BME280_BurstRead22:
	BZ          L__BME280_BurstRead23
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__BME280_BurstRead22
L__BME280_BurstRead23:
	MOVF        R0, 0 
	IORWF       _adc_t+0, 1 
	MOVF        R1, 0 
	IORWF       _adc_t+1, 1 
	MOVF        R2, 0 
	IORWF       _adc_t+2, 1 
	MOVF        R3, 0 
	IORWF       _adc_t+3, 1 
;BME280_Driver.c,72 :: 		adc_t |= (unsigned long)burst_data[5] >> 4;       //TEMP_XLSB
	MOVF        BME280_BurstRead_burst_data_L0+5, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVLW       4
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__BME280_BurstRead24:
	BZ          L__BME280_BurstRead25
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L__BME280_BurstRead24
L__BME280_BurstRead25:
	MOVF        R0, 0 
	IORWF       _adc_t+0, 1 
	MOVF        R1, 0 
	IORWF       _adc_t+1, 1 
	MOVF        R2, 0 
	IORWF       _adc_t+2, 1 
	MOVF        R3, 0 
	IORWF       _adc_t+3, 1 
;BME280_Driver.c,74 :: 		adc_h  = (unsigned long)burst_data[6] << 8;       //HUM_MSB
	MOVF        BME280_BurstRead_burst_data_L0+6, 0 
	MOVWF       _adc_h+0 
	MOVLW       0
	MOVWF       _adc_h+1 
	MOVWF       _adc_h+2 
	MOVWF       _adc_h+3 
	MOVF        _adc_h+2, 0 
	MOVWF       _adc_h+3 
	MOVF        _adc_h+1, 0 
	MOVWF       _adc_h+2 
	MOVF        _adc_h+0, 0 
	MOVWF       _adc_h+1 
	CLRF        _adc_h+0 
;BME280_Driver.c,75 :: 		adc_h |= (unsigned long)burst_data[7];            //HUM_LSB
	MOVF        BME280_BurstRead_burst_data_L0+7, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R0, 0 
	IORWF       _adc_h+0, 1 
	MOVF        R1, 0 
	IORWF       _adc_h+1, 1 
	MOVF        R2, 0 
	IORWF       _adc_h+2, 1 
	MOVF        R3, 0 
	IORWF       _adc_h+3, 1 
;BME280_Driver.c,76 :: 		}
L_end_BME280_BurstRead:
	RETURN      0
; end of _BME280_BurstRead

_BME280_GetCalibData:

;BME280_Driver.c,79 :: 		void BME280_GetCalibData()
;BME280_Driver.c,84 :: 		msb = BME280_Read(CALIB01);
	MOVLW       137
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,85 :: 		lsb = BME280_Read(CALIB00);
	MOVLW       136
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,86 :: 		dig_T1 = ((unsigned int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_T1+0 
	MOVLW       0
	MOVWF       _dig_T1+1 
	MOVF        _dig_T1+0, 0 
	MOVWF       _dig_T1+1 
	CLRF        _dig_T1+0 
	MOVF        R0, 0 
	ADDWF       _dig_T1+0, 1 
	MOVLW       0
	ADDWFC      _dig_T1+1, 1 
;BME280_Driver.c,88 :: 		msb = BME280_Read(CALIB03);
	MOVLW       139
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,89 :: 		lsb = BME280_Read(CALIB02);
	MOVLW       138
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,90 :: 		dig_T2 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_T2+0 
	MOVLW       0
	MOVWF       _dig_T2+1 
	MOVF        _dig_T2+0, 0 
	MOVWF       _dig_T2+1 
	CLRF        _dig_T2+0 
	MOVF        R0, 0 
	ADDWF       _dig_T2+0, 1 
	MOVLW       0
	ADDWFC      _dig_T2+1, 1 
;BME280_Driver.c,92 :: 		msb = BME280_Read(CALIB05);
	MOVLW       141
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,93 :: 		lsb = BME280_Read(CALIB04);
	MOVLW       140
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,94 :: 		dig_T3 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_T3+0 
	MOVLW       0
	MOVWF       _dig_T3+1 
	MOVF        _dig_T3+0, 0 
	MOVWF       _dig_T3+1 
	CLRF        _dig_T3+0 
	MOVF        R0, 0 
	ADDWF       _dig_T3+0, 1 
	MOVLW       0
	ADDWFC      _dig_T3+1, 1 
;BME280_Driver.c,99 :: 		msb = BME280_Read(CALIB07);
	MOVLW       143
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,100 :: 		lsb = BME280_Read(CALIB06);
	MOVLW       142
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,101 :: 		dig_P1 = ((unsigned int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P1+0 
	MOVLW       0
	MOVWF       _dig_P1+1 
	MOVF        _dig_P1+0, 0 
	MOVWF       _dig_P1+1 
	CLRF        _dig_P1+0 
	MOVF        R0, 0 
	ADDWF       _dig_P1+0, 1 
	MOVLW       0
	ADDWFC      _dig_P1+1, 1 
;BME280_Driver.c,103 :: 		msb = BME280_Read(CALIB09);
	MOVLW       145
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,104 :: 		lsb = BME280_Read(CALIB08);
	MOVLW       144
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,105 :: 		dig_P2 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P2+0 
	MOVLW       0
	MOVWF       _dig_P2+1 
	MOVF        _dig_P2+0, 0 
	MOVWF       _dig_P2+1 
	CLRF        _dig_P2+0 
	MOVF        R0, 0 
	ADDWF       _dig_P2+0, 1 
	MOVLW       0
	ADDWFC      _dig_P2+1, 1 
;BME280_Driver.c,107 :: 		msb = BME280_Read(CALIB11);
	MOVLW       147
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,108 :: 		lsb = BME280_Read(CALIB10);
	MOVLW       146
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,109 :: 		dig_P3 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P3+0 
	MOVLW       0
	MOVWF       _dig_P3+1 
	MOVF        _dig_P3+0, 0 
	MOVWF       _dig_P3+1 
	CLRF        _dig_P3+0 
	MOVF        R0, 0 
	ADDWF       _dig_P3+0, 1 
	MOVLW       0
	ADDWFC      _dig_P3+1, 1 
;BME280_Driver.c,111 :: 		msb = BME280_Read(CALIB13);
	MOVLW       149
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,112 :: 		lsb = BME280_Read(CALIB12);
	MOVLW       148
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,113 :: 		dig_P4 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P4+0 
	MOVLW       0
	MOVWF       _dig_P4+1 
	MOVF        _dig_P4+0, 0 
	MOVWF       _dig_P4+1 
	CLRF        _dig_P4+0 
	MOVF        R0, 0 
	ADDWF       _dig_P4+0, 1 
	MOVLW       0
	ADDWFC      _dig_P4+1, 1 
;BME280_Driver.c,115 :: 		msb = BME280_Read(CALIB15);
	MOVLW       151
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,116 :: 		lsb = BME280_Read(CALIB14);
	MOVLW       150
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,117 :: 		dig_P5 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P5+0 
	MOVLW       0
	MOVWF       _dig_P5+1 
	MOVF        _dig_P5+0, 0 
	MOVWF       _dig_P5+1 
	CLRF        _dig_P5+0 
	MOVF        R0, 0 
	ADDWF       _dig_P5+0, 1 
	MOVLW       0
	ADDWFC      _dig_P5+1, 1 
;BME280_Driver.c,119 :: 		msb = BME280_Read(CALIB17);
	MOVLW       153
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,120 :: 		lsb = BME280_Read(CALIB16);
	MOVLW       152
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,121 :: 		dig_P6 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P6+0 
	MOVLW       0
	MOVWF       _dig_P6+1 
	MOVF        _dig_P6+0, 0 
	MOVWF       _dig_P6+1 
	CLRF        _dig_P6+0 
	MOVF        R0, 0 
	ADDWF       _dig_P6+0, 1 
	MOVLW       0
	ADDWFC      _dig_P6+1, 1 
;BME280_Driver.c,123 :: 		msb = BME280_Read(CALIB19);
	MOVLW       155
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,124 :: 		lsb = BME280_Read(CALIB18);
	MOVLW       154
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,125 :: 		dig_P7 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P7+0 
	MOVLW       0
	MOVWF       _dig_P7+1 
	MOVF        _dig_P7+0, 0 
	MOVWF       _dig_P7+1 
	CLRF        _dig_P7+0 
	MOVF        R0, 0 
	ADDWF       _dig_P7+0, 1 
	MOVLW       0
	ADDWFC      _dig_P7+1, 1 
;BME280_Driver.c,127 :: 		msb = BME280_Read(CALIB21);
	MOVLW       157
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,128 :: 		lsb = BME280_Read(CALIB20);
	MOVLW       156
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,129 :: 		dig_P8 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P8+0 
	MOVLW       0
	MOVWF       _dig_P8+1 
	MOVF        _dig_P8+0, 0 
	MOVWF       _dig_P8+1 
	CLRF        _dig_P8+0 
	MOVF        R0, 0 
	ADDWF       _dig_P8+0, 1 
	MOVLW       0
	ADDWFC      _dig_P8+1, 1 
;BME280_Driver.c,131 :: 		msb = BME280_Read(CALIB23);
	MOVLW       159
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,132 :: 		lsb = BME280_Read(CALIB22);
	MOVLW       158
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,133 :: 		dig_P9 = ((int)msb << 8) + lsb;
	MOVF        _msb+0, 0 
	MOVWF       _dig_P9+0 
	MOVLW       0
	MOVWF       _dig_P9+1 
	MOVF        _dig_P9+0, 0 
	MOVWF       _dig_P9+1 
	CLRF        _dig_P9+0 
	MOVF        R0, 0 
	ADDWF       _dig_P9+0, 1 
	MOVLW       0
	ADDWFC      _dig_P9+1, 1 
;BME280_Driver.c,139 :: 		lsb = BME280_Read(CALIB25);
	MOVLW       161
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,140 :: 		dig_H1 = (unsigned char)lsb;
	MOVF        R0, 0 
	MOVWF       _dig_H1+0 
;BME280_Driver.c,142 :: 		msb = BME280_Read(CALIB27);
	MOVLW       226
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,143 :: 		lsb = BME280_Read(CALIB26);
	MOVLW       225
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,144 :: 		dig_H2 = ((signed short)msb << 8) + lsb;
	MOVF        R0, 0 
	MOVWF       _dig_H2+0 
;BME280_Driver.c,146 :: 		lsb = BME280_Read(CALIB28);
	MOVLW       227
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,147 :: 		dig_H3 = (unsigned char)lsb;
	MOVF        R0, 0 
	MOVWF       _dig_H3+0 
;BME280_Driver.c,149 :: 		msb = BME280_Read(CALIB29);
	MOVLW       228
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,150 :: 		lsb = BME280_Read(CALIB30);
	MOVLW       229
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,151 :: 		dig_H4 = ((signed short)msb << 4) | (lsb & 0x0F);
	MOVF        _msb+0, 0 
	MOVWF       _dig_H4+0 
	RLCF        _dig_H4+0, 1 
	BCF         _dig_H4+0, 0 
	RLCF        _dig_H4+0, 1 
	BCF         _dig_H4+0, 0 
	RLCF        _dig_H4+0, 1 
	BCF         _dig_H4+0, 0 
	RLCF        _dig_H4+0, 1 
	BCF         _dig_H4+0, 0 
	MOVLW       15
	ANDWF       R0, 1 
	MOVF        R0, 0 
	IORWF       _dig_H4+0, 1 
;BME280_Driver.c,153 :: 		msb = BME280_Read(CALIB31);
	MOVLW       230
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _msb+0 
;BME280_Driver.c,154 :: 		lsb = BME280_Read(CALIB30);
	MOVLW       229
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,155 :: 		dig_H5 = ((signed short)msb << 4) | (lsb >> 4);
	MOVF        _msb+0, 0 
	MOVWF       _dig_H5+0 
	RLCF        _dig_H5+0, 1 
	BCF         _dig_H5+0, 0 
	RLCF        _dig_H5+0, 1 
	BCF         _dig_H5+0, 0 
	RLCF        _dig_H5+0, 1 
	BCF         _dig_H5+0, 0 
	RLCF        _dig_H5+0, 1 
	BCF         _dig_H5+0, 0 
	MOVF        R0, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	IORWF       _dig_H5+0, 1 
;BME280_Driver.c,157 :: 		lsb = BME280_Read(CALIB32);
	MOVLW       231
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _lsb+0 
;BME280_Driver.c,158 :: 		dig_H6 = (signed char)lsb;
	MOVF        R0, 0 
	MOVWF       _dig_H6+0 
;BME280_Driver.c,159 :: 		}
L_end_BME280_GetCalibData:
	RETURN      0
; end of _BME280_GetCalibData

BME280_Driver_BME280_TemperatureComp:

;BME280_Driver.c,162 :: 		static long BME280_TemperatureComp()
;BME280_Driver.c,165 :: 		temp1 = ((((adc_t>>3) -((long)dig_T1<<1))) * ((long)dig_T2)) >> 11;
	MOVLW       3
	MOVWF       R0 
	MOVF        _adc_t+0, 0 
	MOVWF       R9 
	MOVF        _adc_t+1, 0 
	MOVWF       R10 
	MOVF        _adc_t+2, 0 
	MOVWF       R11 
	MOVF        _adc_t+3, 0 
	MOVWF       R12 
	MOVF        R0, 0 
L_BME280_Driver_BME280_TemperatureComp28:
	BZ          L_BME280_Driver_BME280_TemperatureComp29
	RRCF        R12, 1 
	RRCF        R11, 1 
	RRCF        R10, 1 
	RRCF        R9, 1 
	BCF         R12, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_TemperatureComp28
L_BME280_Driver_BME280_TemperatureComp29:
	MOVF        _dig_T1+0, 0 
	MOVWF       R5 
	MOVF        _dig_T1+1, 0 
	MOVWF       R6 
	MOVLW       0
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        R9, 0 
	MOVWF       R4 
	MOVF        R10, 0 
	MOVWF       R5 
	MOVF        R11, 0 
	MOVWF       R6 
	MOVF        R12, 0 
	MOVWF       R7 
	MOVF        R0, 0 
	SUBWF       R4, 1 
	MOVF        R1, 0 
	SUBWFB      R5, 1 
	MOVF        R2, 0 
	SUBWFB      R6, 1 
	MOVF        R3, 0 
	SUBWFB      R7, 1 
	MOVF        _dig_T2+0, 0 
	MOVWF       R0 
	MOVF        _dig_T2+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _dig_T2+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       11
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_TemperatureComp+0 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_TemperatureComp+1 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_TemperatureComp+2 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_TemperatureComp+3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_TemperatureComp30:
	BZ          L_BME280_Driver_BME280_TemperatureComp31
	RRCF        FLOC_BME280_Driver_BME280_TemperatureComp+3, 1 
	RRCF        FLOC_BME280_Driver_BME280_TemperatureComp+2, 1 
	RRCF        FLOC_BME280_Driver_BME280_TemperatureComp+1, 1 
	RRCF        FLOC_BME280_Driver_BME280_TemperatureComp+0, 1 
	BCF         FLOC_BME280_Driver_BME280_TemperatureComp+3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_TemperatureComp30
L_BME280_Driver_BME280_TemperatureComp31:
;BME280_Driver.c,166 :: 		temp2 = (((((adc_t>>4) - ((long)dig_T1)) * ((adc_t>>4) - ((long)dig_T1))) >> 12) * ((long)dig_T3)) >> 14;
	MOVLW       4
	MOVWF       R0 
	MOVF        _adc_t+0, 0 
	MOVWF       R12 
	MOVF        _adc_t+1, 0 
	MOVWF       R13 
	MOVF        _adc_t+2, 0 
	MOVWF       R14 
	MOVF        _adc_t+3, 0 
	MOVWF       R15 
	MOVF        R0, 0 
L_BME280_Driver_BME280_TemperatureComp32:
	BZ          L_BME280_Driver_BME280_TemperatureComp33
	RRCF        R15, 1 
	RRCF        R14, 1 
	RRCF        R13, 1 
	RRCF        R12, 1 
	BCF         R15, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_TemperatureComp32
L_BME280_Driver_BME280_TemperatureComp33:
	MOVF        _dig_T1+0, 0 
	MOVWF       R0 
	MOVF        _dig_T1+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R12, 0 
	MOVWF       R8 
	MOVF        R13, 0 
	MOVWF       R9 
	MOVF        R14, 0 
	MOVWF       R10 
	MOVF        R15, 0 
	MOVWF       R11 
	MOVF        R0, 0 
	SUBWF       R8, 1 
	MOVF        R1, 0 
	SUBWFB      R9, 1 
	MOVF        R2, 0 
	SUBWFB      R10, 1 
	MOVF        R3, 0 
	SUBWFB      R11, 1 
	MOVF        _dig_T1+0, 0 
	MOVWF       R4 
	MOVF        _dig_T1+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVF        R12, 0 
	MOVWF       R0 
	MOVF        R13, 0 
	MOVWF       R1 
	MOVF        R14, 0 
	MOVWF       R2 
	MOVF        R15, 0 
	MOVWF       R3 
	MOVF        R4, 0 
	SUBWF       R0, 1 
	MOVF        R5, 0 
	SUBWFB      R1, 1 
	MOVF        R6, 0 
	SUBWFB      R2, 1 
	MOVF        R7, 0 
	SUBWFB      R3, 1 
	MOVF        R8, 0 
	MOVWF       R4 
	MOVF        R9, 0 
	MOVWF       R5 
	MOVF        R10, 0 
	MOVWF       R6 
	MOVF        R11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       12
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_TemperatureComp34:
	BZ          L_BME280_Driver_BME280_TemperatureComp35
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_TemperatureComp34
L_BME280_Driver_BME280_TemperatureComp35:
	MOVF        _dig_T3+0, 0 
	MOVWF       R0 
	MOVF        _dig_T3+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _dig_T3+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       14
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_TemperatureComp36:
	BZ          L_BME280_Driver_BME280_TemperatureComp37
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_TemperatureComp36
L_BME280_Driver_BME280_TemperatureComp37:
;BME280_Driver.c,167 :: 		t_fine = temp1 + temp2;
	MOVF        R4, 0 
	ADDWF       FLOC_BME280_Driver_BME280_TemperatureComp+0, 0 
	MOVWF       R0 
	MOVF        R5, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_TemperatureComp+1, 0 
	MOVWF       R1 
	MOVF        R6, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_TemperatureComp+2, 0 
	MOVWF       R2 
	MOVF        R7, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_TemperatureComp+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _t_fine+0 
	MOVF        R1, 0 
	MOVWF       _t_fine+1 
	MOVF        R2, 0 
	MOVWF       _t_fine+2 
	MOVF        R3, 0 
	MOVWF       _t_fine+3 
;BME280_Driver.c,168 :: 		T = (t_fine * 5 + 128) >> 8;
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       128
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R8 
	MOVF        R6, 0 
	MOVWF       R0 
	MOVF        R7, 0 
	MOVWF       R1 
	MOVF        R8, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       R8, 7 
	MOVLW       255
	MOVWF       R3 
;BME280_Driver.c,170 :: 		return T;
;BME280_Driver.c,171 :: 		}
L_end_BME280_TemperatureComp:
	RETURN      0
; end of BME280_Driver_BME280_TemperatureComp

BME280_Driver_BME280_PressureComp:

;BME280_Driver.c,174 :: 		static unsigned long BME280_PressureComp()
;BME280_Driver.c,179 :: 		press1 = (((long)t_fine)>>1) - (long)64000;
	MOVF        _t_fine+0, 0 
	MOVWF       R0 
	MOVF        _t_fine+1, 0 
	MOVWF       R1 
	MOVF        _t_fine+2, 0 
	MOVWF       R2 
	MOVF        _t_fine+3, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+8 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+9 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+10 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+11 
	MOVLW       0
	SUBWF       FLOC_BME280_Driver_BME280_PressureComp+8, 1 
	MOVLW       250
	SUBWFB      FLOC_BME280_Driver_BME280_PressureComp+9, 1 
	MOVLW       0
	SUBWFB      FLOC_BME280_Driver_BME280_PressureComp+10, 1 
	MOVLW       0
	SUBWFB      FLOC_BME280_Driver_BME280_PressureComp+11, 1 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+8, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+0 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+9, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+1 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+10, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+2 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+11, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+3 
;BME280_Driver.c,180 :: 		press2 = (((press1>>2) * (press1>>2)) >> 11 ) * ((long)dig_P6);
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+8, 0 
	MOVWF       R0 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+9, 0 
	MOVWF       R1 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+10, 0 
	MOVWF       R2 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+11, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+4 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+5 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+6 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+7 
	MOVLW       11
	MOVWF       R0 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+4, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+5, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+6, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+7, 0 
	MOVWF       R7 
	MOVF        R0, 0 
L_BME280_Driver_BME280_PressureComp39:
	BZ          L_BME280_Driver_BME280_PressureComp40
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp39
L_BME280_Driver_BME280_PressureComp40:
	MOVF        _dig_P6+0, 0 
	MOVWF       R0 
	MOVF        _dig_P6+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _dig_P6+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+0 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+1 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+2 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+3 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+0 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+1 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+2 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+3 
;BME280_Driver.c,181 :: 		press2 = press2 + ((press1*((long)dig_P5))<<1);
	MOVF        _dig_P5+0, 0 
	MOVWF       R0 
	MOVF        _dig_P5+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _dig_P5+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+8, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+9, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+10, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	RLCF        R4, 1 
	BCF         R4, 0 
	RLCF        R5, 1 
	RLCF        R6, 1 
	RLCF        R7, 1 
	MOVF        R4, 0 
	ADDWF       FLOC_BME280_Driver_BME280_PressureComp+0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+0 
	MOVF        R5, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+1 
	MOVF        R6, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+2 
	MOVF        R7, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+3 
;BME280_Driver.c,182 :: 		press2 = (press2>>2)+(((long)dig_P4)<<16);
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+3, 1 
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+2, 1 
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+1, 1 
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+0, 1 
	BCF         BME280_Driver_BME280_PressureComp_press2_L0+3, 7 
	BTFSC       BME280_Driver_BME280_PressureComp_press2_L0+3, 6 
	BSF         BME280_Driver_BME280_PressureComp_press2_L0+3, 7 
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+3, 1 
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+2, 1 
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+1, 1 
	RRCF        BME280_Driver_BME280_PressureComp_press2_L0+0, 1 
	BCF         BME280_Driver_BME280_PressureComp_press2_L0+3, 7 
	BTFSC       BME280_Driver_BME280_PressureComp_press2_L0+3, 6 
	BSF         BME280_Driver_BME280_PressureComp_press2_L0+3, 7 
	MOVF        _dig_P4+0, 0 
	MOVWF       R5 
	MOVF        _dig_P4+1, 0 
	MOVWF       R6 
	MOVLW       0
	BTFSC       _dig_P4+1, 7 
	MOVLW       255
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R6, 0 
	MOVWF       R3 
	MOVF        R5, 0 
	MOVWF       R2 
	CLRF        R0 
	CLRF        R1 
	MOVF        R0, 0 
	ADDWF       BME280_Driver_BME280_PressureComp_press2_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      BME280_Driver_BME280_PressureComp_press2_L0+1, 1 
	MOVF        R2, 0 
	ADDWFC      BME280_Driver_BME280_PressureComp_press2_L0+2, 1 
	MOVF        R3, 0 
	ADDWFC      BME280_Driver_BME280_PressureComp_press2_L0+3, 1 
;BME280_Driver.c,183 :: 		press1 = (((dig_P3 * (((press1>>2) * (press1>>2)) >> 13 )) >> 3) + ((((long)dig_P2) * press1)>>1))>>18;
	MOVLW       13
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+4, 0 
	MOVWF       R0 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+5, 0 
	MOVWF       R1 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+6, 0 
	MOVWF       R2 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+7, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_PressureComp41:
	BZ          L_BME280_Driver_BME280_PressureComp42
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp41
L_BME280_Driver_BME280_PressureComp42:
	MOVF        _dig_P3+0, 0 
	MOVWF       R4 
	MOVF        _dig_P3+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       _dig_P3+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       3
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+0 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+1 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+2 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_PressureComp43:
	BZ          L_BME280_Driver_BME280_PressureComp44
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+3, 1 
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+2, 1 
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+1, 1 
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+0, 1 
	BCF         FLOC_BME280_Driver_BME280_PressureComp+3, 7 
	BTFSC       FLOC_BME280_Driver_BME280_PressureComp+3, 6 
	BSF         FLOC_BME280_Driver_BME280_PressureComp+3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp43
L_BME280_Driver_BME280_PressureComp44:
	MOVF        _dig_P2+0, 0 
	MOVWF       R0 
	MOVF        _dig_P2+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _dig_P2+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+8, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+9, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+10, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	MOVF        R4, 0 
	ADDWF       FLOC_BME280_Driver_BME280_PressureComp+0, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+1, 0 
	MOVWF       R9 
	MOVF        R6, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+2, 0 
	MOVWF       R10 
	MOVF        R7, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+3, 0 
	MOVWF       R11 
	MOVLW       18
	MOVWF       R4 
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_PressureComp45:
	BZ          L_BME280_Driver_BME280_PressureComp46
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp45
L_BME280_Driver_BME280_PressureComp46:
	MOVF        R0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+0 
	MOVF        R1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+1 
	MOVF        R2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+2 
	MOVF        R3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+3 
;BME280_Driver.c,184 :: 		press1 =((((32768+press1))*((long)dig_P1))>>15);
	MOVLW       0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       128
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R7 
	MOVF        _dig_P1+0, 0 
	MOVWF       R0 
	MOVF        _dig_P1+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       15
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_PressureComp47:
	BZ          L_BME280_Driver_BME280_PressureComp48
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp47
L_BME280_Driver_BME280_PressureComp48:
	MOVF        R4, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+0 
	MOVF        R5, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+1 
	MOVF        R6, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+2 
	MOVF        R7, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+3 
;BME280_Driver.c,185 :: 		if (press1 == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       R7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_PressureComp49
	MOVF        R0, 0 
	XORWF       R6, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_PressureComp49
	MOVF        R0, 0 
	XORWF       R5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_PressureComp49
	MOVF        R4, 0 
	XORLW       0
L_BME280_Driver_BME280_PressureComp49:
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_PressureComp3
;BME280_Driver.c,187 :: 		return 0; // division by zero exception
	CLRF        R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
	GOTO        L_end_BME280_PressureComp
;BME280_Driver.c,188 :: 		}
L_BME280_Driver_BME280_PressureComp3:
;BME280_Driver.c,189 :: 		P = (((unsigned long)(((long)1048576)-adc_P)-(press2>>12)))*3125;
	MOVLW       0
	MOVWF       R8 
	MOVLW       0
	MOVWF       R9 
	MOVLW       16
	MOVWF       R10 
	MOVLW       0
	MOVWF       R11 
	MOVF        _adc_p+0, 0 
	SUBWF       R8, 1 
	MOVF        _adc_p+1, 0 
	SUBWFB      R9, 1 
	MOVF        _adc_p+2, 0 
	SUBWFB      R10, 1 
	MOVF        _adc_p+3, 0 
	SUBWFB      R11, 1 
	MOVLW       12
	MOVWF       R0 
	MOVF        BME280_Driver_BME280_PressureComp_press2_L0+0, 0 
	MOVWF       R4 
	MOVF        BME280_Driver_BME280_PressureComp_press2_L0+1, 0 
	MOVWF       R5 
	MOVF        BME280_Driver_BME280_PressureComp_press2_L0+2, 0 
	MOVWF       R6 
	MOVF        BME280_Driver_BME280_PressureComp_press2_L0+3, 0 
	MOVWF       R7 
	MOVF        R0, 0 
L_BME280_Driver_BME280_PressureComp50:
	BZ          L_BME280_Driver_BME280_PressureComp51
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp50
L_BME280_Driver_BME280_PressureComp51:
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R4, 0 
	SUBWF       R0, 1 
	MOVF        R5, 0 
	SUBWFB      R1, 1 
	MOVF        R6, 0 
	SUBWFB      R2, 1 
	MOVF        R7, 0 
	SUBWFB      R3, 1 
	MOVLW       53
	MOVWF       R4 
	MOVLW       12
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+0 
	MOVF        R1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+1 
	MOVF        R2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+2 
	MOVF        R3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+3 
;BME280_Driver.c,190 :: 		if (P < 0x80000000) {
	MOVLW       128
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_PressureComp52
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_PressureComp52
	MOVLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_PressureComp52
	MOVLW       0
	SUBWF       R0, 0 
L_BME280_Driver_BME280_PressureComp52:
	BTFSC       STATUS+0, 0 
	GOTO        L_BME280_Driver_BME280_PressureComp4
;BME280_Driver.c,191 :: 		P = (P << 1) / ((unsigned long)press1);
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+0, 0 
	MOVWF       R0 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+1, 0 
	MOVWF       R1 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+2, 0 
	MOVWF       R2 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+3, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+0, 0 
	MOVWF       R4 
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+1, 0 
	MOVWF       R5 
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+2, 0 
	MOVWF       R6 
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+0 
	MOVF        R1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+1 
	MOVF        R2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+2 
	MOVF        R3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+3 
;BME280_Driver.c,192 :: 		} else {
	GOTO        L_BME280_Driver_BME280_PressureComp5
L_BME280_Driver_BME280_PressureComp4:
;BME280_Driver.c,193 :: 		P = (P / (unsigned long)press1) * 2;
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+0, 0 
	MOVWF       R4 
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+1, 0 
	MOVWF       R5 
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+2, 0 
	MOVWF       R6 
	MOVF        BME280_Driver_BME280_PressureComp_press1_L0+3, 0 
	MOVWF       R7 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+0, 0 
	MOVWF       R0 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+1, 0 
	MOVWF       R1 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+2, 0 
	MOVWF       R2 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+0 
	MOVF        R1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+1 
	MOVF        R2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+2 
	MOVF        R3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+3 
	RLCF        BME280_Driver_BME280_PressureComp_P_L0+0, 1 
	BCF         BME280_Driver_BME280_PressureComp_P_L0+0, 0 
	RLCF        BME280_Driver_BME280_PressureComp_P_L0+1, 1 
	RLCF        BME280_Driver_BME280_PressureComp_P_L0+2, 1 
	RLCF        BME280_Driver_BME280_PressureComp_P_L0+3, 1 
;BME280_Driver.c,194 :: 		}
L_BME280_Driver_BME280_PressureComp5:
;BME280_Driver.c,195 :: 		press1 = (((long)dig_P9) * ((long)(((p>>3) * (p>>3))>>13)))>>12;
	MOVF        _dig_P9+0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+0 
	MOVF        _dig_P9+1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+1 
	MOVLW       0
	BTFSC       _dig_P9+1, 7 
	MOVLW       255
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+2 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+3 
	MOVLW       3
	MOVWF       R4 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+0, 0 
	MOVWF       R0 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+1, 0 
	MOVWF       R1 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+2, 0 
	MOVWF       R2 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+3, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_PressureComp53:
	BZ          L_BME280_Driver_BME280_PressureComp54
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp53
L_BME280_Driver_BME280_PressureComp54:
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       13
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_PressureComp55:
	BZ          L_BME280_Driver_BME280_PressureComp56
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp55
L_BME280_Driver_BME280_PressureComp56:
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+0, 0 
	MOVWF       R0 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+1, 0 
	MOVWF       R1 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+2, 0 
	MOVWF       R2 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+3, 0 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       12
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+0 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+1 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+2 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_PressureComp+3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_PressureComp57:
	BZ          L_BME280_Driver_BME280_PressureComp58
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+3, 1 
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+2, 1 
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+1, 1 
	RRCF        FLOC_BME280_Driver_BME280_PressureComp+0, 1 
	BCF         FLOC_BME280_Driver_BME280_PressureComp+3, 7 
	BTFSC       FLOC_BME280_Driver_BME280_PressureComp+3, 6 
	BSF         FLOC_BME280_Driver_BME280_PressureComp+3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp57
L_BME280_Driver_BME280_PressureComp58:
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+0 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+1 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+2 
	MOVF        FLOC_BME280_Driver_BME280_PressureComp+3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press1_L0+3 
;BME280_Driver.c,196 :: 		press2 = (((long)(p>>2)) * ((long)dig_P8))>>13;
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+0, 0 
	MOVWF       R4 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+1, 0 
	MOVWF       R5 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+2, 0 
	MOVWF       R6 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+3, 0 
	MOVWF       R7 
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	MOVF        _dig_P8+0, 0 
	MOVWF       R0 
	MOVF        _dig_P8+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _dig_P8+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       13
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_PressureComp59:
	BZ          L_BME280_Driver_BME280_PressureComp60
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp59
L_BME280_Driver_BME280_PressureComp60:
	MOVF        R4, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+0 
	MOVF        R5, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+1 
	MOVF        R6, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+2 
	MOVF        R7, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_press2_L0+3 
;BME280_Driver.c,197 :: 		P = (unsigned long)((long)p + ((press1 + press2 + dig_P7) >> 4));
	MOVF        R4, 0 
	ADDWF       FLOC_BME280_Driver_BME280_PressureComp+0, 0 
	MOVWF       R0 
	MOVF        R5, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+1, 0 
	MOVWF       R1 
	MOVF        R6, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+2, 0 
	MOVWF       R2 
	MOVF        R7, 0 
	ADDWFC      FLOC_BME280_Driver_BME280_PressureComp+3, 0 
	MOVWF       R3 
	MOVF        _dig_P7+0, 0 
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVF        _dig_P7+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       0
	BTFSC       _dig_P7+1, 7 
	MOVLW       255
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVLW       0
	BTFSC       _dig_P7+1, 7 
	MOVLW       255
	ADDWFC      R3, 0 
	MOVWF       R8 
	MOVLW       4
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_PressureComp61:
	BZ          L_BME280_Driver_BME280_PressureComp62
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_PressureComp61
L_BME280_Driver_BME280_PressureComp62:
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+2, 0 
	ADDWFC      R2, 1 
	MOVF        BME280_Driver_BME280_PressureComp_P_L0+3, 0 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+0 
	MOVF        R1, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+1 
	MOVF        R2, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+2 
	MOVF        R3, 0 
	MOVWF       BME280_Driver_BME280_PressureComp_P_L0+3 
;BME280_Driver.c,199 :: 		return P;
;BME280_Driver.c,200 :: 		}
L_end_BME280_PressureComp:
	RETURN      0
; end of BME280_Driver_BME280_PressureComp

BME280_Driver_BME280_HumidityComp:

;BME280_Driver.c,203 :: 		static unsigned long BME280_HumidityComp()
;BME280_Driver.c,208 :: 		h1 = (t_fine - ((long)76800));
	MOVF        _t_fine+0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+8 
	MOVF        _t_fine+1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+9 
	MOVF        _t_fine+2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+10 
	MOVF        _t_fine+3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+11 
	MOVLW       0
	SUBWF       FLOC_BME280_Driver_BME280_HumidityComp+8, 1 
	MOVLW       44
	SUBWFB      FLOC_BME280_Driver_BME280_HumidityComp+9, 1 
	MOVLW       1
	SUBWFB      FLOC_BME280_Driver_BME280_HumidityComp+10, 1 
	MOVLW       0
	SUBWFB      FLOC_BME280_Driver_BME280_HumidityComp+11, 1 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+8, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+0 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+9, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+1 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+10, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+2 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+11, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+3 
;BME280_Driver.c,209 :: 		h1 = (((((adc_H << 14) - (((long)dig_H4) << 20) - (((long)dig_H5) * h1)) +
	MOVLW       14
	MOVWF       R0 
	MOVF        _adc_h+0, 0 
	MOVWF       R9 
	MOVF        _adc_h+1, 0 
	MOVWF       R10 
	MOVF        _adc_h+2, 0 
	MOVWF       R11 
	MOVF        _adc_h+3, 0 
	MOVWF       R12 
	MOVF        R0, 0 
L_BME280_Driver_BME280_HumidityComp64:
	BZ          L_BME280_Driver_BME280_HumidityComp65
	RLCF        R9, 1 
	BCF         R9, 0 
	RLCF        R10, 1 
	RLCF        R11, 1 
	RLCF        R12, 1 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp64
L_BME280_Driver_BME280_HumidityComp65:
	MOVF        _dig_H4+0, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       _dig_H4+0, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVLW       20
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_HumidityComp66:
	BZ          L_BME280_Driver_BME280_HumidityComp67
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp66
L_BME280_Driver_BME280_HumidityComp67:
	MOVF        R9, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+0 
	MOVF        R10, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+1 
	MOVF        R11, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+2 
	MOVF        R12, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+3 
	MOVF        R0, 0 
	SUBWF       FLOC_BME280_Driver_BME280_HumidityComp+0, 1 
	MOVF        R1, 0 
	SUBWFB      FLOC_BME280_Driver_BME280_HumidityComp+1, 1 
	MOVF        R2, 0 
	SUBWFB      FLOC_BME280_Driver_BME280_HumidityComp+2, 1 
	MOVF        R3, 0 
	SUBWFB      FLOC_BME280_Driver_BME280_HumidityComp+3, 1 
	MOVF        _dig_H5+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _dig_H5+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+8, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+9, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+10, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+0, 0 
	MOVWF       R7 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+1, 0 
	MOVWF       R8 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+2, 0 
	MOVWF       R9 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+3, 0 
	MOVWF       R10 
	MOVF        R0, 0 
	SUBWF       R7, 1 
	MOVF        R1, 0 
	SUBWFB      R8, 1 
	MOVF        R2, 0 
	SUBWFB      R9, 1 
	MOVF        R3, 0 
	SUBWFB      R10, 1 
;BME280_Driver.c,210 :: 		((long)16384)) >> 15) * (((((((h1 * ((long)dig_H6)) >> 10) * (((h1 *
	MOVLW       0
	ADDWF       R7, 0 
	MOVWF       R3 
	MOVLW       64
	ADDWFC      R8, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R9, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R10, 0 
	MOVWF       R6 
	MOVLW       15
	MOVWF       R0 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+4 
	MOVF        R4, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+5 
	MOVF        R5, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+6 
	MOVF        R6, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+7 
	MOVF        R0, 0 
L_BME280_Driver_BME280_HumidityComp68:
	BZ          L_BME280_Driver_BME280_HumidityComp69
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+7, 1 
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+6, 1 
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+5, 1 
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+4, 1 
	BCF         FLOC_BME280_Driver_BME280_HumidityComp+7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp68
L_BME280_Driver_BME280_HumidityComp69:
	MOVF        _dig_H6+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+8, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+9, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+10, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+0 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+1 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+2 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_HumidityComp70:
	BZ          L_BME280_Driver_BME280_HumidityComp71
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+3, 1 
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+2, 1 
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+1, 1 
	RRCF        FLOC_BME280_Driver_BME280_HumidityComp+0, 1 
	BCF         FLOC_BME280_Driver_BME280_HumidityComp+3, 7 
	BTFSC       FLOC_BME280_Driver_BME280_HumidityComp+3, 6 
	BSF         FLOC_BME280_Driver_BME280_HumidityComp+3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp70
L_BME280_Driver_BME280_HumidityComp71:
;BME280_Driver.c,211 :: 		((long)dig_H3)) >> 11) + ((long)32768))) >> 10) + ((long)2097152)) *
	MOVF        _dig_H3+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+8, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+9, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+10, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+11, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       11
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_HumidityComp72:
	BZ          L_BME280_Driver_BME280_HumidityComp73
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp72
L_BME280_Driver_BME280_HumidityComp73:
	MOVLW       0
	ADDWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	ADDWFC      R5, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      R6, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R7, 0 
	MOVWF       R3 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+0, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+1, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+2, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       10
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_HumidityComp74:
	BZ          L_BME280_Driver_BME280_HumidityComp75
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp74
L_BME280_Driver_BME280_HumidityComp75:
	MOVLW       0
	ADDWF       R4, 1 
	MOVLW       0
	ADDWFC      R5, 1 
	MOVLW       32
	ADDWFC      R6, 1 
	MOVLW       0
	ADDWFC      R7, 1 
;BME280_Driver.c,212 :: 		((long)dig_H2) + 8192) >> 14));
	MOVF        _dig_H2+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _dig_H2+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       0
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       32
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R8 
	MOVLW       14
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_HumidityComp76:
	BZ          L_BME280_Driver_BME280_HumidityComp77
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp76
L_BME280_Driver_BME280_HumidityComp77:
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+4, 0 
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+5, 0 
	MOVWF       R5 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+6, 0 
	MOVWF       R6 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+7, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+0 
	MOVF        R1, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+1 
	MOVF        R2, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+2 
	MOVF        R3, 0 
	MOVWF       FLOC_BME280_Driver_BME280_HumidityComp+3 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+0, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+0 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+1, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+1 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+2, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+2 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+3, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+3 
;BME280_Driver.c,213 :: 		h1 = (h1 - (((((h1 >> 15) * (h1 >> 15)) >> 7) * ((long)dig_H1)) >> 4));
	MOVLW       15
	MOVWF       R4 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+0, 0 
	MOVWF       R0 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+1, 0 
	MOVWF       R1 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+2, 0 
	MOVWF       R2 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+3, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_HumidityComp78:
	BZ          L_BME280_Driver_BME280_HumidityComp79
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp78
L_BME280_Driver_BME280_HumidityComp79:
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       7
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L_BME280_Driver_BME280_HumidityComp80:
	BZ          L_BME280_Driver_BME280_HumidityComp81
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp80
L_BME280_Driver_BME280_HumidityComp81:
	MOVF        _dig_H1+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       4
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	MOVWF       R8 
	MOVF        R4, 0 
L_BME280_Driver_BME280_HumidityComp82:
	BZ          L_BME280_Driver_BME280_HumidityComp83
	RRCF        R8, 1 
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	BCF         R8, 7 
	BTFSC       R8, 6 
	BSF         R8, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp82
L_BME280_Driver_BME280_HumidityComp83:
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+0, 0 
	MOVWF       R1 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+1, 0 
	MOVWF       R2 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+2, 0 
	MOVWF       R3 
	MOVF        FLOC_BME280_Driver_BME280_HumidityComp+3, 0 
	MOVWF       R4 
	MOVF        R5, 0 
	SUBWF       R1, 1 
	MOVF        R6, 0 
	SUBWFB      R2, 1 
	MOVF        R7, 0 
	SUBWFB      R3, 1 
	MOVF        R8, 0 
	SUBWFB      R4, 1 
	MOVF        R1, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+0 
	MOVF        R2, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+1 
	MOVF        R3, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+2 
	MOVF        R4, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+3 
;BME280_Driver.c,214 :: 		h1 = (h1 < 0 ? 0 : h1);
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_HumidityComp84
	MOVLW       0
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_HumidityComp84
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_HumidityComp84
	MOVLW       0
	SUBWF       R1, 0 
L_BME280_Driver_BME280_HumidityComp84:
	BTFSC       STATUS+0, 0 
	GOTO        L_BME280_Driver_BME280_HumidityComp6
	CLRF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+0 
	CLRF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+1 
	CLRF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+2 
	CLRF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+3 
	GOTO        L_BME280_Driver_BME280_HumidityComp7
L_BME280_Driver_BME280_HumidityComp6:
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+0, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+0 
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+1, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+1 
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+2, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+2 
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+3, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+3 
L_BME280_Driver_BME280_HumidityComp7:
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+0, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+0 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+1, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+1 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+2, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+2 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+3, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+3 
;BME280_Driver.c,215 :: 		h1 = (h1 > 419430400 ? 419430400 : h1);
	MOVLW       128
	XORLW       25
	MOVWF       R0 
	MOVLW       128
	XORWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_HumidityComp85
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_HumidityComp85
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_BME280_Driver_BME280_HumidityComp85
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT213+0, 0 
	SUBLW       0
L_BME280_Driver_BME280_HumidityComp85:
	BTFSC       STATUS+0, 0 
	GOTO        L_BME280_Driver_BME280_HumidityComp8
	MOVLW       0
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+0 
	MOVLW       0
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+1 
	MOVLW       0
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+2 
	MOVLW       25
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+3 
	GOTO        L_BME280_Driver_BME280_HumidityComp9
L_BME280_Driver_BME280_HumidityComp8:
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+0, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+0 
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+1, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+1 
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+2, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+2 
	MOVF        BME280_Driver_BME280_HumidityComp_h1_L0+3, 0 
	MOVWF       BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+3 
L_BME280_Driver_BME280_HumidityComp9:
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+0, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+0 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+1, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+1 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+2, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+2 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+3, 0 
	MOVWF       BME280_Driver_BME280_HumidityComp_h1_L0+3 
;BME280_Driver.c,216 :: 		H = (unsigned long)(h1>>12);
	MOVLW       12
	MOVWF       R4 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+0, 0 
	MOVWF       R0 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+1, 0 
	MOVWF       R1 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+2, 0 
	MOVWF       R2 
	MOVF        BME280_Driver_?FLOC__BME280_Driver_BME280_HumidityCompT215+3, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L_BME280_Driver_BME280_HumidityComp86:
	BZ          L_BME280_Driver_BME280_HumidityComp87
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L_BME280_Driver_BME280_HumidityComp86
L_BME280_Driver_BME280_HumidityComp87:
;BME280_Driver.c,218 :: 		return H;
;BME280_Driver.c,219 :: 		}
L_end_BME280_HumidityComp:
	RETURN      0
; end of BME280_Driver_BME280_HumidityComp

_BME280_GetTemperature:

;BME280_Driver.c,222 :: 		float BME280_GetTemperature()
;BME280_Driver.c,226 :: 		T = BME280_TemperatureComp();
	CALL        BME280_Driver_BME280_TemperatureComp+0, 0
;BME280_Driver.c,227 :: 		Temp = (float)T/100;
	CALL        _longint2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;BME280_Driver.c,228 :: 		return Temp;
;BME280_Driver.c,229 :: 		}
L_end_BME280_GetTemperature:
	RETURN      0
; end of _BME280_GetTemperature

_BME280_GetPressure:

;BME280_Driver.c,232 :: 		float BME280_GetPressure()
;BME280_Driver.c,236 :: 		P = BME280_PressureComp();
	CALL        BME280_Driver_BME280_PressureComp+0, 0
;BME280_Driver.c,237 :: 		Press = (float)P/100;
	CALL        _longint2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;BME280_Driver.c,238 :: 		return Press;
;BME280_Driver.c,239 :: 		}
L_end_BME280_GetPressure:
	RETURN      0
; end of _BME280_GetPressure

_BME280_GetHumidity:

;BME280_Driver.c,242 :: 		float BME280_GetHumidity()
;BME280_Driver.c,246 :: 		H = BME280_HumidityComp();
	CALL        BME280_Driver_BME280_HumidityComp+0, 0
;BME280_Driver.c,247 :: 		Hum = (float)H/1024;
	CALL        _longword2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;BME280_Driver.c,248 :: 		return Hum;
;BME280_Driver.c,249 :: 		}
L_end_BME280_GetHumidity:
	RETURN      0
; end of _BME280_GetHumidity

_BME280_GetID:

;BME280_Driver.c,252 :: 		short int BME280_GetID()
;BME280_Driver.c,255 :: 		id = BME280_Read(ID_ADDRESS);
	MOVLW       208
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,256 :: 		return id;
;BME280_Driver.c,257 :: 		}
L_end_BME280_GetID:
	RETURN      0
; end of _BME280_GetID

_BME280_GetStatus:

;BME280_Driver.c,260 :: 		short int BME280_GetStatus()
;BME280_Driver.c,263 :: 		status = BME280_Read(STATUS);
	MOVLW       243
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,264 :: 		return (status & 0x08);
	MOVLW       8
	ANDWF       R0, 1 
;BME280_Driver.c,265 :: 		}
L_end_BME280_GetStatus:
	RETURN      0
; end of _BME280_GetStatus

_BME280_SetTemperatureOversamp:

;BME280_Driver.c,268 :: 		void BME280_SetTemperatureOversamp(unsigned short value)
;BME280_Driver.c,271 :: 		ctrl = BME280_Read(CTRL_MEAS);
	MOVLW       244
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,272 :: 		ctrl &= 0x1F;
	MOVLW       31
	ANDWF       R0, 0 
	MOVWF       FARG_BME280_Driver_BME280_Write_wData+0 
;BME280_Driver.c,273 :: 		ctrl |= value << 5;
	MOVLW       5
	MOVWF       R1 
	MOVF        FARG_BME280_SetTemperatureOversamp_value+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__BME280_SetTemperatureOversamp94:
	BZ          L__BME280_SetTemperatureOversamp95
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__BME280_SetTemperatureOversamp94
L__BME280_SetTemperatureOversamp95:
	MOVF        R0, 0 
	IORWF       FARG_BME280_Driver_BME280_Write_wData+0, 1 
;BME280_Driver.c,274 :: 		BME280_Write(CTRL_MEAS, ctrl);
	MOVLW       244
	MOVWF       FARG_BME280_Driver_BME280_Write_reg_addr+0 
	CALL        BME280_Driver_BME280_Write+0, 0
;BME280_Driver.c,275 :: 		}
L_end_BME280_SetTemperatureOversamp:
	RETURN      0
; end of _BME280_SetTemperatureOversamp

_BME280_SetPressureOversamp:

;BME280_Driver.c,278 :: 		void BME280_SetPressureOversamp(unsigned short value)
;BME280_Driver.c,281 :: 		ctrl = BME280_Read(CTRL_MEAS);
	MOVLW       244
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,282 :: 		ctrl &= 0xE3;
	MOVLW       227
	ANDWF       R0, 0 
	MOVWF       FARG_BME280_Driver_BME280_Write_wData+0 
;BME280_Driver.c,283 :: 		ctrl |= value << 2;
	MOVF        FARG_BME280_SetPressureOversamp_value+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	IORWF       FARG_BME280_Driver_BME280_Write_wData+0, 1 
;BME280_Driver.c,284 :: 		BME280_Write(CTRL_MEAS, ctrl);
	MOVLW       244
	MOVWF       FARG_BME280_Driver_BME280_Write_reg_addr+0 
	CALL        BME280_Driver_BME280_Write+0, 0
;BME280_Driver.c,285 :: 		}
L_end_BME280_SetPressureOversamp:
	RETURN      0
; end of _BME280_SetPressureOversamp

_BME280_SetHumidityOversamp:

;BME280_Driver.c,288 :: 		void BME280_SetHumidityOversamp(unsigned short value)
;BME280_Driver.c,291 :: 		ctrl = BME280_Read(CTRL_HUM);
	MOVLW       242
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,292 :: 		ctrl &= 0x00;
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_BME280_Driver_BME280_Write_wData+0 
;BME280_Driver.c,293 :: 		ctrl |= value;
	MOVF        FARG_BME280_SetHumidityOversamp_value+0, 0 
	IORWF       FARG_BME280_Driver_BME280_Write_wData+0, 1 
;BME280_Driver.c,294 :: 		BME280_Write(CTRL_HUM, ctrl);
	MOVLW       242
	MOVWF       FARG_BME280_Driver_BME280_Write_reg_addr+0 
	CALL        BME280_Driver_BME280_Write+0, 0
;BME280_Driver.c,295 :: 		}
L_end_BME280_SetHumidityOversamp:
	RETURN      0
; end of _BME280_SetHumidityOversamp

_BME280_SetWorkingMode:

;BME280_Driver.c,298 :: 		void BME280_SetWorkingMode(unsigned short value)
;BME280_Driver.c,301 :: 		ctrl = BME280_Read(CTRL_MEAS);
	MOVLW       244
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,302 :: 		ctrl &= 0xFC;
	MOVLW       252
	ANDWF       R0, 0 
	MOVWF       FARG_BME280_Driver_BME280_Write_wData+0 
;BME280_Driver.c,303 :: 		ctrl |= value;
	MOVF        FARG_BME280_SetWorkingMode_value+0, 0 
	IORWF       FARG_BME280_Driver_BME280_Write_wData+0, 1 
;BME280_Driver.c,304 :: 		BME280_Write(CTRL_MEAS, ctrl);
	MOVLW       244
	MOVWF       FARG_BME280_Driver_BME280_Write_reg_addr+0 
	CALL        BME280_Driver_BME280_Write+0, 0
;BME280_Driver.c,305 :: 		}
L_end_BME280_SetWorkingMode:
	RETURN      0
; end of _BME280_SetWorkingMode

_BME280_SetFilterCoeff:

;BME280_Driver.c,308 :: 		void BME280_SetFilterCoeff(unsigned short value)
;BME280_Driver.c,311 :: 		ctrl = BME280_Read(CONFIG);
	MOVLW       245
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,312 :: 		ctrl &= 0xE3;
	MOVLW       227
	ANDWF       R0, 0 
	MOVWF       FARG_BME280_Driver_BME280_Write_wData+0 
;BME280_Driver.c,313 :: 		ctrl |= value << 2;
	MOVF        FARG_BME280_SetFilterCoeff_value+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	IORWF       FARG_BME280_Driver_BME280_Write_wData+0, 1 
;BME280_Driver.c,314 :: 		BME280_Write(CONFIG, ctrl);
	MOVLW       245
	MOVWF       FARG_BME280_Driver_BME280_Write_reg_addr+0 
	CALL        BME280_Driver_BME280_Write+0, 0
;BME280_Driver.c,315 :: 		}
L_end_BME280_SetFilterCoeff:
	RETURN      0
; end of _BME280_SetFilterCoeff

_BME280_SetStdbyTime:

;BME280_Driver.c,318 :: 		void BME280_SetStdbyTime(unsigned short value)
;BME280_Driver.c,321 :: 		ctrl = BME280_Read(CONFIG);
	MOVLW       245
	MOVWF       FARG_BME280_Driver_BME280_Read_reg_addr+0 
	CALL        BME280_Driver_BME280_Read+0, 0
;BME280_Driver.c,322 :: 		ctrl &= 0x1F;
	MOVLW       31
	ANDWF       R0, 0 
	MOVWF       FARG_BME280_Driver_BME280_Write_wData+0 
;BME280_Driver.c,323 :: 		ctrl |= value << 5;
	MOVLW       5
	MOVWF       R1 
	MOVF        FARG_BME280_SetStdbyTime_value+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__BME280_SetStdbyTime101:
	BZ          L__BME280_SetStdbyTime102
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__BME280_SetStdbyTime101
L__BME280_SetStdbyTime102:
	MOVF        R0, 0 
	IORWF       FARG_BME280_Driver_BME280_Write_wData+0, 1 
;BME280_Driver.c,324 :: 		BME280_Write(CONFIG, ctrl);
	MOVLW       245
	MOVWF       FARG_BME280_Driver_BME280_Write_reg_addr+0 
	CALL        BME280_Driver_BME280_Write+0, 0
;BME280_Driver.c,325 :: 		}
L_end_BME280_SetStdbyTime:
	RETURN      0
; end of _BME280_SetStdbyTime

_BME280_SoftReset:

;BME280_Driver.c,328 :: 		void BME280_SoftReset()
;BME280_Driver.c,330 :: 		BME280_Write(RESET,0xB6);
	MOVLW       224
	MOVWF       FARG_BME280_Driver_BME280_Write_reg_addr+0 
	MOVLW       182
	MOVWF       FARG_BME280_Driver_BME280_Write_wData+0 
	CALL        BME280_Driver_BME280_Write+0, 0
;BME280_Driver.c,331 :: 		}
L_end_BME280_SoftReset:
	RETURN      0
; end of _BME280_SoftReset
