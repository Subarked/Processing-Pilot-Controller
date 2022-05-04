/**
 * (./) udp.pde - how to use UDP library as unicast connection
 * (cc) 2006, Cousot stephane for The Atelier Hypermedia
 * (->) http://hypermedia.loeil.org/processing/
 *
 * Create a communication between Processing<->Pure Data @ http://puredata.info/
 * This program also requires to run a small program on Pd to exchange data
 * (hum!!! for a complete experimentation), you can find the related Pd patch
 * at http://hypermedia.loeil.org/processing/udp.pd
 *
 * -- note that all Pd input/output messages are completed with the characters
 * ";\n". Don't refer to this notation for a normal use. --
 */

// import UDP library
import hypermedia.net.*;


UDP udp;  // define the UDP object

/**
 * init
 */

String message = ""; // the message to send
String ip       = "subarked.duckdns.org";  // the remote IP address; Doesn't have to be duckdns, but  I don't wanna be  sharing  my ip to the world
int port        = 49161;    // the destination port
void setup() {
  size(400, 400);
  // create a new datagram connection on port 6000
  // and wait for incomming message
  udp = new UDP( this, 49160 );
  //udp.log( true ); 		// <-- printout the connection activity
  udp.listen( true );
}

//process events
void draw() {
  background(255);
  textSize(128);
  fill(0);
  textAlign(CENTER, CENTER);
  text(message, 200, 200);
}

/**
 * on key pressed event:
 * send the current key value over the network
 */
void keyPressed() {


  if (keyCode == ENTER) {
    // formats the message for Pd
    message = message+";\n";
    // send the message
    udp.send( message, ip, port );
    message = "";
  } else if ((keyCode >= 65 && keyCode <= 90)) {
    message += key;
  } else if ((keyCode >= 97 && keyCode <= 122)) {
    message += key;
  } else if ((keyCode >= 48 && keyCode <= 57)) {
    message += key;
  } else if (keyCode == 8) {
    if (message.length() >= 2) {
      message = message.substring(0, message.length()-1);
    } else if (message.length() == 1) {
      message = "";
    }
  } else {
    print(keyCode);
  }
}
