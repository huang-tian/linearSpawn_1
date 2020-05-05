class Linear {
  PVector vel;
  ArrayList<PVector> linepos;
  float angle;
  color c;
  boolean dead;

  Linear() {
    //this.pos =pos;
    linepos = new ArrayList<PVector>();
    vel = new PVector();
    angle = 0;
    c = color(random(100), random(40,100), random(70,100));
    dead = false;
  }


  void addpoint() {
    if (mousePressed &&  linepos.size()<30) {
      linepos.add(new PVector(mouseX, mouseY));
    }
  }

  void editvalue() {
    for (int i= 0; i < linepos.size(); i++) {
      //默认力noise
      angle = noise((linepos.get(i).x)/200, (linepos.get(i).y)/200)*200;
      vel = new PVector(sin(angle)*0.5, cos(angle)*0.5);
      linepos.get(i).add(vel.mult(1.6));//没鼠标引力时的值1.3
    }
  }

  void attract() {
    PVector mou = new PVector(mouseX, mouseY);

    for (int i = 0; i< linepos.size()-1; i++) {
      PVector subforce = PVector.sub(linepos.get(i), linepos.get(i+1));
      float d = PVector.dist(linepos.get(i), linepos.get(i+1));
      float limitd = pow(0.5, d/width); 
      subforce.mult(limitd);

      vel.add(subforce);
      vel.mult(0.04);//没鼠标引力的值0.05
      linepos.get(i+1).add(vel);
      vel.mult(0);

      //鼠标力
      PVector mforce = PVector.sub(mou, linepos.get(i));
      float dt = PVector.dist(mou, linepos.get(i));
      float limitdt = pow(0.5, dt/5);//调整半径
      mforce.mult(limitdt);
      //if (mousePressed) {
      vel.add(mforce);
      // }
      vel.mult(-10);//力的大小和方向
      linepos.get(i).add(vel);
      vel.mult(0);
    }
  }

  void checkedge() {
    float side = 150;
    for (int i =0; i < linepos.size(); i++) {
      if (linepos.get(i).x > width) {
        linepos.get(i).x=random(width-side, width);
      }
      if (linepos.get(i).x < 0) {
        linepos.get(i).x= random(side);
      }
      if (linepos.get(i).y > height) {
        linepos.get(i).y=random(height-side, height);
      }
      if (linepos.get(i).y < 0) {
        linepos.get(i).y=random(side);
      }
    }
  }



  void display() {
    stroke(c);
    strokeWeight(0.6);
    noFill();
    beginShape();
    curveVertex( linepos.get(0).x, linepos.get(0).y);
    curveVertex( linepos.get(0).x, linepos.get(0).y);
    for (int i =0; i< linepos.size(); i++) {
      curveVertex(linepos.get(i).x, linepos.get(i).y);
    }
    endShape();
  }
}
