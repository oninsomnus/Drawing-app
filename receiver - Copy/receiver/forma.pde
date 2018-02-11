float a;
void forma(float a){
a++;
float ancho = width/4;
float alto = height/202-600;
translate(ancho, alto);
scale(3);
beginShape();
vertex(209,331);
bezierVertex(224+a,331,238,341,244,354);
bezierVertex(247+a,361,252,366,258,370);
bezierVertex(270+a,377,278,389,278,404);
bezierVertex(278+a,420,270,431,258,437);
bezierVertex(252+a,440,248,444,245,450);
bezierVertex(239+a,463,225,471,209,470);
bezierVertex(190+a,469,173,455,173,433);
bezierVertex(173+a,427,174,421,176,416);
bezierVertex(181+a,407,181,398,175,388);
bezierVertex(172+a,383,170,378,170,369);
bezierVertex(170+a,348,188,331,209,331);

endShape(CLOSE);

}