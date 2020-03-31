/*
Ce script a pour but de "nettoyer" le signal de pulsation cardiaque que nous envoie ce "cher" puredata
 Pour ce nettoyage, on va trouver la fréquence de ce signal, ce qui permettra de générer un nouveau signal qui sera, lui, plus stable
 on commence donc par trouver la pente du signal, s'il monte ou s'il descend
 Ensuite, on détermine le moment où cette valeur descend, donc sur un pic. Pic pour lequelon choisit un intervalle de données acceptable.
 Lorsqu'un pic est dans ce seuil, on enregistre la valeur sur trois frames, on fait la moyenne, et on la renvoie à PD
 */

//import des librairies pour OSC : oscP5 website at http://www.sojamo.de/oscP5
import oscP5.*;
import netP5.*;

//Variables OSC
OscP5 oscP5;
NetAddress myRemoteLocation;

//Variables du signal
int heartBpd;                     //la valeur du signal de pulsation cardiaque en IN, que l'on va venir chercher en OSC rapidement =)
int oldHeartBpd = heartBpd;       //c'est la valeur précédente de la pulsation, qui permet de déterminer la pente !
boolean pente;                    //détermine la pente de l'oscillation. à true elle monte, à false, elle descend
boolean oldPente;                 //c'est la valeur précédente de la pente, qui permet de déterminer si celle-ci change
int hbPitch = 769;                //c'est la fameuse période du signal, en millisecondes ce que l'on cherche pour déterminer la fréquence et qu'on va envoyer à piredata. On l'initialise à 769, ce qui correcpond à un bpm de 78, une bonne moyenne
int pitchCompt = 0;               //
int tempHbPitch = 769;            //valeur du pitch mesurée
int tempHbPitch1 = tempHbPitch;   //valeur précédente du pitch
int tempHbPitch2 = tempHbPitch;   //valeur encore précédente du pitch
int hbMax = 0;                    //la valeur max de heartBpd durant les dernières frames
//int hbMin = 1000;                 //la valeur min de heartBpd durant les dernières frames : à réactiver au besoin.
int minMaxBuffer = 0;             //Ce qui va permettre de compter les frames pour réinitialiser le max et le min auprès avoir atteint leur max.    
boolean maxPulse = false;         //est true pendant moins d'une frame, à chaque fois que la pente atteint son maximum et si elle est supérieure à 510


void setup() {
  size(400, 400);                                                                                                       //Simple fenetre de 400 de côté, carrée
  frameRate(20);                                                                                                        //On force un framerate à 20 images par secondes, donc une de 50ms sachant que le capteur a un échantillonage de 5ms

  oscP5 = new OscP5(this, 12000);                                                                                       //On initialise l'OSC en IN
  myRemoteLocation = new NetAddress("127.0.0.1", 4242);                                                                 //On initialise l'OSC en OUT
}

void draw() {
  background(0);
  //println(heartBpd);

  calculPente();    //On lance la fonction de calcul de la pente
  minAndMax();
  waitForThreeSecondsAndReset();

  //println(maxPulse);

  //println(maxPulse);
  calculPitch();
  //println(hbPitch);
  if (maxPulse) {
    //println(maxPulse);
    maxPulse = false;
  }
  //println(" hb: "+heartBpd);

  //DESSIN//
  strokeWeight(heartBpd/10);      //on initialise la taille de trait à un dizième de heartBpd, le signal reçu de piredata
  //if (stabPente) {                    //Si la pente monte, on va colorer le trait en rose
  stroke(255, 0, 0);
  //} else {                        //Si elle descend, on la colore en jaune
  // stroke(255, 0, 255);
  //}
  point(width/2, height/2);       //On dessine un point au milieu
  
  //println(heartBpd +" min: "+hbMin+" max: "+hbMax);

  //Attributions de fin de cycle//
  oldHeartBpd = heartBpd;         //On attribue la nouvelle valeur de battement 
  oldPente = pente;               //de la même manère, la nouvelle valeur de la pente

}

//Fonction permettant de recevoir les messages OSC
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/processing/heartBeat")==true) {  //On vérifie que le message a l'adresse que nous recherchons
    if (theOscMessage.checkTypetag("i")) {                              //On vérifie que c'est bien le type de valeur attendu
      int firstValue = theOscMessage.get(0).intValue();                 //On récupère sa valeur

      heartBpd = firstValue;                                            //On l'attribue à notre variable heartBpd
      return;
    }
  }
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
}

void calculPitch() {
  int tempPitch = hbPitch/50;
  if (hbMax>510 && maxPulse) {
    tempPitch = pitchCompt;
    pitchCompt = 0;
    if (tempPitch<24 && tempPitch>10) {
      tempHbPitch = tempPitch*50;
      tempHbPitch2 = tempHbPitch1;
      tempHbPitch1 = tempHbPitch;
      hbPitch = (tempHbPitch1 + tempHbPitch2 + tempHbPitch)/3;
      println(hbPitch);
      oscP5.send("/processing/hbPitch", new Object[] {new Integer(hbPitch)}, myRemoteLocation);   //On envoie le pitch en OSC à piredata
    }
  }
  pitchCompt ++;
}

//Fonction pour savoir si la pente monte ou descend
void calculPente() {
  if (oldHeartBpd < heartBpd) {          //Si l'ancienne valeur de la pente est inférieure à la nouvelle
    pente = true;                        //C'est que la pente monte
  } else {                               //Sinon
    pente = false;                       //c'est qu'elle descend
  }

  if (oldPente != pente) {    //Si on a attendu depuis le dernier changement de stabPente, ET que la pente change
    if (!pente) {
      maxPulse = true;
    }
    //println("STBP "+ stabPente);
  }
}

void minAndMax() {
  if (heartBpd > hbMax) {
    hbMax = heartBpd;
  //} else if (heartBpd < hbMin) {
    //hbMin = heartBpd;
  }
}

void waitForThreeSecondsAndReset() {
  if (minMaxBuffer == 13) {
    //hbMin = heartBpd;
    hbMax = heartBpd;
    minMaxBuffer = 0;
    //println("RESET");
  } else {
    minMaxBuffer ++;
  }
}
