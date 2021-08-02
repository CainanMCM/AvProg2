// CLASSES //
Mario m;
princesa p;
escadaTrue e1, e2, e3, e4, e5, e6, e7, e8, e9;
Barril bvtr[];


// GLOBAIS //
int N = 14;
int t;
boolean bate, comeca;


void setup () {
  frameRate(30);
  size(800, 700);
  textAlign(CENTER);
  rectMode(CENTER);
  // ITENS //
  e1 = new escadaTrue();
  e1.escadaTX = 640;
  e1.escadaTY = 619;
  e2 = new escadaTrue();
  e2.escadaTX = 310;
  e2.escadaTY = 519;
  e3 = new escadaTrue();
  e3.escadaTX = 140;
  e3.escadaTY = 519;
  e4 = new escadaTrue();
  e4.escadaTX = 470;
  e4.escadaTY = 419;
  e5 = new escadaTrue();
  e5.escadaTX = 640;
  e5.escadaTY = 419;
  e6 = new escadaTrue();
  e6.escadaTX = 280;
  e6.escadaTY = 319;
  e7 = new escadaTrue();
  e7.escadaTX = 140;
  e7.escadaTY = 319;
  e8 = new escadaTrue();
  e8.escadaTX = 640;
  e8.escadaTY = 219;
  e9 = new escadaTrue();
  e9.escadaTX = 480;
  e9.escadaTY = 119;

  p = new princesa();

  m = new Mario();

  bvtr = new Barril[N];

  for (int i = 0; i < N; i++) {
    Barril j = new Barril();
    bvtr[i] = j;
  }
  // TESTES //
  bate = false;
  comeca = false;
}


void draw () {
  menuJogo ();
}


void menuJogo () {
  cenario();
  fill (0);
  rect(width/2, height/2, width, 200);
  fill(255);
  textSize(60);
  text("DONKEY KONG", width/2, height/2 - 30);
  textSize(30);
  text("PRESSIONE (X) PARA COMEÇAR", width/2, height/2 + 50);
  if ((keyPressed == true) && (key == 'x')) {
    comeca = true;
  }
  if (comeca == true) {
    jogo();
  }
}


void jogo () {
  cenario();
  p.desenha();
  m.limites();
  m.desenha();

  int temp = 1;
  t = t + 1;
  temp = temp + int(t/60);
  if (temp >= 12) {
    temp = 12;
  }
  for (int i=0; i< temp; i++) {
    bvtr[i].desenha();
  }
  if (bate == true) {
    fill (0);
    rect(width/2, height/2, width, 200);
    fill (255);
    textSize(60);
    text("GAME OVER", width/2, height/2 - 30);
    textSize(30);
    text("MAIS SORTE NA PRÓXIMA", width/2, height/2 + 50);
    noLoop();
  }

  p.win();
}


void keyPressed () {
  if (key == 'x') {
    m.pulo();
  }
  if (key == 'a') {
    m.variaMarioX = -3;
  }
  if (key == 'd') {
    m.variaMarioX = 3;
  }
}


void cenario () {
  background(0);
  fill(255);
  textSize(20);
  text("CONTROLE - W A S D", 110, 30);
  text("PULO - (X)", 57, 55);
  // ANDAIMES //
  for (int x = 0; x < 5; x++) {
    int dist = x*100;
    int varia; 
    if (x%2 == 0) {
      varia = -40;
    } else {
      varia = +40;
    }
    fill(148, 0, 57);
    rect(width/2, 684, width, 30);
    rect(width/2+varia, 584 - dist, width - 80, 30);
    rect(width/2, 84, 300, 30);
  }
  // ESCADAS //
  e1.desenha();
  e2.desenha();
  e3.desenha();
  e4.desenha();
  e5.desenha();
  e6.desenha();
  e7.desenha();
  e8.desenha();
  e9.desenha();
}

// TODAS CLASSES //
class Mario {
  int marioX, variaMarioX, j;
  float vel, delta, marioY, variaMarioY;
  Mario () {
    marioX = 30;
    marioY = 655;
    variaMarioX = 0;
    variaMarioY = 0;
    vel = 0;
    delta = 0;
  }

  void desenha() {
    vel = vel + delta;
    marioY = marioY + vel;

    if (marioY >= j) {
      vel = 0;
      marioY = j;
    }
    
    rectMode(CENTER);
    fill(255, 10, 25);
    marioX = marioX + variaMarioX;
    marioY = marioY + variaMarioY;
    rect(marioX, marioY, 20, 30);
    parado();
  }

  void parado () {
    if (keyPressed == false) {
      variaMarioX = 0;
      variaMarioY = 0;
    }
  }
  
  void pulo () {
    if (marioY == j) {
      vel = - 6;
    }
  }


  void limites() {
    j = 655;
    if (marioX <= 10) {
      marioX = 10;
    }
    if (marioX >= 790) {
      marioX = 790;
    }
    if (marioY >= 556) {
      j = 655;
      e1.sobeDesceEscadas ();
    }
    if (marioY <= 556 && marioY >= 456) {
      e1.sobeDesceEscadas ();
      if (marioX >= 250) {
        e2.sobeDesceEscadas ();
      }
      if (marioX <= 250) {
        e3.sobeDesceEscadas ();
      }
      j = 555;
      if (marioX >= 720) {
        j = 655;
      }
    }
    if (marioY <= 456 && marioY >= 356) {
      e2.sobeDesceEscadas ();
      e3.sobeDesceEscadas ();
      if (marioX <= 500) {
        e4.sobeDesceEscadas ();
      }
      if (marioX >= 500) {
        e5.sobeDesceEscadas ();
      }
      j = 455;
      if (marioX <= 80) {
        j = 555;
      }
    }
    if (marioY <= 356 && marioY >= 256) {
      e4.sobeDesceEscadas ();
      e5.sobeDesceEscadas ();
      if (marioX >= 250) {
        e6.sobeDesceEscadas ();
      }
      if (marioX <= 250) {
        e7.sobeDesceEscadas ();
      }
      j = 355;
      if (marioX >= 720) {
        j = 455;
      }
    }
    if (marioY <= 256 && marioY >= 156) {
      e6.sobeDesceEscadas ();
      e7.sobeDesceEscadas ();
      e8.sobeDesceEscadas ();
      j = 255;
      if (marioX <= 80) {
        j = 355;
      }
    }
    if (marioY <= 156 && marioY >= 56) {
      e8.sobeDesceEscadas ();
      e9.sobeDesceEscadas ();
      j = 155;
      if (marioX >= 720) {
        j = 255;
      }
    }
    if (marioY <= 56) {
      e9.sobeDesceEscadas ();
      j = 55;
      if (marioX <= 250 || marioX >= 550) {
        j = 155;
      }
    }
  }
}



class escadaTrue {
  int escadaTX, escadaTY;
  escadaTrue () {
    escadaTX = 0;
    escadaTY = 0;
  }
  void desenha () {
    rectMode(CENTER);
    fill(3, 166, 150);
    rect(escadaTX, escadaTY, 25, 100);
  }
  void sobeDesceEscadas () {
    if ((m.marioX >= (escadaTX - 10)) && (m.marioX <= escadaTX +10) && (m.marioY >= escadaTY-70) && (m.marioY <= escadaTY+40)) {
      m.delta = 0;
      if ((keyPressed == true) && (key == 'w')) {
        m.variaMarioY = -3;
        if (m.marioY <= escadaTY-62) {
          m.variaMarioY = 0;
        }
      }

      if ((keyPressed == true) && (key == 's')) {
        m.variaMarioY = 3;
        if (m.marioY >= escadaTY+35) {
          m.variaMarioY = 0;
        }
      }
    } else {
      m.delta = 0.4;
    }
  }
}



class princesa {
  int pX, pY, variaPx;
  princesa() {
    pX = 400;
    pY = 55;
    variaPx=3;
  }
  void desenha() {
    rectMode(CENTER);
    fill(173, 81, 181);
    pX = pX + variaPx;
    rect(pX, pY, 20, 30);
    move();
  }
  void move() {
    if (pX >= 500) {
      variaPx = -3;
    }
    if (pX <= 300) {
      variaPx = 3;
    }
  }
  void win() {
    if ((pX-10)<=(m.marioX+10) && (pX+10)>=(m.marioX-10) && pY == m.marioY) {
      fill (0);
      rect(width/2, height/2, width, 200);
      fill (255);
      textSize(60);
      text("PARABÉNS", width/2, height/2 - 30);
      textSize(30);
      text("VOCÊ CHEGOU ATÉ A PRINCESA", width/2, height/2 + 50);
      noLoop();
    }
  }
}



class Barril {
  int barrilX, barrilY, variaBarrilX, variaBarrilY; 
  Barril() {
    barrilX = 150;
    barrilY = 160;
    variaBarrilX = 6;
    variaBarrilY = 0;
  }
  void desenha() {
    fill(250, 220, 60);
    ellipse(barrilX, barrilY, 20, 20);
    mover();
    bateu();
  }
  void mover() {
    barrilY = barrilY + variaBarrilY;
    barrilX = barrilX + variaBarrilX;
    if (barrilX >= 730) {
      variaBarrilX = 0;
      variaBarrilY = 6;
    }
    if (barrilY >= 260) {
      variaBarrilX = -6;
      variaBarrilY = 0;
    }

    if (barrilX <= 70 && barrilY >= 260) {
      variaBarrilX = 0;
      variaBarrilY = 6;
    }
    if (barrilY >= 360) {
      variaBarrilX = 6;
      variaBarrilY = 0;
    }
    if (barrilX >= 730 && barrilY >= 360) {
      variaBarrilX = 0;
      variaBarrilY = 6;
    }
    if (barrilY >= 460) {
      variaBarrilX = -6;
      variaBarrilY = 0;
    }
    if (barrilX <= 70 && barrilY >= 460) {
      variaBarrilX = 0;
      variaBarrilY = 6;
    }
    if (barrilY >= 560) {
      variaBarrilX = 6;
      variaBarrilY = 0;
    }
    if (barrilX >= 730 && barrilY >= 560) {
      variaBarrilX = 0;
      variaBarrilY = 6;
    }
    if (barrilY >= 660) {
      variaBarrilX = -6;
      variaBarrilY = 0;
    }
    if (barrilX <= 0) {
      barrilX = 150;
      barrilY = 160;
      variaBarrilX = 6;
    }
  }
  void bateu() {
    if (barrilX+10 >= m.marioX-10 && barrilX-10 <= m.marioX+10 && barrilY <= m.marioY+15 && barrilY >= m.marioY-15) {
      bate = true;
    }
  }
}
