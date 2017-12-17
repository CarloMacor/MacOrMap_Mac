//
//  Famiglia.h
//  Anagrafe
//
//  Created by Carlo Macor on 13/04/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Residente.h"


@interface Famiglia : NSObject {
    NSMutableArray *ListaComponenti;
    bool        associatoedif;
    int        idNucleo;
    NSString * Foglio;
    NSString * Particella;
    NSString * Sub;
    NSCalendarDate   * dataFormazione;
    NSString * Via;
    NSString * nr;
    NSString * Piano;
    NSString * interno;
	NSString * codFamiglia;

}


- (void) InitFamiglia ; 

- (void) salva              :(NSMutableData *) lodata ;
	//- (void) apri               : (NSString *) nomefile;
- (void) addstringaData2   : (NSMutableData *) dat : (NSString *) str;
- (NSString *) GetStringaData2 : (NSData        *) data : (int *) pos ; 

- (void)  apri           :(NSData  *) DataFile : (int *) posdata;


- (NSMutableArray *) ListaComponenti;
- (bool)        associatoedif;
- (int)        idNucleo;
- (NSString *) Foglio;
- (NSString *) Particella;
- (NSString *) Sub;
- (NSCalendarDate   *) dataFormazione;
- (NSString *) Via;
- (NSString *) nr;
- (NSString *) Piano;
- (NSString *) interno;
- (NSString *) codFamiglia;
- (NSString *) Nome1;
- (NSString *) Cognome1;
- (NSString *) dataNascitaStr1;
- (NSString *) viaEstesa1;
- (NSCalendarDate   *) dataNascita1;



- (void)       setassociatoedif: (bool) asso ;
- (void)       setidNucleo: (int) iddo;
- (void)       setFoglio: (NSString *) foglio ;
- (void)       setParticella: (NSString *) particella;
- (void)       setSub: (NSString *) sub;
- (void)       setdataFormazione : (NSCalendarDate   *) data;
- (void)       setVia: (NSString *) via;
- (void)       setViacivico: (NSString *) via;
- (void)       setnr: (NSString *) numero;
- (void)       setPiano: (NSString *) piano;
- (void)       setinterno: (NSString *) inter;
- (void)       setcodFamiglia : (NSString *) codfam;


- (void)  addResidente: (Residente *) resider;

- (NSComparisonResult)CompareNome      :(Famiglia *) famer ; 
- (NSComparisonResult)CompareCognome   :(Famiglia *) famer ; 
- (NSComparisonResult)CompareVia       :(Famiglia *) famer ; 
- (NSComparisonResult)CompareData      :(Famiglia *) famer ; 


@end
