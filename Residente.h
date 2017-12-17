//
//  Residente.h
//  MacOrMap
//
//  Created by Carlo Macor on 26/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Residente : NSObject {
	NSString * Nome;
	NSString * Cognome;
	NSString * codFis;
	NSString * codFamiglia;
	NSCalendarDate   * dataNascita;
	NSString * viaEstesa;
	NSString * via;
	NSString * nr;
    int indsalvaFamiglie;
	int        codIntestatario;
	id        suaFamiglia;
		//	NSString * datanascita;
}

- (void) svuota;

- (void) salva              :(NSMutableData *) lodata : (int) salvafam;
- (void)  apri           :(NSData  *) DataFile : (int *) posdata;


- (void) addstringaData2   : (NSMutableData *) dat : (NSString *) str;
- (NSString *) GetStringaData2 : (NSData        *) data : (int *) pos;


- (NSString *) Nome;
- (NSString *) Cognome;
- (NSString *) codFis;
- (NSString *) codFamiglia;
- (NSString *) dataNascitaStr;
- (NSString *) viaEstesa;
- (NSString *) via;
- (NSString *) nr;
- (NSCalendarDate   *) dataNascita;

- (int       ) codIntestatario;
- (int       ) indsalvaFamiglie;

- (void) ImpostagliFamiglia : (id) family;

- (id) famigliassociata ;

- (void) SetNome : (NSString *) nome;


- (void) SetCognome : (NSString *) cognome;

- (void) SetCodFis  : (NSString *) codfis;

- (void) SetCodFam  : (NSString *) codfam;

- (void) SetDataNascita  : (NSString *) datanasc;

- (void) SetviaEstesa  : (NSString *) viaest;

- (void) SetcodIntestatario  : (int ) codint;

- (void) logga;

- (NSComparisonResult)CompareNome      :(Residente *) resider ; 
- (NSComparisonResult)CompareCognome   :(Residente *) resider ; 
- (NSComparisonResult)CompareVia       :(Residente *) resider ; 
- (NSComparisonResult)CompareData      :(Residente *) resider ; 


@end
