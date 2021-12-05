#line 1 "C:/Users/Mario/Desktop/Weather click/Weather click - mikroC/BME280_Driver.c"
#line 1 "c:/users/mario/desktop/weather click/weather click - mikroc/bme280_definitions.h"
#line 8 "C:/Users/Mario/Desktop/Weather click/Weather click - mikroC/BME280_Driver.c"
unsigned int dig_T1;
int dig_T2, dig_T3;
unsigned int dig_P1;
int dig_P2, dig_P3, dig_P4, dig_P5, dig_P6, dig_P7, dig_P8, dig_P9;
unsigned char dig_H1, dig_H3;
short dig_H2, dig_H4, dig_H5;
char dig_H6;

unsigned long int adc_t, adc_p, adc_h;
long t_fine;
char lsb, msb;


static void BME280_Write(unsigned short reg_addr, unsigned short wData)
{
 I2C1_Start();
 I2C1_Wr( 0xEC );
 I2C1_Wr(reg_addr);
 I2C1_Wr(wData);
 I2C1_Stop();
}


static unsigned short BME280_Read(unsigned short reg_addr)
{
 unsigned short value;

 I2C1_Start();
 I2C1_Wr( 0xEC );
 I2C1_Wr(reg_addr);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xED );
 value = I2C1_Rd(0u);
 I2C1_Stop();

 return value;
}



void BME280_BurstRead()
{
 unsigned short int burst_data[10];
 int i;

 I2C1_Start();
 I2C1_Wr( 0xEC );
 I2C1_Wr( 0xF7 );
 I2C1_Repeated_Start();
 I2C1_Wr( 0xED );

 for (i = 0; i <= 6; i++)
 {
 burst_data[i] = I2C1_Rd(1);
 }
 burst_data[i+1] = I2C1_Rd(0u);


 adc_p = (unsigned long)burst_data[0] << 12;
 adc_p |= (unsigned long)burst_data[1] << 4;
 adc_p |= (unsigned long)burst_data[2] >> 4;

 adc_t = (unsigned long)burst_data[3] << 12;
 adc_t |= (unsigned long)burst_data[4] << 4;
 adc_t |= (unsigned long)burst_data[5] >> 4;

 adc_h = (unsigned long)burst_data[6] << 8;
 adc_h |= (unsigned long)burst_data[7];
}


void BME280_GetCalibData()
{



 msb = BME280_Read( 0x89 );
 lsb = BME280_Read( 0x88 );
 dig_T1 = ((unsigned int)msb << 8) + lsb;

 msb = BME280_Read( 0x8B );
 lsb = BME280_Read( 0x8A );
 dig_T2 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x8D );
 lsb = BME280_Read( 0x8C );
 dig_T3 = ((int)msb << 8) + lsb;




 msb = BME280_Read( 0x8F );
 lsb = BME280_Read( 0x8E );
 dig_P1 = ((unsigned int)msb << 8) + lsb;

 msb = BME280_Read( 0x91 );
 lsb = BME280_Read( 0x90 );
 dig_P2 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x93 );
 lsb = BME280_Read( 0x92 );
 dig_P3 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x95 );
 lsb = BME280_Read( 0x94 );
 dig_P4 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x97 );
 lsb = BME280_Read( 0x96 );
 dig_P5 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x99 );
 lsb = BME280_Read( 0x98 );
 dig_P6 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x9B );
 lsb = BME280_Read( 0x9A );
 dig_P7 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x9D );
 lsb = BME280_Read( 0x9C );
 dig_P8 = ((int)msb << 8) + lsb;

 msb = BME280_Read( 0x9F );
 lsb = BME280_Read( 0x9E );
 dig_P9 = ((int)msb << 8) + lsb;





 lsb = BME280_Read( 0xA1 );
 dig_H1 = (unsigned char)lsb;

 msb = BME280_Read( 0xE2 );
 lsb = BME280_Read( 0xE1 );
 dig_H2 = ((signed short)msb << 8) + lsb;

 lsb = BME280_Read( 0xE3 );
 dig_H3 = (unsigned char)lsb;

 msb = BME280_Read( 0xE4 );
 lsb = BME280_Read( 0xE5 );
 dig_H4 = ((signed short)msb << 4) | (lsb & 0x0F);

 msb = BME280_Read( 0xE6 );
 lsb = BME280_Read( 0xE5 );
 dig_H5 = ((signed short)msb << 4) | (lsb >> 4);

 lsb = BME280_Read( 0xE7 );
 dig_H6 = (signed char)lsb;
}


static long BME280_TemperatureComp()
{
 long temp1, temp2, T;
 temp1 = ((((adc_t>>3) -((long)dig_T1<<1))) * ((long)dig_T2)) >> 11;
 temp2 = (((((adc_t>>4) - ((long)dig_T1)) * ((adc_t>>4) - ((long)dig_T1))) >> 12) * ((long)dig_T3)) >> 14;
 t_fine = temp1 + temp2;
 T = (t_fine * 5 + 128) >> 8;

 return T;
}


static unsigned long BME280_PressureComp()
{
 long press1, press2;
 unsigned long int P;

 press1 = (((long)t_fine)>>1) - (long)64000;
 press2 = (((press1>>2) * (press1>>2)) >> 11 ) * ((long)dig_P6);
 press2 = press2 + ((press1*((long)dig_P5))<<1);
 press2 = (press2>>2)+(((long)dig_P4)<<16);
 press1 = (((dig_P3 * (((press1>>2) * (press1>>2)) >> 13 )) >> 3) + ((((long)dig_P2) * press1)>>1))>>18;
 press1 =((((32768+press1))*((long)dig_P1))>>15);
 if (press1 == 0)
 {
 return 0;
 }
 P = (((unsigned long)(((long)1048576)-adc_P)-(press2>>12)))*3125;
 if (P < 0x80000000) {
 P = (P << 1) / ((unsigned long)press1);
 } else {
 P = (P / (unsigned long)press1) * 2;
 }
 press1 = (((long)dig_P9) * ((long)(((p>>3) * (p>>3))>>13)))>>12;
 press2 = (((long)(p>>2)) * ((long)dig_P8))>>13;
 P = (unsigned long)((long)p + ((press1 + press2 + dig_P7) >> 4));

 return P;
}


static unsigned long BME280_HumidityComp()
{
 unsigned long int H;
 long h1;

 h1 = (t_fine - ((long)76800));
 h1 = (((((adc_H << 14) - (((long)dig_H4) << 20) - (((long)dig_H5) * h1)) +
 ((long)16384)) >> 15) * (((((((h1 * ((long)dig_H6)) >> 10) * (((h1 *
 ((long)dig_H3)) >> 11) + ((long)32768))) >> 10) + ((long)2097152)) *
 ((long)dig_H2) + 8192) >> 14));
 h1 = (h1 - (((((h1 >> 15) * (h1 >> 15)) >> 7) * ((long)dig_H1)) >> 4));
 h1 = (h1 < 0 ? 0 : h1);
 h1 = (h1 > 419430400 ? 419430400 : h1);
 H = (unsigned long)(h1>>12);

 return H;
}


float BME280_GetTemperature()
{
 float Temp;
 long T;
 T = BME280_TemperatureComp();
 Temp = (float)T/100;
 return Temp;
}


float BME280_GetPressure()
{
 float Press;
 long P;
 P = BME280_PressureComp();
 Press = (float)P/100;
 return Press;
}


float BME280_GetHumidity()
{
 float Hum;
 unsigned long H;
 H = BME280_HumidityComp();
 Hum = (float)H/1024;
 return Hum;
}


short int BME280_GetID()
{
 unsigned short id;
 id = BME280_Read( 0xD0 );
 return id;
}


short int BME280_GetStatus()
{
 unsigned short status;
 status = BME280_Read( 0xF3 );
 return (status & 0x08);
}


void BME280_SetTemperatureOversamp(unsigned short value)
{
 unsigned short ctrl;
 ctrl = BME280_Read( 0xF4 );
 ctrl &= 0x1F;
 ctrl |= value << 5;
 BME280_Write( 0xF4 , ctrl);
}


void BME280_SetPressureOversamp(unsigned short value)
{
 unsigned short ctrl;
 ctrl = BME280_Read( 0xF4 );
 ctrl &= 0xE3;
 ctrl |= value << 2;
 BME280_Write( 0xF4 , ctrl);
}


void BME280_SetHumidityOversamp(unsigned short value)
{
 unsigned short ctrl;
 ctrl = BME280_Read( 0xF2 );
 ctrl &= 0x00;
 ctrl |= value;
 BME280_Write( 0xF2 , ctrl);
}


void BME280_SetWorkingMode(unsigned short value)
{
 unsigned short ctrl;
 ctrl = BME280_Read( 0xF4 );
 ctrl &= 0xFC;
 ctrl |= value;
 BME280_Write( 0xF4 , ctrl);
}


void BME280_SetFilterCoeff(unsigned short value)
{
 unsigned short ctrl;
 ctrl = BME280_Read( 0xF5 );
 ctrl &= 0xE3;
 ctrl |= value << 2;
 BME280_Write( 0xF5 , ctrl);
}


void BME280_SetStdbyTime(unsigned short value)
{
 unsigned short ctrl;
 ctrl = BME280_Read( 0xF5 );
 ctrl &= 0x1F;
 ctrl |= value << 5;
 BME280_Write( 0xF5 , ctrl);
}


void BME280_SoftReset()
{
 BME280_Write( 0xE0 ,0xB6);
}
