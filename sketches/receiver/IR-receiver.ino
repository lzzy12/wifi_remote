#include <IRremote.hpp>

#define IR_RECEIVE_PIN 5
#define IR_FEEDBACK_PIN 25
void setup() {
  Serial.begin(115200);
  Serial.println("Starting..");
  IrReceiver.begin(IR_RECEIVE_PIN, true, IR_FEEDBACK_PIN);
  Serial.println("Started IR reciever");
}

void loop() {
 if (IrReceiver.decode()) {
      Serial.println(IrReceiver.decodedIRData.decodedRawData, HEX);
      IrReceiver.resume(); // Enable receiving of the next value
  }  
}
