//
//  DefSimbolo.m
//  GIS2010
//
//  Created by Carlo Macor on 16/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "DefSimbolo.h"
#import "Vettoriale.h"


@implementation DefSimbolo


- (void) InitSimbolo    :(int) _indice  :(double)_xc :(double) _yc :(NSString *) _nome    {
	indice = _indice;
	xc = _xc;	yc = _yc;
	Listavector = [[NSMutableArray alloc] init];
	[_nome retain];
	nome = _nome;
}

- (NSMutableArray *)   Listavector                                                        {
	return Listavector;
}

- (NSString       *)   nome                                                               {
	return nome;
}

- (void) disegnadef     :  (CGContextRef) hdc : (NSRect) fondo                            {
	InfoObj  *IlloInfo = [InfoObj alloc];
	
	
	[self faiLimiti];
	[IlloInfo  setLimitiDisV :limx1 : limy1 : limx2 : limy2];
	[IlloInfo setZoomAllVector];  
	
	[IlloInfo set_origineVista:limx1 :limy1 ];
	double locscal,locscal2;
	locscal  = (limx2-limx1)/fondo.size.width;
	locscal2 = (limy2-limy1)/fondo.size.height;
    if (locscal<locscal2) locscal=locscal2;
	[IlloInfo set_scalaVista  :locscal ];
	
	
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector Disegna:hdc : IlloInfo];
	}
	
	[IlloInfo release];
	IlloInfo = nil;
	
}

- (void) faiLimiti                                                       {
    limx1=0; limx2=0; limy1=0;  limy2=0;
	Vettoriale *vet;
	for (int i=0; i<Listavector.count; i++) {  
		vet= [Listavector objectAtIndex:i];       [vet faiLimiti];
		if (i==0) {   
			limx1=[vet limx1];	   limx2=[vet limx2]; 	   limy1=[vet limy1];	   limy2=[vet limy2]; 
		}else {
			if (limx1>[vet limx1])   limx1=[vet limx1];	
			if (limy1>[vet limy1])   limy1=[vet limy1];	 
			if (limx2<[vet limx2])   limx2=[vet limx2];	 
			if (limy2<[vet limy2])   limy2=[vet limy2];	 
		}
	}
	vet=nil;
}


@end
