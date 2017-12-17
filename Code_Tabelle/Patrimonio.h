//
//  Patrimonio.h
//  MacOrMap
//
//  Created by Carlo Macor on 16/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Patrimonio : NSObject {
   
	NSString * DirittiOneri;
	NSString * Foglio;
	NSString * Particella;
	NSString * Sub;
	NSString * Categoria;
	int        CodCategoria;

	int        TipoEdiTerra; // 0 = Edificio  ; 1 = Terra
	double     Redditoedile; // 0 = Edificio 
	double     RedditoDomenicale; // 1 = Terra
	double     RedditoAgrario;    // 1 = Terra

	int        NDiritti;
	int        DDiritti;
	
	float      fprop;
}


- (NSString    *) DirittiOneri;
- (NSString    *) Foglio;
- (NSString    *) Particella;
- (NSString    *) Sub;
- (NSString    *) Categoria;

- (NSString *) EstraiPrimoElemento :  (NSString *) strin;

- (NSString    *) FoglioSingolo;
- (NSString    *) ParticellaSingola;
- (NSString    *) SubSingolo;


- (NSString    *) Renditastr;  
- (NSString    *) Agrariastr;
- (NSString    *) Domenicalestr;
- (NSString    *) Infocompleto;
- (NSString    *) percPropStr;

- (float)         fprop;
- (int)           CodCategoria;
- (int)           faicodCat: (NSString *) st;

- (int)           TipoEdiTerra;
- (double)        Redditoedile;
- (double)        RedditoDomenicale;
- (double)        RedditoAgrario;


- (void) SetPatrimonioEsteso: (NSString *) oneri : (NSString *) infoprop;

- (void) SetFoglio      : (NSString *) foglio;
- (void) SetParticella  : (NSString *) particella;
- (void) SetSub         : (NSString *) sub;
- (void) SetCategoria   : (NSString *) categoria;
- (void) SetCodCategoria : (int) codcategoria;


- (void) SetaddedFoglio      : (NSString *) foglio;
- (void) SetaddedParticella  : (NSString *) particella;
- (void) SetaddedSub         : (NSString *) sub;

- (void) SetTipoEdiTerra        : (int)   value;
- (void) SetRedditoedile        : (float) value;
- (void) SetRedditoDomenicale   : (float) value;
- (void) SetRedditoAgrario      : (float) value;
- (void) SetRedditoedileStr     : (NSString *) strvalue;
- (void) SetRedditoDomenicaleStr: (NSString *) strvalue;
- (void) SetRedditoAgrarioStr   : (NSString *) strvalue;
- (bool)  eguaglia              : (Patrimonio *) pat2;

- (void) addstringaData : (NSMutableData *) dat : (NSString *) str     ;
- (void) addstringaData2  : (NSMutableData *) dat : (NSString *) str ;
- (NSString *) GetStringaData2 : (NSData  *) data : (int *) pos ;



- (void) salva          : (NSMutableData *) lodata;
- (void)  apri           :(NSData  *) DataFile : (int *) posdata     ;

		//- (int)  apri           : (NSFileHandle  *) fileHandle : (int) posfile;

- (bool) presenzainfo   : (NSString *)fg :  (NSString *)part :  (NSString *)subo;

- (void) setoneri       : (NSString *)oneristr;

- (double) valoresenzapunto : (NSString *) valstr;

- (void)  InterpretaDirittiOneri ;

- (void) logga;


- (NSComparisonResult)CompareFg       :(Patrimonio *)pater;
- (NSComparisonResult)CompareFg2      :(Patrimonio *)pater;
- (NSComparisonResult)ComparePart     :(Patrimonio *)pater;
- (NSComparisonResult)ComparePart2    :(Patrimonio *)pater;
- (NSComparisonResult)CompareSub      :(Patrimonio *)pater;
- (NSComparisonResult)CompareSub2     :(Patrimonio *)pater;
- (NSComparisonResult)CompareCat      :(Patrimonio *)pater;
- (NSComparisonResult)CompareCat2     :(Patrimonio *)pater;
- (NSComparisonResult)CompareRendPat  :(Patrimonio *)pater;
- (NSComparisonResult)CompareRendPat2 :(Patrimonio *)pater;
- (NSComparisonResult)CompareAgraPat  :(Patrimonio *)pater;
- (NSComparisonResult)CompareAgraPat2 :(Patrimonio *)pater;
- (NSComparisonResult)CompareDomePat  :(Patrimonio *)pater;
- (NSComparisonResult)CompareDomePat2 :(Patrimonio *)pater;

@end
