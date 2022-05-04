// import UDP library
import hypermedia.net.*;


UDP udp;  // define the UDP object
/**
 * init
 */

PFont font;



String message = " "; // the message to send
String ip       = "subarked.duckdns.org";  // the remote IP address; Doesn't have to be duckdns, but  I don't wanna be  sharing  my ip to the world
int port        = 49161;    // the destination port

void setup() {

  size(400, 400);

  String[] fontList = PFont.list();
  printArray(fontList);

  font = createFont("Bahnschrift",128);
  textFont(font);
  // create a new datagram connection on port 6000
  // and wait for incomming message
  udp = new UDP( this, 49160 );
  //udp.log( true ); 		// <-- printout the connection activity
  udp.listen( true );
}

//process events
void draw() {
  

  background(0);

  fill(255, 128, 0);
  textSize(30);
  textAlign(CENTER, CENTER);
  text(message, 0, 0, width, height);
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
  } else if (keyCode >= 48 && keyCode <= 57 || keyCode == 59) {
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
