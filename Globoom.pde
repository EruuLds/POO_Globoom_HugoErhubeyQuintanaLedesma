//Head

import processing.sound.*;
SoundFile battle;
SoundFile endbattle;
SoundFile air;
SoundFile endair;
SoundFile pop;
SoundFile title;
SoundFile beep;

PFont font;  
float alp = 128;
color c0 = color(255, 0, 0, alp);
color c1 = color(255, 255, 0, alp);
color c2 = color(0, 255, 0, alp);
color c3 = color(0, 0, 255, alp);
color c4 = color(128, 0, 255, alp);

float decima = 0.1;
 
// Variables de pantalla inicio.
float bottonArea = dist(width/2, 350, mouseX, mouseY);
int screen = 0;
float posYtitle = 0;
boolean titleUp = false;

// Variables de pantalla de selección de personaje.
int posSelectorX = 120;
int auSelector = 120;
int P1 = 0, P2 = 0;

// Variables de pantalla de batalla.

int CP1, CP2;
int press = 0;
float auPress = 20;
float auxSizeP1 = 100, auxSizeP2 = 100;
float sizeP1 = 100, sizeP2 = 100;
boolean turn;
boolean batallaTerminada = false;
int count = 180;
boolean P1Win = false;
boolean P2Win = false;
boolean inst = false;
boolean airp;
boolean NR;

// Variables de clases.
Pantalla0 PA = new Pantalla0();
Globo [] globos = new Globo [20];
Batalla esc = new Batalla();

Mono Rojolfo = new Mono(120, random(200, 230), 100, c0);
Mono Amauricio = new Mono(240, random(200, 230), 100, c1);
Mono Verduardo = new Mono(360, random(200, 230), 100, c2);
Mono Azucena = new Mono(480, random(200, 230), 100, c3);
Mono Moradid = new Mono(600, random(200, 230), 100, c4);

MonosFinal winner = new MonosFinal(random(100, 620), random(100, 460), 200);
MonosFinal loser = new MonosFinal(random(350, 370), random(270, 290), 800);

//Setup

void setup()
{
  font = loadFont("A48.vlw");
  textFont(font);
  size(720, 560);
  for(int i = 0; i < globos.length; i++)
  {
    globos [i] = new Globo();
  }
  title = new SoundFile(this, "title.wav");
  battle = new SoundFile(this, "battle.wav");
  endbattle = new SoundFile(this, "endbattle.wav");
  air = new SoundFile(this, "air.wav");
  endair = new SoundFile(this, "endair.wav");
  pop = new SoundFile(this, "pop.wav");
  beep = new SoundFile(this, "beep.wav");
  
  title.loop();
}

void keyPressed()
{
  // Mover selector hacia la derecha.
  
  if(screen == 1)
  {
    if(key == 'd' || key == 'D')
    {
      posSelectorX += auSelector;
      beep.play();
    }
    if(posSelectorX > 600)
    {
      posSelectorX = auSelector;
    }
    // Mover selector hacia la izquierda.
    if(key == 'a' || key == 'A')
    {
      posSelectorX -= auSelector;
      beep.play();
    }
    if(posSelectorX < auSelector)
    {
      posSelectorX = 600;
    }
  }
  
  //Asignar un personaje a P1 y P2.
  if(key == ' ' && screen == 1)  
  {
    beep.play();
    switch((int)posSelectorX)
    {
      case 120:
      if(P1 == 0)
      P1 = 1;
      else if(P2 == 0 && P1 != 1)
      P2 = 1;
      break;
    
      case 240:
      if(P1 == 0)
      P1 = 2;
      else if(P2 == 0 && P1 != 2)
      P2 = 2;
      break;
    
      case 360:
      if(P1 == 0)
      P1 = 3;
      else if(P2 == 0 && P1 != 3)
      P2 = 3;
      break;
      
      case 480:
      if(P1 == 0)
      P1 = 4;
      else if(P2 == 0 && P1 != 4)
      P2 = 4;
      break;
      
      case 600:
      if(P1 == 0)
      P1 = 5;
      else if(P2 == 0 && P1 != 5)
      P2 = 5;
      break;
    }
    CP1 = P1;
    CP2 = P2;
  }
  
  if(key == ENTER && P1 != 0 && P2 != 0 && screen == 1)
  {
    beep.play();
    screen = 2;
    turn = false;
  }
  
  if((key == ENTER || key == ' ') && screen == 3)
  {
    count = 180;
    sizeP1 = 100;
    sizeP2 = 100;
    auxSizeP1 = 100;
    auxSizeP2 = 100;
    P1 = 0;
    P2 = 0;
    batallaTerminada = false;
    posYtitle = 0;
    titleUp = false;
    turn = false;
    P1Win = false;
    P2Win = false;
    inst = false;
    posSelectorX = 120;
    decima = 0.1;
    press = 0;
    auPress = 20;
    
    Rojolfo.posy = random(200, 230);
    Amauricio.posy = random(200, 230);
    Verduardo.posy = random(200, 230);
    Azucena.posy = random(200, 230);
    Moradid.posy = random(200, 230);
  }
  
  if(key == ENTER && screen == 3)
  screen = 0;
  if(key == ' ' && screen == 3)
  screen = 1;
  
  if(screen == 2 && inst == false)
  beep.play();
  
}

void mousePressed()
{
  float bottonArea = dist(width/2, 350, mouseX, mouseY);
  if (bottonArea < 75 && mouseButton == LEFT && screen == 0)
  {
    titleUp = true;
    beep.play();
  }
}

void keyReleased()
{
  if(press != 0 && sizeP1 == sizeP1 && turn == false && sizeP1 >= auxSizeP1 && sizeP2 >= auxSizeP2 && inst == true)
  {
    switch(press)
    {
      case 20:
      auxSizeP1 += 5;
      air.play();
      break;
      case 40:
      auxSizeP1 += 10;
      air.play();
      break;
      case 60:
      auxSizeP1 += 15;
      air.play();
      break;
      case 80:
      auxSizeP1 += 20;
      air.play();
      break;
      case 100:
      auxSizeP1 += 25;
      air.play();
      break;
    }
  }
  if(press != 0 && sizeP2 == sizeP2 && turn == true && sizeP1 >= auxSizeP1 && sizeP2 >= auxSizeP2 && inst == true)
  {
    switch(press)
    {
      case 20:
      auxSizeP2 += 5;
      air.play();
      break;
      case 40:
      auxSizeP2 += 10;
      air.play();
      break;
      case 60:
      auxSizeP2 += 15;
      air.play();
      break;
      case 80:
      auxSizeP2 += 20;
      air.play();
      break;
      case 100:
      auxSizeP2 += 25;
      air.play();
      break;
    }
  }
  
  if(key == ' ' && turn == false && press <= 0 && inst == true)
  turn = true;
  
  else if(key == ' ' && turn == true && press <= 0 && inst == true)
  turn = false;
  
  if(key == ' ' && screen == 2)
  {
    inst = true;
  }
  if(key == ' ' && screen == 2 && auxSizeP1 == 100 && NR == false)
  {
    title.stop();
    battle.loop();
  }
}

//Draw

void draw()
{ 
  println(P1Win, " | ", P2Win, " | ", count);
  
  switch (screen)
  {
    case 0: //Pantalla de inicio.
    
    background(#E0FFF5);
    
    if (titleUp == true)
    posYtitle -= 6;
    if (posYtitle < -450)
    screen = 1;
    
    for(int i = 0; i < globos.length; i++)
    {
      globos [i].moveGlobo();
      globos [i].displayGlobo();
    }
    
    PA.title();
    PA.button();
    break;
    
    case 1: //Pantalla de selección de personaje
    
    println("Posicion del selector: ", posSelectorX," | Jugador 1: ", P1," | Jugador 2: ", P2);
    
    background(#FFE5E5);
    
    if(P1 != 0 && P2 != 0)
    decima = 0;
    
    if(P1 != 1 && P2 != 1)
    {
      Rojolfo.move();
      Rojolfo.display();
    }
    else
    {
      Rojolfo.display();
      Rojolfo.ascend();
    }
    
    if(P1 != 2 && P2 != 2)
    {
      Amauricio.move();
      Amauricio.display();
    }
    else
    {
      Amauricio.display();
      Amauricio.ascend();
    }
    
    if(P1 != 3 && P2 != 3)
    {
      Verduardo.move();
      Verduardo.display();
    }
    else
    {
      Verduardo.display();
      Verduardo.ascend();
    }
    
    if(P1 != 4 && P2 != 4)
    {
      Azucena.move();
      Azucena.display();
    }
    else
    {
      Azucena.display();
      Azucena.ascend();
    }
    
    if(P1 != 5 && P2 != 5)
    {
      Moradid.move();
      Moradid.display();
    }
    else
    {
      Moradid.display();
      Moradid.ascend();
    }
    
    break;
    
    case 2:
    
    background(#FFFEDB);
    
    float barraPresP1 = map(sizeP1, 100, 300, 0, 330);
    float barraPresP2 = map(sizeP2, 100, 300, 0, 330);
    
    esc.scenary();
    
    Batalla GP1 = new Batalla(180, 270, sizeP1, 130, 100, 10, 10, barraPresP1, CP1);
    Batalla GP2 = new Batalla(540, 270, sizeP2, 490, 100, 370, 10, barraPresP2, CP2);
    
    GP1.barraDePresion();
    GP2.barraDePresion(); 
    
    if(battle.isPlaying() && sizeP1 < 110 && sizeP2 < 110)
    {
      NR = true;
    }
    else
    NR = false;
    
    if (keyPressed && key == ' ' && sizeP1 >= auxSizeP1 && sizeP2 >= auxSizeP2 && batallaTerminada == false && inst == true)
    {
      press += auPress;
      if(press <= 0 || press >= 100)
      {  
        auPress *= -1;
      }
    }
    
    if(turn == false && batallaTerminada == false)
    {
      GP1.barraTurno();
      
      textAlign(CENTER);
      textSize(20);
      fill(128);
      text("Jugador 1, es tu turno.", 360, 480);
      
      if(air.isPlaying())
      airp = true;
      else
      airp = false;
      
      if(battle.isPlaying())
      {
        if(sizeP1 > 270 && sizeP2 < 270)
        {
          NR = false;
          battle.stop();
          endbattle.loop();
        }
      }
      
      if(battle.isPlaying())
      {
        if(sizeP2 > 270 && sizeP1 < 270)
        {
          NR = false;
          battle.stop();
          endbattle.loop();
        }
      }
      
      if(sizeP1 < auxSizeP1)
      {
        sizeP1 += 0.5;
        if(press != 0 && sizeP1 == auxSizeP1)
        {
          if(air.isPlaying() && inst == true)
          {
            air.stop();
            endair.play();
          }
          turn = true;
          press = 0;
          if(auPress < 0)
          {
            auPress *= -1;
          }
        }  
      }
    }
    
    if(turn == true && batallaTerminada == false)
    {
      GP2.barraTurno();
      
      textAlign(CENTER);
      textSize(20);
      fill(128);
      text("Jugador 2, es tu turno.", 360, 480);
      
      if(sizeP2 < auxSizeP2)
      {
        sizeP2 += 0.5;
        if(press != 0 && sizeP2 == auxSizeP2)
        {
          if(air.isPlaying() && inst == true)
          {
            air.stop();
            endair.play();
          }
          turn = false;
          press = 0;
          if(auPress < 0)
          {
            auPress *= -1;
          }
        }
      }
    }
    
    if(sizeP1 < 300)
    {
      GP1.display();
    }
    else
    {
      batallaTerminada = true;
      
      P1Win = true;
      if(P1 == 1)
      winner.c = c0;
      if(P1 == 2)
      winner.c = c1;
      if(P1 == 3)
      winner.c = c2;
      if(P1 == 4)
      winner.c = c3;
      if(P1 == 5)
      winner.c = c4;
      
      if(P2 == 1)
      loser.c = color(255, 0, 0, 90);
      if(P2 == 2)
      loser.c = color(255, 255, 0, 90);
      if(P2 == 3)
      loser.c = color(0, 255, 0, 90);
      if(P2 == 4)
      loser.c = color(0, 0, 255, 90);
      if(P2 == 5)
      loser.c = color(128, 0, 255, 90);
    }
    
    if(sizeP2 < 300)
    GP2.display();
    else
    {
      batallaTerminada = true;
      
      P2Win = true;
      if(P2 == 1)
      winner.c = c0;
      if(P2 == 2)
      winner.c = c1;
      if(P2 == 3)
      winner.c = c2;
      if(P2 == 4)
      winner.c = c3;
      if(P2 == 5)
      winner.c = c4;
      
      if(P1 == 1)
      loser.c = color(255, 0, 0, 90);
      if(P1 == 2)
      loser.c = color(255, 255, 0, 90);
      if(P1 == 3)
      loser.c = color(0, 255, 0, 90);
      if(P1 == 4)
      loser.c = color(0, 0, 255, 90);
      if(P1 == 5)
      loser.c = color(128, 0, 255, 90);
    }
    
    if(batallaTerminada == true)
    {
      if(count > 0)
      count--;
      if(air.isPlaying() || endair.isPlaying() || endbattle.isPlaying())
      {
        air.stop();
        endair.stop();
        pop.play();
        endbattle.stop();
        title.loop();
      }
    }
    
    if(count == 0)
    {
      screen = 3;
    }
    
    if(inst == false)
    {
      noStroke();
      fill(0, 128);
      rect(0, 0, 720, 560);
      textAlign(CENTER);
      textSize(20);
      fill(255);
      text("I N S T R U C C I O N E S", 360, 100);
      text("Cuando sea tu turno, mantén presionada la tecla espacio", 360, 140);
      text("hasta que decidas que el indicador muestra la cantidad", 360, 170);
      text("suficiente para inflar tu globo.", 360, 200);
      text("Si al soltar la tecla espacio tu indicador vuelve a", 360, 260);
      text("quedar vacío, tu globo no se inflará y el turno pasará", 360, 290);
      text("a ser del jugador oponente.", 360, 320);
      text("El ganador será el primer globo que acumule la suficiente", 360, 380);
      text("presión de aire y explote.", 360, 410);
      text("PRESIONA LA TECLA ESPACIO PARA INICIAR", 360, 480);
    }
    
    break;
    
    case 3:
    
    background(255);
    
    loser.los();
    loser.trem();
    
    for(int i = 0; i < globos.length; i++)
    {
      globos [i].moveGlobo();
      globos [i].displayGlobo();
    }
    
    winner.win();
    winner.move();
  }  
}

class Batalla
{
  float posxP, posyP, posBarX, posBarY, posPressX, posPressY, tamano, presion;
  int CP;
  
  Batalla()
  {
  }
  
  Batalla(float posxP_, float posyP_, float tamano_, float posBarX_, float posBarY_, float posPressX_, float posPressY_, float presion_, int CP_)
  {
    presion = presion_;
    tamano = tamano_;
    posxP = posxP_;
    posyP = posyP_;
    posBarX = posBarX_;
    posBarY = posBarY_;
    posPressX = posPressX_;
    posPressY = posPressY_;
    CP = CP_;
  }
  
  void barraDePresion()
  { 
    float redBar = map(presion, 0, 165, 0, 255);
    float greenBar = map(presion, 165, 330, 255, 0);
    
    noStroke();  
    fill(255);
    rect(posPressX, posPressY, 340, 20);
    fill(redBar, greenBar, 100);
    rect(posPressX + 5, posPressY + 5, presion, 10);
  }
  
  void barraTurno()
  {
    if(sizeP1 < 300 && sizeP2 < 300)
    {
      fill(255);
      rect(posBarX-5, posBarY-5, 110, 20);
    }
    
    if(CP == 1)
    fill(c0);
    if(CP == 2)
    fill(c1);
    if(CP == 3)
    fill(c2);
    if(CP == 4)
    fill(c3);
    if(CP == 5)
    fill(c4);
    noStroke();
    rect(posBarX, posBarY, press, 10);
  }
  
  void scenary()
  {
    noStroke();
    if(sizeP1 < 300 && sizeP2 < 300)
    fill(0, 255, 0, 30);
    
    if(turn == false)
    rect(0, 0, 360, 560);
    else
    rect(360, 0, 360, 560);
    
    fill(128);
    rect(178, 280, 4, 150);
    rect(538, 280, 4, 150);
    fill(200, 0, 0);
    rect(176, 280, 8, 5, 50);
    rect(536, 280, 8, 5, 50);
    fill(#AAEDFF);
    rect(155, 430, 50, 230, 30, 30, 0, 0);
    rect(515, 430, 50, 230, 30, 30, 0, 0);
    
    textAlign(CENTER);
    textSize(14);
    fill(128);
    text("P R E S I Ó N  D E L  J U G A D O R  1", 180, 55);
    text("P R E S I Ó N  D E L  J U G A D O R  2", 540, 55);
  }
  
  void display()
  {
    noStroke();
    
    if(CP == 1)
    fill(c0);
    if(CP == 2)
    fill(c1);
    if(CP == 3)
    fill(c2);
    if(CP == 4)
    fill(c3);
    if(CP == 5)
    fill(c4);
    
    ellipse(posxP, posyP, tamano, tamano);
    if(tamano < 270 && batallaTerminada == false)
    {
      fill(0);
      ellipse(posxP-100*0.15, posyP, 100*0.05, 100*0.05);
      ellipse(posxP+100*0.15, posyP, 100*0.05, 100*0.05);
      stroke(0);
      noFill();
      arc(posxP, posyP, 100*0.1, 100*0.1, 0, PI); 
    }
    else
    {
      fill(0);
      ellipse(posxP-100*0.15, posyP, 100*0.1, 100*0.1);
      ellipse(posxP+100*0.15, posyP, 100*0.1, 100*0.1);
      noStroke();
      fill(255);
      ellipse(posxP-100*0.16, posyP-100*0.02, 100*0.04, 100*0.04);
      ellipse(posxP+100*0.14, posyP-100*0.02, 100*0.04, 100*0.04);
      ellipse(posxP-100*0.14, posyP+100*0.02, 100*0.02, 100*0.02);
      ellipse(posxP+100*0.16, posyP+100*0.02, 100*0.02, 100*0.02);
      
      stroke(0);
      fill(0);
      if(batallaTerminada == false)
      arc(posxP, posyP, 100*0.1, 100*0.1, 0, PI);
      else
      {
        noFill();
        arc(posxP, posyP+100*0.05, 100*0.1, 100*0.1, PI, TWO_PI);
      }
      noFill();
    }
  }
}

class Globo
{
  //Parámetros
  float posx, posy;
  float velocidad;
  float tamano;
  color cg = color(random(255), random(255), random(255), 100);
  
  //Constructor
  
  Globo()
  {
    posx = random(width);
    posy = height+tamano/2;
    velocidad = random(1, 3);
    tamano = random(45, 60);
    cg = color(random(255), random(255), random(255), 100);
  }
  
  //Métodos
  void moveGlobo()
  {
    posy -= velocidad;
  }
  
  void displayGlobo()
  {
    noStroke();
    fill(cg);
    ellipse(posx, posy, tamano, tamano);
    if(posy < (posy-tamano/2)-(posy+tamano*2))
    {
      posy = height+tamano/2;
      posx = random(width);
      tamano = random(45, 60);
      velocidad = random(1, 2);
      cg = color(random(255), random(255), random(255), 100);
    }
    stroke(128);
    noFill();
    //line(posx, posy+tamano/2, posx-5, posy+tamano);
    //line(posx+tamano/2, posy+tamano*1.5, posx, posy+tamano*2);
    
    bezier(posx, posy+tamano/2, posx-tamano/4, posy+tamano, posx+tamano/2, posy+tamano*1.5, posx, posy+tamano*2);
  }
}

class MonosFinal
{
  float posx, posy, tamano;
  color c;
  float dx = 1, dy = 2;
  
  MonosFinal(float posx_, float posy_, float tamano_)
  {
    posx = posx_;
    posy = posy_;
    tamano = tamano_;
  }
  
  void move()
  {
    posx += dx;
    posy += dy;
    
    if(posx < 0 + (tamano/2) || posx > 720 - (tamano/2))
    dx *= -1;
    if(posy < 0 + (tamano/2) || posy > 560 - (tamano/2))
    dy *= -1;
  }
  
  void trem()
  {
    posx =random(350, 370);
    posy =random(270, 290);
  }
  
  void win()
  { 
    stroke(0);
    noFill();
    bezier(posx, posy+tamano/2, posx-tamano/4, posy+tamano, posx+tamano/2, posy+tamano*1.5, posx, posy+tamano*2);
    noStroke();
    fill(c);
    
    ellipse(posx, posy, tamano, tamano);
    fill(0);
    ellipse(posx-tamano*0.15, posy, tamano*0.1, tamano*0.1);
    ellipse(posx+tamano*0.15, posy, tamano*0.1, tamano*0.1);
    arc(posx, posy, tamano*0.1, tamano*0.1, 0, PI);
    noStroke();
    fill(255);
    ellipse(posx-tamano*0.16, posy-tamano*0.02, tamano*0.04, tamano*0.04);
    ellipse(posx+tamano*0.14, posy-tamano*0.02, tamano*0.04, tamano*0.04);
    ellipse(posx-tamano*0.14, posy+tamano*0.02, tamano*0.02, tamano*0.02);
    ellipse(posx+tamano*0.16, posy+tamano*0.02, tamano*0.02, tamano*0.02);
    
    fill(255, 128);
    rect(160, 130, 400, 300, 30);   
    
    if(P1Win == true)
    {
      textAlign(CENTER);
      textSize(40);
      fill(128);
      text("G A N A D O R", 360, 190);
      text("Jugador 1", 360, 260);
      textSize(16);
      text("Presiona ENTER para volver al inicio.", 360, 380);
      text("Presiona la tecla ESPACIO para volver jugar.", 360, 410);
      
      if(P1 == 1)
      {
        textSize(48);
        fill(c0);
        text("Rojolfo", 360, 320);
      }
      if(P1 == 2)
      {
        textSize(48);
        fill(c1);
        text("Amauricio", 360, 320);
      }
      if(P1 == 3)
      {
        textSize(48);
        fill(c2);
        text("Verduardo", 360, 320);
      }
      if(P1 == 4)
      {
        textSize(48);
        fill(c3);
        text("Azucena", 360, 320);
      }
      if(P1 == 5)
      {
        textSize(48);
        fill(c4);
        text("Moradid", 360, 320);
      }
    }
    
    if(P2Win == true)
    {
      textAlign(CENTER);
      textSize(30);
      fill(128);
      
      textAlign(CENTER);
      textSize(40);
      fill(128);
      text("G A N A D O R", 360, 190);
      text("Jugador 2", 360, 260);
      textSize(16);
      text("Presiona ENTER para volver al inicio.", 360, 380);
      text("Presiona la tecla ESPACIO para volver jugar.", 360, 410);
      
      if(P2 == 1)
      {
        textSize(48);
        fill(c0);
        text("Rojolfo", 360, 320);
      }
      if(P2 == 2)
      {
        textSize(48);
        fill(c1);
        text("Amauricio", 360, 320);
      }
      if(P2 == 3)
      {
        textSize(48);
        fill(c2);
        text("Verduardo", 360, 320);
      }
      if(P2 == 4)
      {
        textSize(48);
        fill(c3);
        text("Azucena", 360, 320);
      }
      if(P2 == 5)
      {
        textSize(48);
        fill(c4);
        text("Moradid", 360, 320);
      }
    }
  }
  
  void los()
  {
    strokeWeight(7);
    noStroke();
    fill(c);
    ellipse(posx, posy, tamano, tamano);
    fill(0, 90);
    ellipse(posx-tamano*0.15, posy, tamano*0.1, tamano*0.1);
    ellipse(posx+tamano*0.15, posy, tamano*0.1, tamano*0.1);
    stroke(0, 50);
    line(posx-tamano*0.2, posy-tamano*0.1, posx-tamano*0.07, posy-tamano*0.07);
    line(posx+tamano*0.2, posy-tamano*0.1, posx+tamano*0.07, posy-tamano*0.07);
    noFill();
    arc(posx, posy+tamano*0.05, tamano*0.1, tamano*0.1, PI, TWO_PI);
    noStroke();
    fill(255);
    ellipse(posx-tamano*0.16, posy-tamano*0.02, tamano*0.04, tamano*0.04);
    ellipse(posx+tamano*0.14, posy-tamano*0.02, tamano*0.04, tamano*0.04);
    ellipse(posx-tamano*0.14, posy+tamano*0.02, tamano*0.02, tamano*0.02);
    ellipse(posx+tamano*0.16, posy+tamano*0.02, tamano*0.02, tamano*0.02);
    strokeWeight(1);
  }
}

class Pantalla0
{
  float titleX, titleY;
  
  Pantalla0()
  {
    titleX = 0;
  }
  
  void title()
  {
    pushMatrix();
    translate(width/2, height/2);
    
    titleY = posYtitle;
    
    noStroke();
    ellipseMode(CORNER);
    fill(50, 170, 230, 190);
    //G
    ellipse(titleX-290, titleY-180, 100, 100); //100
    rect(titleX-240, titleY-140, 50, 20, 50);//140
    rect(titleX-210, titleY-140, 20, 60, 50);
    //L
    rect(titleX-180, titleY-170, 20, 90, 50);
    //O
    ellipse(titleX-150, titleY-150, 70, 70); //130
    //B
    rect(titleX-70, titleY-170, 20, 90, 50); //110
    ellipse(titleX-70, titleY-150, 70, 70);
    //O
    ellipse(titleX+10, titleY-150, 70, 70);
    //O
    ellipse(titleX+90, titleY-150, 70, 70);
    //M
    rect(titleX+170, titleY-150, 20, 70, 50);
    arc(titleX+170, titleY-150, 70, 70, PI, PI*2);
    arc(titleX+220, titleY-150, 70, 70, PI, PI*2);
    rect(titleX+170, titleY-115, 70, 35, 0, 0, 0, 50);
    rect(titleX+220, titleY-115, 70, 35, 0, 0, 50, 0);
    
    popMatrix();
    
    ellipseMode(CENTER);    
  }
  
  void button()
  {
    float disMouse_Button = dist(width/2, 350, mouseX, mouseY);
    float buttonSize = 150;
    
    if (disMouse_Button <= 75 && titleUp == false)
    {
      buttonSize = 160;
    }
    
    if(titleUp == false)
    {
      fill(128);
      textSize(20);
      textAlign(CENTER);
      text("Click sobre el botón para jugar.", 360, 480);
    }
    
    fill(30, 230, 130, 190);
    ellipse(width/2, 350+posYtitle, buttonSize, buttonSize);
    fill(255);
    triangle(366-21.65, 350-25+posYtitle, 366-21.65, 350+25+posYtitle, 366+21.65, 350+posYtitle);
  }
}

class Mono
{
  float posx, posy, tamano, moveY;
  color cg;
  
  Mono(float posx_, float posy_, float tamano_, color cg_)
  {
    posx = posx_;
    posy = posy_;
    tamano = tamano_;
    cg = cg_;
    moveY = 0.3;
  }
  
  void move()
  {
    posy += moveY;
    
    if(posy < 200 || posy > 230)
    {
      moveY *= -1;
    }
  }
  
  void ascend()
  {
    if(posy < -220)
    {
      posy = -220 ;
    }
    if(P1 != 0 || P2 != 0)
    {
      posy -= 6;
    }
  }
  
  void display()
  {
    textSize(16);
    fill(128);
    textAlign(CENTER);
    if(P1 == 0 || P2 == 0)
    {
      text("Utiliza A y D para mover el selector.", 360, 30);
      text("Presiona la tecla espacio para seleccionar tu personaje.", 360, 50);
    }
    else
    {
      textSize(25);
      text("Presiona ENTER para jugar.", 360, 80);
    }
    if(P1 == 0)
    {
      fill(60);
      textSize(20);
      text("Jugador  1, elige a tu personaje:", 360, 90);
    }
    else if(P2 == 0)
    {
      fill(60);
      textSize(20);
      text("Jugador  2, elige a tu personaje:", 360, 90);
    }
    float tam = tamano;
    
    if (posSelectorX == (int)posx && (P1 == 0 || P2 == 0))
    {
      tam = tamano + tamano*decima;
      
      switch((int)posx)
      {
        case 120:
        
        if(P1 != 1 && P2 != 1)
        {
          fill(128, 0, 0, alp);
          textSize(14);
          text("Rojolfo", 120, 135);
          noFill();
        }
        
        break;
        
        case 240:
        
        if(P1 != 2 && P2 != 2)
        {
          fill(128, 128, 0, alp);
          textSize(14);
          text("Amauricio", 240, 135);
          noFill();
        }
        break;
        
        case 360:
        
        if(P1 != 3 && P2 != 3)
        {
          fill(0, 128, 0, alp);
          textSize(14);
          text("Verduardo", 360, 135);
          noFill();
        }
        break;
        
        case 480:
        
        if(P1 != 4 && P2 != 4)
        {
          fill(0, 0, 128, alp);
          textSize(14);
          text("Azucena", 480, 135);
          noFill();
        }
        break;
        
        case 600:
        
        if(P1 != 5 && P2 != 5)
        {
          fill(64, 0, 128, alp);
          textSize(14);
          text("Moradid", 600, 135);
          noFill();
        }
        break;
      }
    }
   
    noFill();
    bezier(posx, posy+tam/2, posx-tam/4, posy+tam, posx+tam/2, posy+tam*1.5, posx, posy+tam*2);
    noStroke();
    fill(cg);
    ellipse(posx, posy, tam, tam);
    fill(0);
    ellipse(posx-tam*0.15, posy, tam*0.05, tam*0.05);
    ellipse(posx+tam*0.15, posy, tam*0.05, tam*0.05);
    stroke(0);
    noFill();
    arc(posx, posy, tam*0.1, tam*0.1, 0, PI);
    
    switch(P1)
    {
      case 1:
      textSize(16);
      fill(128);
      text("Jugador 1, elegiste a:", 180, 480);
      fill(128, 0, 0, alp);
      textSize(18);
      text("Rojolfo", 180, 510);
      noFill();
      break;
      
      case 2:
      textSize(16);
      fill(128);
      text("Jugador 1, elegiste a:", 180, 480);
      fill(128, 128, 0, alp);
      textSize(18);
      text("Amauricio", 180, 510);
      noFill();
      break;
      
      case 3:
      textSize(16);
      fill(128);
      text("Jugador 1, elegiste a:", 180, 480);
      fill(0, 128, 0, alp);
      textSize(18);
      text("Verduardo", 180, 510);
      noFill();
      break;
      
      case 4:
      textSize(16);
      fill(128);
      text("Jugador 1, elegiste a:", 180, 480);
      fill(0, 0, 128, alp);
      textSize(18);
      text("Azucena", 180, 510);
      noFill();
      break;
      
      case 5:
      textSize(16);
      fill(128);
      text("Jugador 1, elegiste a:", 180, 480);
      fill(64, 0, 128, alp);
      textSize(18);
      text("Moradid", 180, 510);
      noFill();
      break;
    }
    
    switch(P2)
    {
      case 1:
      textSize(16);
      fill(128);
      text("Jugador 2, elegiste a:", 540, 480);
      fill(128, 0, 0, alp);
      textSize(18);
      text("Rojolfo", 540, 510);
      noFill();
      break;
      
      case 2:
      textSize(16);
      fill(128);
      text("Jugador 2, elegiste a:", 540, 480);
      fill(128, 128, 0, alp);
      textSize(18);
      text("Amauricio", 540, 510);
      noFill();
      break;
      
      case 3:
      textSize(16);
      fill(128);
      text("Jugador 2, elegiste a:", 540, 480);
      fill(0, 128, 0, alp);
      textSize(18);
      text("Verduardo", 540, 510);
      noFill();
      break;
      
      case 4:
      textSize(16);
      fill(128);
      text("Jugador 2, elegiste a:", 540, 480);
      fill(0, 0, 128, alp);
      textSize(18);
      text("Azucena", 540, 510);
      noFill();
      break;
      
      case 5:
      textSize(16);
      fill(128);
      text("Jugador 2, elegiste a:", 540, 480);
      fill(64, 0, 128, alp);
      textSize(18);
      text("Moradid", 540, 510);
      noFill();
      break;
    }
  }
}
