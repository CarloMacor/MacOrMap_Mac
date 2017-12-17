//
//  Vertice.m
//  GIS2010
//
//  Created by Carlo Macor on 02/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Vertice.h"


@implementation Vertice


- (void)    InitVertice:(double)x1 :(double) y1                           { x=x1;	y=y1; up=NO; }

- (void)    InitVerticeUp:(double)x1 :(double) y1                         { x=x1;	y=y1; up=YES; }

- (double)  xpos                                                          { return x; }

- (double)  ypos                                                          { return y; }

- (double)  zpos                                                          { return z; }

- (bool)    givemeifup                                                    { 
			return up;
}


- (void)    setVtUp                                                       { up=YES; }


- (void)    setVtDown  {
	up = NO;
}

- (void)    moveto:(CGContextRef) hdc : (InfoObj *) _info                 {
	double x1=(x-[_info xorigineVista])/[_info scalaVista];
	double y1=(y-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1, y1);
}

- (void)    lineto:(CGContextRef) hdc : (InfoObj *) _info                 {
	double x1=(x-[_info xorigineVista])/[_info scalaVista];
	double y1=(y-[_info yorigineVista])/[_info scalaVista];
	CGContextAddLineToPoint(hdc, x1, y1);
	
	
	
}


- (void)    movetoSpo  :(CGContextRef) hdc : (InfoObj *) _info :(double) dx : (double) dy {
	double x1=((x+dx)-[_info xorigineVista])/[_info scalaVista];
	double y1=((y+dy)-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1, y1);
}

- (void)    linetoSpo  :(CGContextRef) hdc : (InfoObj *) _info :(double) dx : (double) dy {
	double x1=((x+dx)-[_info xorigineVista])/[_info scalaVista];
	double y1=((y+dy)-[_info yorigineVista])/[_info scalaVista];
	CGContextAddLineToPoint(hdc, x1, y1);
}


- (void)    tangento:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) t{
	double x1=((x*2)-[t xpos]-[_info xorigineVista])/[_info scalaVista];
	double y1=((y*2)-[t ypos]-[_info yorigineVista])/[_info scalaVista];
	
	double x2=([t xpos]  -[_info xorigineVista])/[_info scalaVista];
	double y2=([t ypos]  -[_info yorigineVista])/[_info scalaVista];

	CGContextMoveToPoint(hdc, x1, y1);
	CGContextAddLineToPoint(hdc, x2, y2);

}


- (void)    CopiaconVt:(Vertice *) _vt                                    {
	x = [ _vt xpos];
	y = [ _vt ypos];
	z = [ _vt zpos];
	up = [ _vt givemeifup];
}



- (void)    splineto:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2       {
	double x1=(x-[_info xorigineVista])/[_info scalaVista];
	double y1=(y-[_info yorigineVista])/[_info scalaVista];
	double xc1=([p1 xpos]*2-[t1 xpos]-[_info xorigineVista])/[_info scalaVista];
	double yc1=([p1 ypos]*2-[t1 ypos]-[_info yorigineVista])/[_info scalaVista];
	double xc2=([t2 xpos]-[_info xorigineVista])/[_info scalaVista];
	double yc2=([t2 ypos]-[_info yorigineVista])/[_info scalaVista];
	CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);
}

- (void)    splinetoSpo:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) dx : (double) dy       {
	double x1=((x+dx)-[_info xorigineVista])/[_info scalaVista];
	double y1=((y+dy)-[_info yorigineVista])/[_info scalaVista];
	double xc1=(dx+[p1 xpos]*2-[t1 xpos]-[_info xorigineVista])/[_info scalaVista];
	double yc1=(dy+[p1 ypos]*2-[t1 ypos]-[_info yorigineVista])/[_info scalaVista];
	double xc2=(dx+[t2 xpos]-[_info xorigineVista])/[_info scalaVista];
	double yc2=(dy+[t2 ypos]-[_info yorigineVista])/[_info scalaVista];
	CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);
}

- (void)    splinetoRot:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) xc : (double) yc : (double) rot     {

	double x1,y1;	double locx,locy;
	x1=x-xc;	y1=y-yc;
	locx = x1*cos(rot) - y1*sin(rot);        	locy = x1*sin(rot) + y1*cos(rot);
	x1   = locx+xc;	                            y1   = locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];

	double xc1,yc1;	
	xc1=[p1 xpos]*2-[t1 xpos]; 
	yc1=[p1 ypos]*2-[t1 ypos];
	xc1=xc1-xc;	yc1=yc1-yc;
	locx = xc1*cos(rot) - yc1*sin(rot);        	locy = xc1*sin(rot) + yc1*cos(rot);
	xc1   = locx+xc;	                        yc1  = locy+yc;
	xc1=(xc1-[_info xorigineVista])/[_info scalaVista];
	yc1=(yc1-[_info yorigineVista])/[_info scalaVista];	
	
	double xc2,yc2;	
	xc2=[t2 xpos]; 
	yc2=[t2 ypos];
	xc2=xc2-xc;	yc2=yc2-yc;
	locx = xc2*cos(rot) - yc2*sin(rot);        	locy = xc2*sin(rot) + yc2*cos(rot);
	xc2   = locx+xc;	                        yc2  = locy+yc;
	xc2=(xc2-[_info xorigineVista])/[_info scalaVista];
	yc2=(yc2-[_info yorigineVista])/[_info scalaVista];	
	
	 CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);
}

- (void)    splinetoSca:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) xc : (double) yc : (double) sca     {
	
	double x1,y1;	double locx,locy;
	x1=x-xc;	y1=y-yc;
	locx = x1*sca;        	locy = y1*sca;
	x1   = locx+xc;	                            y1   = locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	
	double xc1,yc1;	
	xc1=[p1 xpos]*2-[t1 xpos]; 
	yc1=[p1 ypos]*2-[t1 ypos];
	xc1=xc1-xc;	yc1=yc1-yc;
	locx = xc1*sca;        	locy = yc1*sca;
	xc1   = locx+xc;	                        yc1  = locy+yc;
	xc1=(xc1-[_info xorigineVista])/[_info scalaVista];
	yc1=(yc1-[_info yorigineVista])/[_info scalaVista];	
	
	double xc2,yc2;	
	xc2=[t2 xpos]; 
	yc2=[t2 ypos];
	xc2=xc2-xc;	yc2=yc2-yc;
	locx = xc2*sca;        	locy = yc2*sca;
	xc2   = locx+xc;	                        yc2  = locy+yc;
	xc2=(xc2-[_info xorigineVista])/[_info scalaVista];
	yc2=(yc2-[_info yorigineVista])/[_info scalaVista];	
	
	CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);
}

- (void)    movetoRot  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot {
	double x1,y1;
	x1=x-xc;
	y1=y-yc;
	double locx,locy;
	locx = x1*cos(rot) - y1*sin(rot);        	locy = x1*sin(rot) + y1*cos(rot);
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1, y1);
}

- (void)    linetoRot  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot{
	double x1,y1;
	x1=x-xc;
	y1=y-yc;
	double locx,locy;
	locx = x1*cos(rot) - y1*sin(rot);        	locy = x1*sin(rot) + y1*cos(rot);
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	CGContextAddLineToPoint(hdc, x1, y1);
}

- (void)    movetoSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) sca {
	double x1,y1;
	x1=x-xc; 	  y1=y-yc;
	double locx,locy;
	locx = x1*sca;        	locy = y1*sca;
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1, y1);
}

- (void)    linetoSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) sca{
	double x1,y1;
	x1=x-xc; 	  y1=y-yc;
	double locx,locy;
	locx = x1*sca;        	locy = y1*sca;
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	CGContextAddLineToPoint(hdc, x1, y1);
}

- (void)    movetoSpoRotSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot: (double) sca{
	double locx,locy;    double x1,y1;
	locx = x*cos(rot) - y*sin(rot);        	locy = x*sin(rot) + y*cos(rot);
	locx = locx*sca;        	locy = locy*sca;
	locx = locx+xc;        	    locy = locy+yc;
	x1=(locx-[_info xorigineVista])/[_info scalaVista];
	y1=(locy-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1, y1);
}

- (void)    linetoSpoRotSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot: (double) sca{
	double locx,locy;  double x1,y1;
	locx = x*cos(rot) - y*sin(rot);        	locy = x*sin(rot) + y*cos(rot);
	locx = locx*sca;        	locy = locy*sca;
	locx = locx+xc;        	    locy = locy+yc;
	x1=(locx-[_info xorigineVista])/[_info scalaVista];
	y1=(locy-[_info yorigineVista])/[_info scalaVista];
	CGContextAddLineToPoint(hdc, x1, y1);
}

- (void)    splinetoSpoRotSca:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) xc : (double) yc : (double) rot : (double) sca     {
	
	double x1,y1;	double locx,locy;
	x1=x-xc;	y1=y-yc;
	locx = x1*sca;        	locy = y1*sca;
	x1   = locx+xc;	                            y1   = locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	
	double xc1,yc1;	
	xc1=[p1 xpos]*2-[t1 xpos]; 
	yc1=[p1 ypos]*2-[t1 ypos];
	xc1=xc1-xc;	yc1=yc1-yc;
	locx = xc1*sca;        	locy = yc1*sca;
	xc1   = locx+xc;	                        yc1  = locy+yc;
	xc1=(xc1-[_info xorigineVista])/[_info scalaVista];
	yc1=(yc1-[_info yorigineVista])/[_info scalaVista];	
	
	double xc2,yc2;	
	xc2=[t2 xpos]; 
	yc2=[t2 ypos];
	xc2=xc2-xc;	yc2=yc2-yc;
	locx = xc2*sca;        	locy = yc2*sca;
	xc2   = locx+xc;	                        yc2  = locy+yc;
	xc2=(xc2-[_info xorigineVista])/[_info scalaVista];
	yc2=(yc2-[_info yorigineVista])/[_info scalaVista];	
	
	CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);
}




- (void)    discroce  :(CGContextRef) hdc : (InfoObj *) _info{
	CGContextSetLineWidth(hdc, 0.4 );
	CGContextBeginPath(hdc);
	double x1=(x-[_info xorigineVista])/[_info scalaVista];
	double y1=(y-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1-2, y1-2);
	CGContextAddLineToPoint(hdc, x1+2, y1-2);
	CGContextAddLineToPoint(hdc, x1+2, y1+2);
	CGContextAddLineToPoint(hdc, x1-2, y1+2);
	CGContextAddLineToPoint(hdc, x1-2, y1-2);
	CGContextStrokePath(hdc);
}


- (void)    discrocespline  :(CGContextRef) hdc : (InfoObj *) _info : (Vertice *) V {
	CGContextSetLineWidth(hdc, 0.4 );
	CGContextBeginPath(hdc);
	double x1=(x-[_info xorigineVista])/[_info scalaVista];
	double y1=(y-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1-2, y1-2);
	CGContextAddLineToPoint(hdc, x1+2, y1-2);
	CGContextAddLineToPoint(hdc, x1+2, y1+2);
	CGContextAddLineToPoint(hdc, x1-2, y1+2);
	CGContextAddLineToPoint(hdc, x1-2, y1-2);
	CGContextStrokePath(hdc);
	double x2=([V xpos]-[_info xorigineVista])/[_info scalaVista];
	double y2=([V ypos]-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x2-2, y2-2);
	CGContextAddLineToPoint(hdc, x2+2, y2-2);
	CGContextAddLineToPoint(hdc, x2+2, y2+2);
	CGContextAddLineToPoint(hdc, x2-2, y2+2);
	CGContextAddLineToPoint(hdc, x2-2, y2-2);
	CGContextStrokePath(hdc);
	
	CGContextMoveToPoint   (hdc, x1, y1);
	CGContextAddLineToPoint(hdc, x2, y2);
	CGContextStrokePath(hdc);

	
}

- (void)    dispallino       :(CGContextRef) hdc : (InfoObj *) _info{
	double x1=(x-[_info xorigineVista])/[_info scalaVista];
	double y1=(y-[_info yorigineVista])/[_info scalaVista];
		   CGContextAddArc (hdc, x1, y1 , 1, 0, 2*M_PI, 0);
			CGContextStrokePath(hdc);
		//	CGContextAddArc (hdc, x1, y1 , 1, 0, 2*M_PI, 0);
		//	CGContextFillPath(hdc);

}

- (void)    dispallinofinale :(CGContextRef) hdc : (InfoObj *) _info{
	double x1=(x-[_info xorigineVista])/[_info scalaVista];
	double y1=(y-[_info yorigineVista])/[_info scalaVista];
		CGContextAddArc (hdc, x1, y1 , 3, 0, 2*M_PI, 0);
		CGContextFillPath(hdc);
		CGContextAddArc (hdc, x1, y1 , 5, 0, 2*M_PI, 0);
		CGContextStrokePath(hdc);
	
}


- (void) Sposta          : (double) dx :  (double) dy  {
	x +=dx;	y +=dy;
}

- (void) Ruotaang        : (double) ang                {
	double locx,locy;
	locx = x*cos(ang) - y*sin(ang);        	locy = x*sin(ang) + y*cos(ang);
	x=locx;	y=locy;
}


- (void) Scalasc         : (double) scal               {
	double locx,locy;
	locx = x*scal;      locy = y*scal;	       
	x=locx;	y=locy;
}

- (void) CatToUtm        : (InfoObj *) _info           {
	[_info catastotoutm : &x : &y];
}


@end
