//
//  Immobili.h
//  MacOrMap
//
//  Created by Carlo Macor on 28/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Subalterno.h"
#import "Terreno.h"


@interface Immobili : NSObject {
	NSString       * VersioneImmobili;
	NSString       * CodiceComune;
	NSString       * nomecomune;
	
	NSMutableArray * ListaTerreni;
	NSMutableArray * ListaSubalterni;
	// gli edifici sono in una array di array 
	// ogni sottoarray ha la lista dei subalterni
}

- (void) initimmobili;

- (void) svuotaListaTerreni;
- (void) svuotaListaSubalterni;

- (void) addstringaData   : (NSMutableData *) dat : (NSString *) str ;
- (void) addstringaData2  : (NSMutableData *) dat : (NSString *) str ;    

- (NSString *) GetStringaData  : (NSFileHandle  *) fileHandle ;
- (NSString *) GetStringaData2 : (NSData        *) data : (int *) pos ;



- (void) salva : (NSString *) nomefile;
- (void) apri  : (NSString *) nomefile;


- (NSString       *) VersioneImmobili;
- (NSString       *) CodiceComune;
- (NSString       *) nomecomune;



- (NSMutableArray *) LTer;
- (NSMutableArray *) ListaSubalterni;


- (int)        numTuttiSubalterni;	
- (int)        numTuttiTerreni;	

- (NSString       *) indicesubStr  :(int) indice;
- (NSString       *) renditasubStr :(int) indice;

- (NSString       *) foglioSubStr :(int) indice;
- (NSString       *) particSubStr :(int) indice;
- (NSString       *) SubSubStr    :(int) indice;
- (NSString       *) CatSubStr    :(int) indice;
- (NSString       *) ClaSubStr    :(int) indice;
- (NSString       *) ConsistenzaSubStr  :(int) indice ;
- (NSString       *) PianoedifSubStr    :(int) indice ;
- (NSString       *) CivicoSubStr       :(int) indice ;
- (NSString       *) InternoSubStr      :(int) indice ;
- (NSString       *) ViaSubStr          :(int) indice ;


- (NSString       *) indiceTsubStr  :(int) indice;
- (NSString       *) foglioTSubStr  :(int) indice;
- (NSString       *) particTSubStr  :(int) indice;
- (NSString       *) qualitaTSubStr :(int) indice;
- (NSString       *) classeTSubStr  :(int) indice;
- (NSString       *) superficieTSubStr :(int) indice;
- (NSString       *) domenicaleTSubStr :(int) indice;
- (NSString       *) agrariaTSubStr    :(int) indice;


- (bool)          EsisteTerreno    : (NSString *) Fg :  (NSString *) Part;
- (bool)          EsisteFabbricato : (NSString *) Fg :  (NSString *) Part;

- (NSString       *) QualitaTerrenoFgPart  : (NSString *) Fg :  (NSString *) Part;


@end
