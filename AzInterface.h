//
//  AzInterface.h
//  MacOrMap
//
//  Created by Carlo Macor on 10/09/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "InfoObj.h"
#import "Varbase.h"
#import "Progetto.h"
#import "AzVector.h"
#import "AzRaster.h"
#import "Interface.h"
#import "AzDialogs.h"
#import "BarileDlg.h"
#import "AzExtra.h"
#import "InfoObj.h"


@interface AzInterface : NSObject {
	IBOutlet InfoObj                * info;
	IBOutlet Varbase                * varbase;
	IBOutlet Progetto               * progetto;
	IBOutlet AzVector               * azvector;
	IBOutlet AzRaster               * azraster;
	IBOutlet AzDialogs              * azdialogs;
	IBOutlet AzExtra                * azextra;

    IBOutlet Interface              * interface;
	IBOutlet BarileDlg              * bariledlg;

	
	IBOutlet NSTextField   *  Testo1;
	IBOutlet NSTextField   *  Testo2;
	IBOutlet NSTextField   *  Testo3;
	IBOutlet NSTextField   *  Testo4;
	IBOutlet NSTextField   *  Testo5;
	IBOutlet NSTextField   *  Testo6;
	IBOutlet NSTextField   *  Testo7;
	IBOutlet NSTextField   *  Testo8;
	IBOutlet NSTextField   *  Testo9;
	IBOutlet NSTextField   *  Testo10;
	IBOutlet NSTextField   *  Testo11;
	IBOutlet NSTextField   *  Testo12;

    IBOutlet NSBox         *  CatastoBox;

    
    IBOutlet NSBox         *  Box01;
    IBOutlet NSBox         *  Box02;
    IBOutlet NSBox         *  Box03;
    IBOutlet NSBox         *  Box04;
    IBOutlet NSBox         *  Box05;
    IBOutlet NSBox         *  Box06;
    IBOutlet NSBox         *  Box07;
    IBOutlet NSBox         *  Box08;
    IBOutlet NSBox         *  Box09;
    IBOutlet NSBox         *  Box10;
    IBOutlet NSBox         *  Box11;
    IBOutlet NSBox         *  Box12;

    
	IBOutlet NSButton      *  Bot01;
	IBOutlet NSButton      *  Bot02;
	IBOutlet NSButton      *  Bot03;
	IBOutlet NSButton      *  Bot04;
	IBOutlet NSButton      *  Bot05;
	IBOutlet NSButton      *  Bot06;
	IBOutlet NSButton      *  Bot07;
	IBOutlet NSButton      *  Bot08;
	IBOutlet NSButton      *  Bot09;
	IBOutlet NSButton      *  Bot10;
	IBOutlet NSButton      *  Bot11;
	IBOutlet NSButton      *  Bot12;
	IBOutlet NSButton      *  Bot13;
	IBOutlet NSButton      *  Bot14;
	IBOutlet NSButton      *  Bot15;
	IBOutlet NSButton      *  Bot16;
	IBOutlet NSButton      *  Bot17;
	IBOutlet NSButton      *  Bot18;
	IBOutlet NSButton      *  Bot19;
	IBOutlet NSButton      *  Bot20;
	IBOutlet NSButton      *  Bot21;
	IBOutlet NSButton      *  Bot22;
	IBOutlet NSButton      *  Bot23;
	IBOutlet NSButton      *  Bot24;
	IBOutlet NSButton      *  Bot25;
	IBOutlet NSButton      *  Bot26;
	IBOutlet NSButton      *  Bot27;
	IBOutlet NSButton      *  Bot28;
	IBOutlet NSButton      *  Bot29;
	IBOutlet NSButton      *  Bot30;
	IBOutlet NSButton      *  Bot31;
	IBOutlet NSButton      *  Bot32;

	IBOutlet NSButton      *  Btr01;
	IBOutlet NSButton      *  Btr02;
	IBOutlet NSButton      *  Btr03;
	IBOutlet NSButton      *  Btr04;
	IBOutlet NSButton      *  Btr05;
	IBOutlet NSButton      *  Btr06;
	IBOutlet NSButton      *  Btr07;
	IBOutlet NSButton      *  Btr08;
	IBOutlet NSButton      *  Btr09;
	IBOutlet NSButton      *  Btr10;

	
	NSString * azionecifrata01;
	NSString * azionecifrata02;
	NSString * azionecifrata03;
	NSString * azionecifrata04;
	NSString * azionecifrata05;
	NSString * azionecifrata06;
	NSString * azionecifrata07;
	NSString * azionecifrata08;
	NSString * azionecifrata09;
	NSString * azionecifrata10;
	NSString * azionecifrata11;
	NSString * azionecifrata12;
	NSString * azionecifrata13;
	NSString * azionecifrata14;
	NSString * azionecifrata15;
	NSString * azionecifrata16;
	NSString * azionecifrata17;
	NSString * azionecifrata18;
	NSString * azionecifrata19;
	NSString * azionecifrata20;
	NSString * azionecifrata21;
	NSString * azionecifrata22;
	NSString * azionecifrata23;
	NSString * azionecifrata24;
	NSString * azionecifrata25;
	NSString * azionecifrata26;
	NSString * azionecifrata27;
	NSString * azionecifrata28;
	NSString * azionecifrata29;
	NSString * azionecifrata30;
	NSString * azionecifrata31;
	NSString * azionecifrata32;
	
	
	NSString * azionecifrataFreccia01;
	NSString * azionecifrataFreccia02;
	NSString * azionecifrataFreccia03;
	NSString * azionecifrataFreccia04;
	NSString * azionecifrataFreccia05;
	NSString * azionecifrataFreccia06;
	NSString * azionecifrataFreccia07;
	NSString * azionecifrataFreccia08;
	NSString * azionecifrataFreccia09;
	NSString * azionecifrataFreccia10;

	
	NSString * cancelletto;
	NSString * chiocciola;
	NSString * percentuale;
	NSString * asterisco;
	NSString * parentesiSx;
	NSString * parentesiDx;
	NSString * dollaro;
	NSString * commerciale;
	
	NSString * BaseDir;

}


- (void) InitAzInterface      ;

- (IBAction) CambiaInterfaccia :(id) sender;


- (IBAction) CambiaInterfaccia_MonteArgentario :(id) sender;
- (IBAction) CambiaInterfaccia_Allumiere       :(id) sender;
- (IBAction) CambiaInterfaccia_Tarquinia       :(id) sender;
- (IBAction) CambiaInterfaccia_Ragusa          :(id) sender;



- (IBAction) eseguiAzione :(id) sender;

@end
