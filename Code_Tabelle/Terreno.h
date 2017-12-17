//
//  Terreno.h
//  MacOrMap
//
//  Created by Carlo Macor on 28/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Terreno : NSObject {
    int        Indice;
	NSString * Foglio;
	NSString * Particella;
	NSString * Qualita;
	NSString * Classe;
	NSString * Zona;
	int        Superficie;
	double     Renditadomenicale;
	double     Renditaagraria;
	int        CorrTabelle; // 0 = OK   1 = record non ha grafica    2 = grafica non ha record
}

@property(nonatomic) int	Indice;
@property(nonatomic) int	Superficie;
@property(nonatomic) double	Renditadomenicale;
@property(nonatomic) double	Renditaagraria;
@property(nonatomic) int	CorrTabelle;

- (void) svuota;

- (NSString *) Infocompleto;
- (NSString *) indicestr;
- (NSString *) Renditadomenicalestr;
- (NSString *) Renditaagrariastr;

- (NSString *) Foglio;
- (NSString *) Particella;
- (NSString *) Qualita;
- (NSString *) Classe;
- (NSString *) Zona;

- (NSString *) Superficiestr;

- (NSString *) EstraiPrimoElemento :  (NSString *) strin;
- (NSString *) FoglioSingolo;
- (NSString *) ParticellaSingola;



- (void) SetFoglio      : (NSString *) foglio;
- (void) SetParticella  : (NSString *) particella;
- (void) SetQualita     : (NSString *) qualita;
- (void) SetClasse      : (NSString *) classe;
- (void) SetZona        : (NSString *) zona;


- (void) addstringaData :(NSMutableData *) dat : (NSString *) str ;
- (void) addstringaData2   : (NSMutableData *) dat : (NSString *) str     ;

- (NSString *) GetStringaData : (NSFileHandle  *) fileHandle ;
- (NSString *) GetStringaData2 : (NSData  *) data : (int *) pos ;

- (void) salva          :(NSMutableData *) lodata;
	//- (int)  apri           :(NSFileHandle  *) fileHandle : (int) posfile;
- (void)  apri           :(NSData  *) DataFile : (int *) posdata;

- (bool) inlistanomepart   : (NSString *) nompartic;

- (NSComparisonResult)CompareFg       :(Terreno *)ter;
- (NSComparisonResult)CompareFg2      :(Terreno *)ter;
- (NSComparisonResult)ComparePart     :(Terreno *)ter;
- (NSComparisonResult)ComparePart2    :(Terreno *)ter;
- (NSComparisonResult)CompareQl       :(Terreno *)ter;
- (NSComparisonResult)CompareQl2      :(Terreno *)ter;
- (NSComparisonResult)CompareCl       :(Terreno *)ter;
- (NSComparisonResult)CompareCl2      :(Terreno *)ter;
- (NSComparisonResult)CompareSup      :(Terreno *)ter;
- (NSComparisonResult)CompareSup2     :(Terreno *)ter;
- (NSComparisonResult)CompareDom      :(Terreno *)ter;
- (NSComparisonResult)CompareDom2     :(Terreno *)ter;
- (NSComparisonResult)CompareAg       :(Terreno *)ter;
- (NSComparisonResult)CompareAg2      :(Terreno *)ter;

@end
