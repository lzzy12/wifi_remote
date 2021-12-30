#include <Arduino.h>
#include <WiFi.h>
#include <WebServer.h>
#include <ArduinoJson.h>
/*
 * Define macros for input and output pin etc.
 */
#include "PinDefinitionsAndMore.h"
#include <IRremote.hpp>


#define SSID "AndroidAP_6545"
#define PWD "kekwomegalulzfuckyoubitch"

WebServer server(80);

// Code to connect to WiFi
void connectToWiFi() {
  Serial.print("Connecting to ");
  Serial.println(SSID);
  /* This code does not work on a Mobile hotspot (the rest API stops responding)
  // IPAddress local_IP(192,168,10,47);
  // IPAddress gateway(192, 168, 2, 2);
  // IPAddress subnet(255, 255, 0, 0);
  // IPAddress primaryDNS(8, 8, 8, 8); 
  // IPAddress secondaryDNS(8, 8, 4, 4);
  // if (!WiFi.config(local_IP, gateway, subnet, primaryDNS, secondaryDNS)){
  //   Serial.println("Cannot configure static IP");
  // }
  */
  WiFi.begin(SSID, PWD);
  
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
 
  Serial.print("Connected. IP: ");
  Serial.println(WiFi.localIP());
}

// Code for setting up API endpoints
void setup_server(){
  server.on("/remote", HTTP_POST, handleRemote);
  server.begin();
}

int32_t hex2int(const char* hex) {
    uint32_t val = *hex > 56 ? 0xFFFFFFFF : 0;
    
    while (*hex) {
        // get current character then increment
        uint8_t byte = *hex++; 
        // transform hex character to the 4bit equivalent number, using the ascii table indexes
        if (byte >= '0' && byte <= '9') byte = byte - '0';
        else if (byte >= 'a' && byte <='f') byte = byte - 'a' + 10;
        else if (byte >= 'A' && byte <='F') byte = byte - 'A' + 10;    
        // shift 4 to make space for new digit, and add the 4 bits of the new digit 
        val = (val << 4) | (byte & 0xF);
        }
        return val;
  }

// Code to handle POST request
StaticJsonDocument<250> jsonDocument;
void handleRemote(){
  jsonDocument.clear();
  Serial.println("Got request on /remote");
  if (server.hasArg("plain") == false) {
    //handle error here
  }
  String body = server.arg("plain");
  if (body.isEmpty()){
    Serial.println("No data provided");
    server.send(400, "Application/Json", "{error: No data provided!}");
    return;
  }
  Serial.println("body: " + body);
  deserializeJson(jsonDocument, body);
  Serial.println("Reached json deserialization");
  const char* address = jsonDocument["address"];
  Serial.println("Reached address");
  const char* cmd = jsonDocument["cmd"];
  Serial.println("Reached cmd");

  if (strlen(address) == 0){
    Serial.println("No address provided");
    server.send(400, "Application/Json", "{error: No address provided!}");
    return;
  }
  if (strlen(cmd) == 0){
    Serial.println("No address provided");
    server.send(400, "Application/Json", "{error: No command provided!}");
    return;
  }
  sendIRSignal(hex2int(address), hex2int(cmd));
  server.send(200);
}


//#define SEND_PWM_BY_TIMER
//#define USE_NO_SEND_PWM
// #define NO_LED_FEEDBACK_CODE // saves 418 bytes program space


#define LED_BUILTIN 2
void setup() {
    pinMode(LED_BUILTIN, OUTPUT);

    Serial.begin(115200);

    IrSender.begin(); // Start with IR_SEND_PIN as send pin and if NO_LED_FEEDBACK_CODE is NOT defined, enable feedback LED at default feedback LED pin
    connectToWiFi();
    setup_server();
    Serial.print(F("Ready to send IR signals at pin "));
    Serial.println(IR_SEND_PIN);
}

/*
 * Set up the data to be sent.
 * For most protocols, the data is build up with a constant 8 (or 16 byte) address
 * and a variable 8 bit command.
 * There are exceptions like Sony and Denon, which have 5 bit address.
 */

void sendIRSignal(const int &address, const int &command) {
    /*
     * Print current send values
     */
    Serial.println();
    Serial.print(F("Send now: address=0x"));
    Serial.print(address, HEX);
    Serial.print(F(" command=0x"));
    Serial.print(command, HEX);
    Serial.println();
    Serial.flush();
    IrSender.sendNEC(address, command, 0);
}
void loop(){
  server.handleClient();
  // const char * address = "0xFD01";
  // const char * cmd = "0x23DC";
  // sendIRSignal(hex2int(address), hex2int(cmd));
  // delay(5000);
}