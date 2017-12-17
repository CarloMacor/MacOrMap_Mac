//
//  Anagrafe.h
//  MacOrMap
//
//  Created by Carlo Macor on 14/04/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Famiglia.h"
#import "Residente.h"


@interface Anagrafe : NSObject {
	NSMutableArray *ListaFamiglie;
	NSMutableArray *ListaResidenti;
    NSMutableArray *ListaVie;
	NSMutableArray *ListaFamiglieFiltrata;
	NSMutableArray *ListaResidentiFiltrata;
}

- (void) initAnagrafe;

- (void) salva : (NSString *) nomefile;

- (void) apri  : (NSString *) nomefile;

- (NSMutableArray *) ListaFamiglie;

- (NSMutableArray *) ListaResidenti;

- (NSMutableArray *) ListaVie;

- (NSMutableArray *) ListaFamiglieFiltrata;

- (NSMutableArray *) ListaResidentiFiltrata;



- (Famiglia *) givemeaddFamily : (NSString *) codfam ;

- (void) FormaAnagrafe;

- (void) logga;

- (NSString *) senzaspazifinali : (NSString *) str;

@end
