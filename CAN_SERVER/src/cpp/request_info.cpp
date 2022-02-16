#include "../hpp/header.hpp"

/******************************************************************************************
** Function Name : print_info
** Description	 : Print requested car info to the App
*******************************************************************************************/
// void print_info(int request_num) {
//     unsigned int i = request_num;
//     int car_data = 0;
//     int ret;

//     if (i >= sizeof(getDataFp) / sizeof(getDataFp[0])) {
//         HC06.print("[");
//         HC06.print(i);
//         HC06.println("] has no name for car information");
//         Serial.print("[");
//         Serial.print(i);
//         Serial.println("] has no name for car information");
//         return ;
//     }
//     ret = getDataFp[i](&car_data);
//     if (ret) {
//         HC06.print(car_data_name[i]);
//         HC06.print(" : ");
//         HC06.println(car_data);
//         Serial.print(car_data_name[i]);
//         Serial.print(" : ");
//         Serial.println(car_data);
//     }
// }

// /******************************************************************************************
// ** Function Name : request_info
// ** Description	 : App requests car information to OBD module
// *******************************************************************************************/
// void request_info(int request_num) {
//     HC06.println("------------------------------------");
//     HC06.print("App request number [");
// 	HC06.print(request_num);
// 	HC06.println("] car information.");
//     Serial.println("------------------------------------");
//     Serial.print("App request number [");
// 	Serial.print(request_num);
// 	Serial.println("] car information.");
//     if (request_num < 0) {
//         HC06.println("Unavailable Value is requested.");
//         Serial.println("Unavailable Value is requested.");
//         HC06.println("------------------------------------");
//         Serial.println("------------------------------------");
//         return ;
// 	}
//     print_info(request_num);
// 	HC06.println("------------------------------------");
//     Serial.println("------------------------------------");
// }
