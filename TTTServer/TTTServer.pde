import processing.net.*;

color blue = #00E8FF;
color red = #FF0059;
boolean myTurn = true;

Server myServer;

int[][] grid;

void setup() {
  size(300, 300);
  grid = new int[3][3]; //row, column
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(50);
  myServer = new Server(this, 1234);
}

void draw() {
  if(myTurn) background(blue);
  else background(red);
  
  stroke(0);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);
  
  for(int row = 0; row < 3; row++) {
   for(int col = 0; col < 3; col++) {
    drawXO(row, col); 
   }
  }
}

void drawXO(int row, int col) {
 pushMatrix();
 translate(row*100, col*100);
 if(grid[row][col] == 1) {
   noFill();
   ellipse(50, 50, 90, 90);
 } else if (grid[row][col] == 2) {
   line(10, 10, 90, 90);
   line(90, 10, 10, 90);
 }
 popMatrix();
 
   Client myClient = myServer.available();
  if(myClient != null) {
    String incoming = myClient.readString(); 
    int r = int(incoming.substring(0, 1));
    int c = int(incoming.substring(2, 3));
    grid[r][c] = 1;
    myTurn = true;
  }
}

void mouseReleased() {
 int row = mouseX/100;
 int col = mouseY/100;
 if(myTurn && grid[row][col] == 0) {
   myServer.write(row + "," + col);
   grid[row][col] = 2;
   myTurn = false;
}
}
