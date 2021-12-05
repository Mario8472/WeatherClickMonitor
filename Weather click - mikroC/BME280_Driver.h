
/*
   BME280 Function signatures
*/

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