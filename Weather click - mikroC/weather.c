
/*
  Project:      Weather click
  MCU:          PIC18F45K22
  Dev. Board:   EasyPIC v7
  Oscilator:    8 MHz
  Sensor:       BME280 (Bosch)
  Author:       Mario Oletiæ, mag.ing.
  Date:         04.12.2019.
  
  Project description:
  ------------------------------------------------------------------------------
  Project is based on PIC18F45K22 MCU and BME280 combined temperature, pressure
  and humidity sensor. Functions have been developed for easier communication
  and work with the sensor. Sensor communicates with MCU via I2C. MCU aquires
  data from the sensor and manipulates it to get the data true values. These 
  final values are then sent via UART to external unit such as PC to display it.
*/

#include "BME280_Definitions.h"
#include "BME280_Driver.h"

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
   
   if(id == BME280_ID)
   {
      BME280_SoftReset();
      Delay_ms(300);
      BME280_GetCalibData();
      BME280_SetTemperatureOversamp(OVERSAMP_X1);
      BME280_SetPressureOversamp(OVERSAMP_X2);
      BME280_SetHumidityOversamp(OVERSAMP_X1);
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
   
      BME280_SetWorkingMode(FORCED_MODE);
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