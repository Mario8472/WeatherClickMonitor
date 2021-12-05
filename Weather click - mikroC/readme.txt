/*
  Project:      Weather click
  MCU:          PIC18F45K22
  Dev. Board:   EasyPIC v7
  Oscilator:    8 MHz
  Sensor:       BME280 (Bosch)
  Author:       Mario Oletić, mag.ing.
  Date:         04.12.2019.
  
  Project description:
  ------------------------------------------------------------------------------
  Project is based on PIC18F45K22 MCU and BME280 combined temperature, pressure
  and humidity sensor. Functions have been developed for easier communication
  and work with the sensor. Sensor communicates with MCU via I2C. MCU aquires
  data from the sensor and manipulates it to get the true data values. These 
  final values are then sent via UART to external unit such as PC to display it.
*/