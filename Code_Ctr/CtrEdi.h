//
//  Control_dlgVector.h
//  GIS2010
//
//  Created by Carlo Macor on 24/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Immobili.h"


@interface CtrEdi : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSPanel                 * PannelloTutto;

	IBOutlet NSTableView             * TavolaSubalterni;
	NSMutableArray                   * ListaCtrSuber;
	NSMutableArray                   * ListaCtrSuberFiltrata;
 	NSMutableArray                   * ListaIconeEdif;
    IBOutlet NSPanel                 * PanelEditViaCivico;
	IBOutlet NSButton                * ButFilta;

    IBOutlet NSComboBox              * CombVie;
    IBOutlet NSTextField             * NewCiv;
	NSMutableArray                   * Listebacks;
    int                              correnteback;

    
	bool                             filtroattivo;
	int                              correntevet;
	bool                             rendCresce;
	bool                             ViaCresce;
	bool                             CatCresce;
	bool                             FgCresce;
	bool                             PartCresce;
	bool                             SubCresce;
	bool                             PianoCresce;
	bool                             ConsCresce;
	bool                             ClasseCresce;
	bool                             FlagTarsuCresce;

	
	IBOutlet NSButton                * ButInEdit;
	IBOutlet NSButton                * ButInIci;
	IBOutlet NSButton                * ButInTarsu;

	bool                             inFaseEdit;
	bool                             inFaseICI;
	bool                             inFaseTarsu;
	bool                             inFaseConferma;
	bool                             inFaseAbitato;
	
	
}



- (void)     ImpostaIcone: (NSMutableArray *) iconeList;

- (void)     impostaTuttiSubalterni : (Immobili  *) imb : (Immobili  *) imbFilt;

- (void)     impostaElencoViaAnagrafe : (NSArray  *) listaVie ;


- (void)     AttivaFiltro           : (bool ) bol;
- (void)     AttivaSoloFiltro       : (bool ) bol;

- (void)     ImpostaFoglioPart      : (NSString *) nfoglio :(NSString *) nparticel  ;

- (void)     impostaFoglioPartSub   : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub;

- (void)     impostaConViadaAnag    : (NSString *) via ;

- (Subalterno * ) SubaltConFgPartSub  : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub;



- (void)     updaterighe;

- (int)      indiceprimoselezionato;


- (Subalterno *) subselezionato;

- (NSArray *)    SubSelezionati;

- (void)      setSuberselezionato : (Subalterno *) sub;


- (IBAction) ElencoVieTxtCatasto     : (id)sender;

- (IBAction) CambiaCivico            : (id)sender;

- (IBAction) CambiaVia               : (id)sender;


- (IBAction) ShowdlgEditViaCivico    : (id)  sender;

- (IBAction) OKdlgEditViaCivico      : (id)  sender;


- (IBAction) AzioButInEdit           : (id)  sender;
- (IBAction) AzioButInTarsu          : (id)  sender;
- (IBAction) AzioButInIci            : (id)  sender;
- (IBAction) AzioButInAbitato        : (id)  sender;
- (IBAction) AzioButInwork           : (id)  sender;

- (IBAction) FiltraSoloCase          : (id)  sender;


- (void)     preimpostaBackinLista;

- (IBAction)  BachingLista   : (id) sender  ;


@end
