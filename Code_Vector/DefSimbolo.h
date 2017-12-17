//
//  DefSimbolo.h
//  GIS2010
//
//  Created by Carlo Macor on 16/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DefSimbolo : NSObject {
	int    indice;
	double xc;
	double yc;
	NSMutableArray *Listavector;
    NSString *nome;
	double          limx1, limx2, limy1,limy2;
}


- (void) InitSimbolo         : (int) _indice :(double)_xc : (double) _yc : (NSString *) nome;    


- (NSMutableArray *) Listavector;

- (NSString       *) nome;

- (void) disegnadef :  (CGContextRef) hdc : (NSRect) fondo;

- (void)   faiLimiti;


@end
