//
//  Subalterno.h
//  MacOrMap
//
//  Created by Carlo Macor on 28/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Subalterno : NSObject <NSCoding> {
    int        indice;
	NSString * Foglio;
	NSString * Particella;
	NSString * Sub;
	NSString * Categoria;
	NSString * Classe;
	NSString * Consistenza;
	NSString * PianoEdificio;
	NSString * Civico;
	NSString * Interno;
	NSString * Via;
	double     Rendita;
	int        codCat; 
	short      FlagTarsu;
	short      FlagIci;
    short      FlagAbitato;

   
	int        CorrTabelle; // 0 = OK   1 = record non ha grafica    2 = grafica non ha record
    short      Conferma;  // 64 e oltre confermato altri flag 1,2,4,8, ... per modifiche dei campi esempio 6 : Via+civico (2+4)
}


- (void) svuota;


@property(nonatomic) int	indice;
@property(nonatomic) double	Rendita;
@property(nonatomic) short	Conferma;
@property(nonatomic) short	FlagTarsu;
@property(nonatomic) short	FlagIci;
@property(nonatomic) short  FlagAbitato;




- (NSString *) indicestr;
- (NSString *) renditastr;

- (NSString *) Foglio;
- (NSString *) FoglioSingolo;
- (NSString *) Particella;
- (NSString *) ParticellaSingola;
- (NSString *) Sub;
- (NSString *) SubSingolo;
- (NSString *) Categoria;
- (NSString *) Classe;
- (NSString *) Consistenza;
- (NSString *) PianoEdificio;
- (NSString *) Civico;
- (NSString *) Interno;
- (NSString *) Via;
- (int) codCat;
- (int) faicodCat: (NSString *) st;

- (NSString *) Infocompleto;
- (NSString *) EstraiPrimoElemento :  (NSString *) strin;

- (void) setFoglio        : (NSString *) foglio;
- (void) setParticella    : (NSString *) particella;
- (void) setSub           : (NSString *) sub;
- (void) setCategoria     : (NSString *) categoria;
- (void) setClasse        : (NSString *) classe;
- (void) setConsistenza   : (NSString *) consistenza;
- (void) setPianoEdificio : (NSString *) pianoEdificio;
- (void) setCivico        : (NSString *) civico;
- (void) setInterno       : (NSString *) interno;
- (void) setVia           : (NSString *) via;

- (void) addsetFoglio     : (NSString *) foglio;
- (void) addsetParticella : (NSString *) particella;
- (void) addsetSub        : (NSString *) sub;

- (void) addstringaData   : (NSMutableData *) dat : (NSString *) str ;
- (void) addstringaData2   : (NSMutableData *) dat : (NSString *) str;     

- (NSString *) GetStringaData : (NSFileHandle  *) fileHandle ;
- (NSString *) GetStringaData2 : (NSData  *) data : (int *) pos ;


- (void) salva            : (NSMutableData *) lodata;
	//- (int)  apri             : (NSFileHandle  *) fileHandle : (int) posfile;
- (void)  apri           :(NSData  *) DataFile : (int *) posdata;

- (bool) inlistanomesub   : (NSString *) nomsuber;
- (int)  IndSePresente    : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub;

- (void) Logga;

- (bool) iscasa;

- (NSComparisonResult)CompareCivico   :(Subalterno *)suber; 
- (NSComparisonResult)CompareVia      :(Subalterno *)suber;
- (NSComparisonResult)CompareVia2     :(Subalterno *)suber;
- (NSComparisonResult)CompareCat      :(Subalterno *)suber;
- (NSComparisonResult)CompareCat2     :(Subalterno *)suber;
- (NSComparisonResult)CompareRendita  :(Subalterno *)suber;
- (NSComparisonResult)CompareRendita2 :(Subalterno *)suber;
- (NSComparisonResult)CompareFg       :(Subalterno *)suber;
- (NSComparisonResult)CompareFg2      :(Subalterno *)suber;
- (NSComparisonResult)ComparePart     :(Subalterno *)suber;
- (NSComparisonResult)ComparePart2    :(Subalterno *)suber;
- (NSComparisonResult)CompareSub      :(Subalterno *)suber;
- (NSComparisonResult)CompareSub2     :(Subalterno *)suber;
- (NSComparisonResult)ComparePiano    :(Subalterno *)suber;
- (NSComparisonResult)ComparePiano2   :(Subalterno *)suber;
- (NSComparisonResult)CompareCons     :(Subalterno *)suber;
- (NSComparisonResult)CompareCons2    :(Subalterno *)suber;
- (NSComparisonResult)CompareClasse   :(Subalterno *)suber;
- (NSComparisonResult)CompareClasse2  :(Subalterno *)suber;

@end
