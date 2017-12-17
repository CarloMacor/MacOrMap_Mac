//
//  Arco.m
//  GIS2010
//
//  Created by Carlo Macor on 05/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Arco.h"


@implementation Arco


- (void)   Disegna:(CGContextRef) hdc: (InfoObj *) _info                              {
	if (b_erased) return;
	
	double x1,y1,rag;
	x1=(x-[_info xorigineVista])/[_info scalaVista];
	y1=(y-[_info yorigineVista])/[_info scalaVista];
	rag = r /[_info scalaVista];
	CGContextAddArc (hdc, x1, y1 , rag, ang1*M_PI/180, ang2*M_PI/180, 0);
	CGContextStrokePath(hdc);
/*	
    CGContextMoveToPoint(hdc, x1-8, y1);	CGContextAddLineToPoint(hdc, x1+8, y1);
	CGContextMoveToPoint(hdc, x1  , y1-8);	CGContextAddLineToPoint(hdc, x1  , y1+8);
	CGContextStrokePath(hdc);
*/
	
	
	
	
}


- (void)   InitArco: (double)x1 :(double) y1: (double)r1 :(double) a1  :(double) a2            {
	b_erased=NO;	b_selected=NO;
	tipo  = 11;  	x = x1;  	y = y1;  	
	r = r1;
	ang1=a1;
    ang2=a2;
	
	[self faiLimiti];
}


- (bool) testinternoschermo : (InfoObj *) _info  {
	return YES;
}


- (void)               salvavettorialeMoM    :(NSMutableData *) _illodata{
	[super salvavettorialeMoM:_illodata];
	[_illodata appendBytes:(const void *)&x length:sizeof(x)];
	[_illodata appendBytes:(const void *)&y length:sizeof(y)];
	[_illodata appendBytes:(const void *)&r length:sizeof(r)];
	[_illodata appendBytes:(const void *)&ang1 length:sizeof(ang1)];
	[_illodata appendBytes:(const void *)&ang2 length:sizeof(ang2)];
        //   NSLog(@"K %2.2f %2.2f %2.2f ",x, y, r );

}

- (NSUInteger) aprivettorialeMoM     : (NSData *) _data: (NSUInteger) posdata {
    [super aprivettorialeMoM :_data : posdata ];
	[_data getBytes:&x        range:NSMakeRange (posdata, sizeof(x))  ];     posdata +=sizeof(x);
	[_data getBytes:&y        range:NSMakeRange (posdata, sizeof(y))  ];     posdata +=sizeof(y);
	[_data getBytes:&r        range:NSMakeRange (posdata, sizeof(r))  ];     posdata +=sizeof(r);
	[_data getBytes:&ang1     range:NSMakeRange (posdata, sizeof(ang1))  ];     posdata +=sizeof(ang1);
	[_data getBytes:&ang2     range:NSMakeRange (posdata, sizeof(ang2))  ];     posdata +=sizeof(ang2);
    
        //    NSLog(@"P %2.2f %2.2f %2.2f ",x, y, r );
    [self cancella];
  	[self faiLimiti];
	return posdata;
}

- (void) Sposta          : (double) dx :  (double) dy                       {
	x +=dx;	y +=dy;	[self faiLimiti];
}

- (void) faiLimiti                                                          {
	limx1 = x+r*cos(ang1*M_PI/180) ;	limx2 = x+r*cos(ang1*M_PI/180)+1 ;	
	limy1 = y+r*sin(ang1*M_PI/180) ;	limy2 = y+r*sin(ang1*M_PI/180)+1 ;

}

- (void) CatToUtm  : (InfoObj *) _info{
	[_info catastotoutm : &x : &y];
}



@end
