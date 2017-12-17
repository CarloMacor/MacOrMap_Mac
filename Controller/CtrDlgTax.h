//
//  CtrDlgTarsu.h
//  MacOrMap
//
//  Created by Carlo Macor on 17/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Tax.h"
#import "Subalterno.h"
#import "Famiglia.h"


@interface CtrDlgTax : NSViewController <NSTableViewDelegate, NSTableViewDataSource>  {
	IBOutlet NSTableView             * TavolaTarsu;
	IBOutlet NSTableView             * TavolaIci;

	IBOutlet NSButton                * ButResidenti;
	IBOutlet NSButton                * ButImmobile;
	IBOutlet NSButton                * ButFilta;
	NSMutableArray                   * ListaCtrTarsu;
	NSMutableArray                   * ListaCtrTarsuFiltrata;
	NSMutableArray                   * ListaCtrIci;
	NSMutableArray                   * ListaCtrIciFiltrata;

	NSMutableArray                   * Listebacks;
    int                              correnteback;
	
	bool                             filtroattivoTarsu;
	bool                             filtroattivoIci;
	bool                             FgCresce;
		//	bool                             PartCresce;
		//	bool                             TaxCresce;
	bool                             ViaCresce;
	bool                             NomeCresce;
	bool                             CodFisCresce;
	bool                             SupDicCresce;
	bool                             FlagCresce;
	bool                             demoSensibili;
	
}

@property(nonatomic) bool	filtroattivoTarsu;
@property(nonatomic) bool	filtroattivoIci;
@property(nonatomic) bool	demoSensibili;


- (void)     impostaListe : (Tax *) taxer   : (Tax *) taxerFilt;

- (void)     impostaTarsuFoglioPartSub : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub ;

- (void)     impostaIciFoglioPartSub : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub ;

- (void)     impostaCirca : (Subalterno * ) suber ; 

- (void)     impostaCircaFamiglia : (Famiglia * ) family ; 

- (void)     preimpostaBackinLista;


- (void)     updaterighe;


- (void)     setfiltro : (bool) modo;

- (Tax_ele *) TarserSelezionato : (bool) tarsTavola;

- (IBAction)  EliminaRecord   : (id) sender  ;

- (IBAction)  DuplicaRecord   : (id) sender  ;

- (IBAction)  BachingLista   : (id) sender  ;

- (void)      setTaxerselezionato : (Tax_ele *) taxer :  (bool) tarsTavola;




@end
