/******************************************************************************/
/*                          BME280 DEFINITIONS                                */
/******************************************************************************/

/******************************************************************************/
/*             BME280 Sensor I2C Slave Address                                */
/******************************************************************************/
#define BME280_W           0xEC
#define BME280_R           0xED

/******************************************************************************/
/* BME280 Sensor Register Address*/
/******************************************************************************/
// Output Registers
#define HUM_LSB            0xFE
#define HUM_MSB            0xFD
#define TEMP_XLSB          0xFC
#define TEMP_LSB           0xFB
#define TEMP_MSB           0xFA
#define PRESS_XLSB         0xF9
#define PRESS_LSB          0xF8
#define PRESS_MSB          0xF7
// Configuration & Operation Registers
#define CONFIG             0xF5
#define CTRL_MEAS          0xF4
#define STATUS             0xF3
#define CTRL_HUM           0xF2
#define RESET              0xE0
#define ID_ADDRESS         0xD0
// Calibration Registers
#define CALIB00            0x88
#define CALIB01            0x89
#define CALIB02            0x8A
#define CALIB03            0x8B
#define CALIB04            0x8C
#define CALIB05            0x8D
#define CALIB06            0x8E
#define CALIB07            0x8F
#define CALIB08            0x90
#define CALIB09            0x91
#define CALIB10            0x92
#define CALIB11            0x93
#define CALIB12            0x94
#define CALIB13            0x95
#define CALIB14            0x96
#define CALIB15            0x97
#define CALIB16            0x98
#define CALIB17            0x99
#define CALIB18            0x9A
#define CALIB19            0x9B
#define CALIB20            0x9C
#define CALIB21            0x9D
#define CALIB22            0x9E
#define CALIB23            0x9F
#define CALIB24            0xA0
#define CALIB25            0xA1
#define CALIB26            0xE1
#define CALIB27            0xE2
#define CALIB28            0xE3
#define CALIB29            0xE4
#define CALIB30            0xE5
#define CALIB31            0xE6
#define CALIB32            0xE7
#define CALIB33            0xE8
#define CALIB34            0xE9
#define CALIB35            0xEA
#define CALIB36            0xEB
#define CALIB37            0xEC
#define CALIB38            0xED
#define CALIB39            0xEE
#define CALIB40            0xEF
#define CALIB41            0xF0

/******************************************************************************/
/*                   Mode Definitions                                         */
/******************************************************************************/
#define SLEEP_MODE         0x00
#define FORCED_MODE        0x01
#define NORMAL_MODE        0x03
/******************************************************************************/
/*                   Oversampling Definitions                                 */
/******************************************************************************/
#define OVERSAMP_NO        0x00
#define OVERSAMP_X1        0x01
#define OVERSAMP_X2        0x02
#define OVERSAMP_X4        0x03
#define OVERSAMP_X8        0x04
#define OVERSAMP_X16       0x05
/******************************************************************************/
/*                   Standby Time Definitions                                 */
/******************************************************************************/
#define STDBY_500_US       0x00
#define STDBY_62_5_MS      0x01
#define STDBY_125_MS       0x02
#define STDBY_250_MS       0x03
#define STDBY_500_MS       0x04
#define STDBY_1000_MS      0x05
#define STDBY_10_MS        0x06
#define STDBY_20_MS        0x07
/******************************************************************************/
/*                   Filter Coeficient Definitions                            */
/******************************************************************************/
#define FILTER_OFF         0x00
#define FILTER_2           0x01
#define FILTER_4           0x02
#define FILTER_8           0x03
#define FILTER_16          0x04
/******************************************************************************/
/*                         BME280 ID                                          */
/******************************************************************************/
#define BME280_ID          0x60