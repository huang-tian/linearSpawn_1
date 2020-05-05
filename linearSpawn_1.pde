ArrayList<Linear> linear;
int nc;
void settings() {
  size(500, 300);
}

void setup() {
  linear = new ArrayList<Linear>();
  colorMode(HSB, 100);
}


void draw() {
  background(0, 0, 0);
  for (int i= 0; i< linear.size(); i++) {
    linear.get(i).addpoint();
    linear.get(i).editvalue();
    linear.get(i).display();
    linear.get(i).attract();
    linear.get(i).checkedge();
  }

  if (millis()%3000>2900) {
    nc+=1;
  }
  noiseSeed(nc);
}

void mousePressed() {

  linear.add(new Linear());
}
