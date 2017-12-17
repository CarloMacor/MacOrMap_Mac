/*
 *  funzioni.c
 *  GIS2010
 *
 *  Created by Carlo Macor on 25/07/10.
 *  Copyright 2010 Carlo Macor. All rights reserved.
 *
 */

#include "funzioni.h"
#include <math.h>
#include <stdlib.h>




void rotocentra    ( double xc     , double yc    ,double rotatt  ,double rotprec ,  double* xcord , double* ycord   )  {
	double  newx, newy;
	newx = *xcord;	newy = *ycord;
	double rot = rotatt-rotprec;
	newx = newx-xc;		newy = newy-yc;
	double  newx1, newy1;
	
	newx1= newx*cos(rot)-newy*sin(rot);				
	newy1= newx*sin(rot)+newy*cos(rot);
	
	newx = newx1+xc;		newy = newy1+yc;
	*xcord=newx;		*ycord=newy;
}

void   scalacentra      ( double xc  , double yc  , double scalaatt , int modo , double scalaxprec , double scalayprec ,  double* xcord , double* ycord)    {
	double  newx, newy;
	newx = *xcord;	newy = *ycord;
	double scalx,scaly; 
	switch (modo) {
		case 0 :	scalx = scalaatt/scalaxprec;	scaly = 1;            break;
		case 1 :	scalx = scalaatt/scalaxprec;	scaly = scalaatt/scalayprec; break;
		case 2 :	scalx = 1;                      scaly = scalaatt/scalayprec; break;
		default:	scalx = scalaatt/scalaxprec;	scaly = scalaatt/scalayprec; break;
	}
	
	newx = newx-xc;	newy = newy-yc;
	double  newx1, newy1;
	
	newx1= newx*scalx;				
	newy1= newy*scaly;
	
	newx = newx1+xc;		newy = newy1+yc;
	*xcord=newx;		*ycord=newy;
}


double angolo2vertici   ( double xc  , double yc  , double x2 , double y2 ) {
	double risulta=0;
	double dx,dy;
	dx = x2-xc;	                  dy = y2-yc; 
	 if ((dx==0)  & (dy==0)) risulta=0;
	 else {
	 if (dx==0) { risulta = M_PI/2;   if (dy <0) risulta += M_PI;  } 
	 else	{ risulta = atan( dy / dx ); 	if (dx <0) risulta = M_PI+risulta; if (risulta<0) risulta += 2*M_PI;	}			
	 }
	return risulta;
}


double scala2verticischermo   ( double xc  , double yc  , double x2  , double y2 , double dimscr) {
	double risulta=1;
	double dx,dy;
	dx = x2-xc;	dy = y2-yc; 
	if ((dx==0)  & (dy==0)) risulta=1; else {
	  risulta = hypot( dx, dy )/(dimscr/40);
	}
	return risulta;
}

double distsemplicefunz           ( double x1 ,double y1,double x2 ,double y2 ) {
	return hypot( (x2-x1), (y2-y1) );
}

double  distasegfunz   ( double x1  , double y1  , double x2  , double y2 , double xp , double yp  ) {
	
	double ll; double ll2;
		// prima riazeriamo le pos
	x2 = x2-x1;  	y2 = y2-y1;
	xp = xp-x1;  	yp = yp-y1;
	x1 = 0;         y1 = 0;
	double a = y2-y1;  double b = x1-x2;  double c = x2*y1-x1*y2;

	if	((a==0)	& (b==0)) {	ll = distsemplicefunz(x1 ,y1 ,xp ,yp) ;	return ll;	}
    if (a==0)	{   ll = fabs(yp-y2); return ll;   }
	if (b==0)	{   ll = fabs(xp-x2); return ll; 	}
	
	double deno=sqrt(a*a+b*b);
	if (deno>0.001) ll = fabs(a*xp+b*yp+c)/deno;
	else {
		ll  =  distsemplicefunz(x2,y2,xp,yp);
		ll2 =  distsemplicefunz(x1,y1,xp,yp);
		if (ll>ll2) ll=ll2;
	}
	if ( distsemplicefunz(x1,y1,xp,yp)<ll) ll=distsemplicefunz(x1,y1,xp,yp);
	

 return ll;
}

double   xgriglia         ( double x1  , double y1  , double x2   , double y2   ,   double yy ) {
	return x1+((x2-x1)/(y2-y1))*(yy-y1);
}

double  ygriglia         ( double x1  , double y1  , double x2   , double y2   ,   double xx ) {
	return y1+((y2-y1)/(x2-x1))*(xx-x1);
}

int   intersezione  (double x1 ,double y1 ,double x2 ,double y2 ,double x3 ,double y3 ,double x4 ,double y4 ,double* xcord , double* ycord   ) {
    int risulta =0;
	double a1 = y2-y1;    double b1 = x1-x2;    double c1 = x2*y1-x1*y2;
    double a2 = y4-y3;    double b2 = x3-x4;    double c2 = x4*y3-x3*y4;
	double x , y ;
	double DD = a1*b2-a2*b1;
	if (DD==0) return 0;  // le due rette sono parallele.
	double Dx = c2*b1-c1*b2;
	double Dy = c1*a2-c2*a1;

	x = Dx/DD; y = Dy/DD;
	// vediamo se e' interno
	//	*xcord = x;	*ycord = y; // fisso la intersezione 

	if (( ((x>x1) & (x<x2)) | ((x>x2) & (x<x1)) )   &   ( ((y>y1) & (y<y2)) | ((y>y2) & (y<y1)) ) )      
	{
		if (( ((x>x3) & (x<x4)) | ((x>x4) & (x<x3)) )   &   ( ((y>y3) & (y<y4)) | ((y>y4) & (y<y3)) ) )      {
			risulta = 1;
			*xcord = x;	*ycord = y; // fisso la intersezione 
		}
	}
	
	
	
	return risulta;
	
}





