#line 1 "C:/Users/Mario/Desktop/Weather click/Weather click - mikroC/weather.c"
#line 1 "c:/users/mario/desktop/weather click/weather click - mikroc/bme280_definitions.h"
#line 1 "c:/users/mario/desktop/weather click/weather click - mikroc/bme280_driver.h"
#line 6 "c:/users/mario/desktop/weather click/weather click - mikroc/bme280_driver.h"
void BME280_BurstRead();
void BME280_GetCalibData();
float BME280_GetTemperature();
float BME280_GetPressure();
float BME280_GetHumidity();
void BME280_SetTemperatureOversamp(unsigned short value);
void BME280_SetPressureOversamp(unsigned short value);
void BME280_SetHumidityOversamp(unsigned short value);
void BME280_SetWorkingMode(unsigned short value);
void BME280_SetFilterCoeff(unsigned short value);
void BME280_SetStdbyTime(unsigned short value);
void BME280_SoftReset();
short int BME280_GetID();
short int BME280_GetStatus();
#line 23 "C:/Users/Mario/Desktop/Weather click/Weather click - mikroC/weather.c"
void MCU_Init()
{
 ANSELA = 0x00;
 ANSELB = 0x00;
 ANSELC = 0x00;
 ANSELD = 0x00;
 ANSELE = 0x00;

 TRISA = 0x00;
 TRISB = 0x00;
 TRISC = 0x00;
 TRISD = 0x00;
 TRISE = 0x00;

 LATA = 0x00;
 LATB = 0x00;
 LATC = 0x00;
 LATD = 0x00;
 LATE = 0x00;

 Delay_ms(10);

 I2C1_Init(10000);
 Delay_ms(150);

 UART1_Init(9600);
 Delay_ms(150);
}

void BME280_Init()
{
 unsigned short id;
 id = BME280_GetID();

 if(id ==  0x60 )
 {
 BME280_SoftReset();
 Delay_ms(300);
 BME280_GetCalibData();
 BME280_SetTemperatureOversamp( 0x01 );
 BME280_SetPressureOversamp( 0x02 );
 BME280_SetHumidityOversamp( 0x01 );
 }
 else
 {
 while(1)
 {
 LATB = id;
 LATD = ~LATD;
 UART1_Write_Text(" Wrong chip ID!!! ");
 UART1_Write(13);
 UART1_Write(10);
 Delay_ms(500);
 }
 }
}

void main()
{

 char tmp[20];
 char press[20];
 char hum[20];
 float temperature, pressure, humidity;

 MCU_Init();
 BME280_Init();

 while(1)
 {

 BME280_SetWorkingMode( 0x01 );
 BME280_BurstRead();
 temperature = BME280_GetTemperature();
 pressure = BME280_GetPressure();
 humidity = BME280_GetHumidity();

 sprintf(tmp, "%.2f", temperature);
 UART1_Write_Text("0000");
 UART1_Write_Text(tmp);
 UART1_Write('T');
 UART1_Write(13);
 UART1_Write(10);

 sprintf(press, "%.2f", pressure);
 UART1_Write_Text("000");
 UART1_Write_Text(press);
 UART1_Write_Text("P");
 UART1_Write(13);
 UART1_Write(10);

 sprintf(hum, "%.2f", humidity);
 UART1_Write_Text("0000");
 UART1_Write_Text(hum);
 UART1_Write_Text("H");
 UART1_Write(13);
 UART1_Write(10);

 Delay_ms(500);
 }


}
