#include <ESP8266WiFi.h>
#include <time.h>

const char* ssid = "42 Guest";  // AP SSID
const char* password = "WeL0ve42Seoul"; // AP password

const int   httpPort = 80;

// get the query string for required location from below:
// https://www.weather.go.kr/w/pop/rss-guide.do?sido=1100000000&gugun=1159000000&dong=1159065000
// it's Sadang-4-dong as an example
const char*   SERVER  = "www.kma.go.kr";
const String  KMA_url = "/wid/queryDFSRSS.jsp?zone=1159065000";


void setup(void) {
  Serial.begin(115200);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("\nConnecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  WiFiClient  client;
  int         i=0;
  String      a[3];
  String      temp;
  String      wfEn;
  String      reh;
  String      tmp_str;

  if (client.connect(SERVER, httpPort))
  {
    client.print(String("GET ") + KMA_url + " HTTP/1.1\r\n" +
    "Host: " + SERVER + "\r\n" + 
    "Connection: close\r\n\r\n");

    Serial.println("Request sent");
  
    while(client.connected()){
      String line = client.readStringUntil('\n');

      i= line.indexOf("</temp>");

      if(i>0){
        tmp_str="<temp>";
  
        temp = line.substring(line.indexOf(tmp_str)+tmp_str.length(),i);

      }

      i= line.indexOf("</wfEn>");

      if(i>0){
        tmp_str="<wfEn>";
        wfEn = line.substring(line.indexOf(tmp_str)+tmp_str.length(),i);
      }

      i= line.indexOf("</reh>");

      if(i>0){
        tmp_str="<reh>";
        reh = line.substring(line.indexOf(tmp_str)+tmp_str.length(),i);
        break;
      }
    }
  }
  else
  {
    Serial.println("Connection failed");
    return;
  }

  Serial.println("Temperature:"+temp);// Print the string name of the font
  Serial.println("Humidity   :"+reh);// Print the string name of the font
  Serial.println("Cloudy     :"+wfEn);// Print the string name of the font

  delay(2000);
}
