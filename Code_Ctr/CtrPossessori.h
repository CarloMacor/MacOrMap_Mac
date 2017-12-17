//
//  CtrPossessori.h
//  MacOrMap
//
//  Created by Carlo Macor on 17/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Proprietari.h"


@interface CtrPossessori : NSViewController <NSTableViewDelegate, NSTableViewDataSource>  {
	IBOutlet NSTextField             * infotestoproprieta;
	IBOutlet NSTableView             * TavolaPossessori;
	NSMutableArray                   * CopiaListaPossessori;
	NSMutableArray                   * ListaPossessori;
	NSMutableArray                   * ListaStrOneri;
	bool                             NomeCresce;
	bool                             CognomeCresce;
	bool                             LuogoCresce;
	bool                             DataCresce;
	bool                             CfisCresce;
	bool                             nrPropCresce;
	bool                             demoSensibili;

}

@property(nonatomic) bool	demoSensibili;


- (void)  passaListaPossessori  : (NSMutableArray *)  lista ;


- (void)  impostainfopropieta :(NSString *) nomsuber;

- (void)  impostaelencopossessori : (NSString *) fg : (NSString *) part : (NSString *) subo;

- (void)     impostaelepossessoriterra  :(NSString *) fg : (NSString *) part :  (NSString *) zona ;

- (void)     impostaelepossessoriFT  :(NSString *) fg : (NSString *) part  :  (NSString *) zona : (int) tipoFT ;


- (void)  updaterighe                             ;

- (Proprietari *) subselezionato ;

- (void)      setPropselezionato : (Proprietari *) prop;


@end
