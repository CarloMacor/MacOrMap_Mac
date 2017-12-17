//
//  Tarsu_ele.h
//  MacOrMap
//
//  Created by Carlo Macor on 16/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Tax_ele : NSObject {
	NSString       * Nome;
	NSString       * Cognome;
	NSString       * Codfis;
	NSString       * Foglio;
	NSString       * Particella;
	NSString       * Sub;
	NSString       * Via;
	NSString       * Civico;
	NSString       * ConsisCat;
	double           SupDich;
	double           TaxDich;
	double           TaxPagata;
	short            FlagAssociato;
}

@property(nonatomic) short	FlagAssociato;


- (void)       salva            :(NSMutableData *) lodata;

	//- (void)        apri               :(NSFileHandle  *) fileHandle;

- (void)  apri           :(NSData  *) DataFile : (int *) posdata;


- (void)       addstringaData   : (NSMutableData *) dat : (NSString *) str;
- (void) addstringaData2  : (NSMutableData *) dat : (NSString *) str ;    

- (NSString *) GetStringaData : (NSFileHandle  *) fileHandle ;
- (NSString *) GetStringaData2 : (NSData        *) data : (int *) pos ;

- (Tax_ele *) duplica;

- (void)       svuota                  ;

- (void)       SetNome       : (NSString * ) _nome;
- (void)       SetCognome    : (NSString * ) _cognome;
- (void)       SetCodFis     : (NSString * ) _codfis;
- (void)       SetFoglio     : (NSString * ) _foglio;
- (void)       SetParticella : (NSString * ) _particella;
- (void)       SetSub        : (NSString * ) _sub;
- (void)       SetVia        : (NSString * ) _via;
- (void)       SetCivico     : (NSString * ) _civico;
- (void)       SetConsisCat  : (NSString * ) _conscat;
- (void)       SetSupDich    : (double )     _supdic;
- (void)       SetTaxDich    : (double )     _taxdic;
- (void)       SetTaxPagata  : (double )     _taxpagata;



- (NSString * )       Nome       ;
- (NSString * )       Cognome    ;
- (NSString * )       CodFis     ;
- (NSString * )       Foglio     ;
- (NSString * )       Particella ;
- (NSString * )       Sub        ;
- (NSString * )       Via        ;
- (NSString * )       Civico     ;
- (NSString * )       ConsisCat  ;
- (double     )       SupDich    ;
- (double     )       TaxDich    ;
- (double     )       TaxPagata  ;
- (NSString * )       TaxPagataStr;


- (NSComparisonResult)CompareFg       :(Tax_ele *)tar ;

- (NSComparisonResult)CompareFg2      :(Tax_ele *)tar ;

- (NSComparisonResult)CompareVia      :(Tax_ele *)tar ;

- (NSComparisonResult)CompareVia2     :(Tax_ele *)tar ;

- (NSComparisonResult)CompareNome     :(Tax_ele *)tar ;

- (NSComparisonResult)CompareNome2    :(Tax_ele *)tar ;

- (NSComparisonResult)CompareSupDic   :(Tax_ele *)tar ;

- (NSComparisonResult)CompareSupDic2  :(Tax_ele *)tar ;

- (NSComparisonResult)Comparetaxpagata    :(Tax_ele *)tar ;

- (NSComparisonResult)Comparetaxpagata2   :(Tax_ele *)tar ;

- (NSComparisonResult)CompareCodfis       :(Tax_ele *)tar;

- (NSComparisonResult)CompareCodfis2      :(Tax_ele *)tar;

- (void) logga;

@end
