//
//  Tarsu.h
//  MacOrMap
//
//  Created by Carlo Macor on 16/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Tax_ele.h"


@interface Tax : NSObject {
	NSMutableArray *ListaTarsuEle;
	NSMutableArray *ListaIciEle;

}

- (void) initTax;

- (void) salva  ;

- (void) apri  ;

- (void) salvaTarsu : (NSMutableData *) lodata ;

- (void) apriTarsu  : (NSData *) lodata  : (int *) posizione ;


- (void) salvaIci   : (NSMutableData *) lodata ;

- (void) apriIci    : (NSData *) lodata  : (int *) posizione  ;


- (NSMutableArray *) ListaTarsuEle;

- (NSMutableArray *) ListaIciEle;


- (void) togliDoppiFgPartSub;


- (void) logga;

@end
