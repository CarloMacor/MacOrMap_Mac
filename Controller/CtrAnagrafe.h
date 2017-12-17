//
//  CtrAnagrafe.h
//  MacOrMap
//
//  Created by Carlo Macor on 14/04/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Anagrafe.h"

@interface CtrAnagrafe :  NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView             * TavolaAnagrafe;
	IBOutlet NSTableView             * TavolaComponentiFamiglia;
	Anagrafe                         * anagrafe;
    Famiglia                         * famigliaselezionata;
    bool                             solointestatari;
	bool                             demoSensibili;
	bool                             filtroattivo;
    IBOutlet NSTextField             * titoloresidenti;
	IBOutlet NSButton                * ButSolointestatari;
	NSMutableArray                   * Listebacks;
	int                              correnteback;
}

@property(nonatomic) bool	demoSensibili;

- (void)     passaAnagrafe  : (Anagrafe *)  an ;
- (void)     AttivaFiltro        : (bool ) bol;



- (IBAction) ButInestatario          : (id)sender;

- (void) setButIntestatari           : (bool) stato ;

- (Famiglia *)  subFamselezionato ;
- (Residente *) subResselezionato ;

- (void)      setFamselezionato : (Famiglia  *) fam;
- (void)      setResselezionato : (Residente *) resid;

- (void)     preimpostaBackinLista;

- (void)     updaterighe          ;

- (void)     impostaResidFiltInfoEdif : (NSString *) fg :  (NSString *) part : (NSString *) sub ;

- (void)     impostaResidFiltInfoViaNoassegnata: (NSString *) viasub; 

- (void)     impostaResidFiltInfoTaxer: (NSString *) codfiscale;

- (IBAction)  BachingLista   : (id) sender  ;


- (void)      riordinacognome;


@end
