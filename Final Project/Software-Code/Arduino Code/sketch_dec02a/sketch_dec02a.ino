/* 
 *  Bluetooh Basic: LED ON OFF - Avishkar
 *  Coder - Mayoogh Girish
 *  Website - http://bit.do/Avishkar
 *  Download the App : 
 *  This program lets you to control a LED on pin 13 of arduino using a bluetooth module
 */
char Incoming_value = 0;                //Variable for storing Incoming_value
void setup() 
{
  Serial.begin(9600);         //Sets the data rate in bits per second (baud) for serial data transmission
  pinMode(9, OUTPUT); 
  pinMode(8, OUTPUT); 
  pinMode(7, OUTPUT); 
  pinMode(6, OUTPUT); 
  pinMode(5, OUTPUT); 
  pinMode(4, OUTPUT); 
  pinMode(3, OUTPUT); 
  pinMode(2, OUTPUT); 
}
void loop()
{
  if(Serial.available() > 0)  
  {
    Incoming_value = Serial.read();      //Read the incoming data and store it into variable Incoming_value
    Serial.print(Incoming_value);        //Print Value of Incoming_value in Serial monitor
    Serial.print("\n");        //New line 
    if(Incoming_value == 'a')            //Checks whether value of Incoming_value is equal to 1 
      {
        digitalWrite(2, HIGH);
        digitalWrite(3, LOW);
        digitalWrite(4, LOW);
        digitalWrite(5, LOW);
        digitalWrite(6, LOW);
        digitalWrite(7, LOW);
        digitalWrite(8, LOW);
        digitalWrite(9, LOW);
        delay(0.5);
        digitalWrite(2, LOW);
        
      }
    else if(Incoming_value == 'b') 
    {
        digitalWrite(2, LOW);
        digitalWrite(3, HIGH);
        digitalWrite(4, LOW);
        digitalWrite(5, LOW);
        digitalWrite(6, LOW);
        digitalWrite(7, LOW);
        digitalWrite(8, LOW);
        digitalWrite(9, LOW);
        delay(0.5);
        digitalWrite(3, LOW);
    }
    else if(Incoming_value == 'c') 
    {
        digitalWrite(2, LOW);
        digitalWrite(3, LOW);
        digitalWrite(4, HIGH);
        digitalWrite(5, LOW);
        digitalWrite(6, LOW);
        digitalWrite(7, LOW);
        digitalWrite(8, LOW);
        digitalWrite(9, LOW);
        delay(0.5);
        digitalWrite(4, LOW);
    }
    else if(Incoming_value == 'd') 
    {
        digitalWrite(2, LOW);
        digitalWrite(3, LOW);
        digitalWrite(4, LOW);
        digitalWrite(5, HIGH);
        digitalWrite(6, LOW);
        digitalWrite(7, LOW);
        digitalWrite(8, LOW);
        digitalWrite(9, LOW);
        delay(0.5);
        digitalWrite(5, LOW);
    }
    else if(Incoming_value == 'e') 
    {
        digitalWrite(2, LOW);
        digitalWrite(3, LOW);
        digitalWrite(4, LOW);
        digitalWrite(5, LOW);
        digitalWrite(6, HIGH);
        digitalWrite(7, LOW);
        digitalWrite(8, LOW);
        digitalWrite(9, LOW);
        delay(0.5);
        digitalWrite(6, LOW);
    }
    else if(Incoming_value == 'f') 
    {
        digitalWrite(2, LOW);
        digitalWrite(3, LOW);
        digitalWrite(4, LOW);
        digitalWrite(5, LOW);
        digitalWrite(6, LOW);
        digitalWrite(7, HIGH);
        digitalWrite(8, LOW);
        digitalWrite(9, LOW);
        delay(0.5);
        digitalWrite(7, LOW);
    }
    else if(Incoming_value == 'g') 
    {
        digitalWrite(2, LOW);
        digitalWrite(3, LOW);
        digitalWrite(4, LOW);
        digitalWrite(5, LOW);
        digitalWrite(6, LOW);
        digitalWrite(7, LOW);
        digitalWrite(8, HIGH);
        digitalWrite(9, LOW);
        delay(0.5);
        digitalWrite(8, LOW);
    }
    else if(Incoming_value == 'h') 
    {
        digitalWrite(2, LOW);
        digitalWrite(3, LOW);
        digitalWrite(4, LOW);
        digitalWrite(5, LOW);
        digitalWrite(6, LOW);
        digitalWrite(7, LOW);
        digitalWrite(8, LOW);
        digitalWrite(9, HIGH);
        delay(0.5);
        digitalWrite(9, LOW);
    }
  }                            
 
}      
