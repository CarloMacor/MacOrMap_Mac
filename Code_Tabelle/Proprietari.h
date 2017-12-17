//
//  Proprietari.h
//  MacOrMap
//
//  Created by Carlo Macor on 04/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Patrimonio.h"


@interface Proprietari : NSObject {
	int              Indice;
	NSString       * Nome;
	NSString       * Cognome;
	NSString       * Datanascita;
	NSString       * LuogoNascita;
	NSString       * Codfis;
	NSMutableArray * ListaPatrimonio;
	NSCalendarDate * DataNumerica;
	bool sporcademo;
}

- (void)          initProprietario;

- (Patrimonio *)  addPatrimonio    ;
- (void)          addstringaData   : (NSMutableData *) dat : (NSString *) str ;
- (void)          addstringaData2  : (NSMutableData *) dat : (NSString *) str     ;

- (NSString   *)  GetStringaData   : (NSFileHandle  *) fileHandle ;

- (NSString       *) Infocompleto;
- (NSString       *) indicestr;
- (NSString       *) Nome;
- (NSString       *) Cognome;
- (NSString       *) LuogoNascita;
- (NSString       *) Codfis;
- (NSString       *) Datanascita;
- (NSString       *) numprostr;
- (NSMutableArray *) ListaPatrimonio;
- (NSCalendarDate *) DataNumerica;


- (void) SetNomeEsteso: (NSString *) nome;
- (void) SetNome      : (NSString *) nome;
- (void) SetCognome   : (NSString *) cognome;
- (void) SetCodfis    : (NSString *) codfis;
- (void) SetCodfisSecco : (NSString *) codfis ;
- (void) SetLuogoNat  : (NSString *) luogo;
- (void) SetDataNat   : (NSString *) datastr;

- (void) loggapatrimonio;
- (void) logga;

- (void) salva          :(NSMutableData *) lodata;
	//- (int)  apri           :(NSFileHandle  *) fileHandle : (int) posfile;
- (void)  apri           :(NSData  *) DataFile : (int *) posdata     ;

- (void) addstringaData   : (NSMutableData *) dat : (NSString *) str ;
- (void) addstringaData2  : (NSMutableData *) dat : (NSString *) str ;
- (NSString *) GetStringaData : (NSFileHandle  *) fileHandle ;
- (NSString *) GetStringaData2 : (NSData  *) data : (int *) pos ;


- (void) alternasporcademo ;

- (NSComparisonResult)CompareNome      :(Proprietari *)proper; 
- (NSComparisonResult)CompareNome2     :(Proprietari *)proper; 
- (NSComparisonResult)CompareCognome   :(Proprietari *)proper; 
- (NSComparisonResult)CompareCognome2  :(Proprietari *)proper; 
- (NSComparisonResult)CompareLuogo     :(Proprietari *)proper; 
- (NSComparisonResult)CompareLuogo2    :(Proprietari *)proper; 
- (NSComparisonResult)CompareDataN     :(Proprietari *)proper; 
- (NSComparisonResult)CompareDataN2    :(Proprietari *)proper; 
- (NSComparisonResult)CompareCodFis    :(Proprietari *)proper; 
- (NSComparisonResult)CompareCodFis2   :(Proprietari *)proper; 
- (NSComparisonResult)CompareNrPr      :(Proprietari *)proper;
- (NSComparisonResult)CompareNrPr2     :(Proprietari *)proper;

@end
