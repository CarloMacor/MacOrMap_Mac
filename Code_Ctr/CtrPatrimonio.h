//
//  CtrPatrimonio.h
//  MacOrMap
//
//  Created by Carlo Macor on 18/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Proprietari.h"
#import "CtrEdi.h"


@interface CtrPatrimonio :  NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTextField             * infotestoPatrimonio;
	IBOutlet NSTableView             * TavolaPatrimonio;
	IBOutlet CtrEdi                  * Loc_ctredi;

	NSMutableArray                   * ListaIconeEdif;
	Proprietari                      * FamigliaIntestataria;

	Proprietari                      * Intestatario;
	bool                             FgCresce;
	bool                             PartCresce;
	bool                             SubCresce;
	bool                             TipoCresce;
	bool                             RenditaCresce;
	bool                             AgrariaCresce;
	bool                             DomenicaleCresce;

	bool                             inpatrimoniofamiliare;
	bool                             demoSensibili;

}

@property(nonatomic) bool	inpatrimoniofamiliare;
@property(nonatomic) bool	demoSensibili;

- (void)  ImpostaIcone           : (NSMutableArray *) iconeList;


- (void)  impostainfotitolo :(NSString *) titolo;

- (void)  impostaFamigliaIntestataria :(Proprietari *) proper;

- (void)  impostaintestatario :(Proprietari *) proper;

- (void)  updaterighe;

- (Patrimonio *) patselezionato ;

- (void)      setPatselezionato : (Patrimonio *) pat;



- (NSImage *) iconaCodice : (int) cod ;

- (Proprietari *) Intestatario;

- (Proprietari *) FamigliaIntestataria;


@end
