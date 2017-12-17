//
//  BarileDlg.h
//  MacOrMap
//
//  Created by Carlo Macor on 23/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "LegendaView.h"


@interface BarileDlg : NSObject {
		// gestite da AZDialogs
	IBOutlet NSPanel             *  dlgEdifici;
	IBOutlet NSPanel             *  dlgFiltriEdifici;
	IBOutlet NSPanel             *  dlgTerreni;
	IBOutlet NSPanel             *  dlgFiltriTerreni;
	IBOutlet NSPanel             *  dlgICI;
	IBOutlet NSPanel             *  dlgTarsu;
	IBOutlet NSPanel             *  dlgAnagrafe;
	IBOutlet NSPanel             *  dlgFiltriAnagrafe;
	IBOutlet NSPanel             *  dlgAttivita;
	IBOutlet NSPanel             *  dlgProprietari;
	IBOutlet NSPanel             *	dlgFiltraProprietari;
	IBOutlet NSPanel             *  dlgPossessori;
	IBOutlet NSPanel             *  dlgPatrimoni;
	IBOutlet NSPanel             *  dlgCercaFgPart;
    IBOutlet NSPanel             *  dlgCercaViaCiv;
	IBOutlet NSPanel             *  dlgGriglia;
	IBOutlet NSPanel             *  DlgPassword;
	IBOutlet NSPanel             *  dlgQuantificatori;
	IBOutlet NSPanel             *  dlgVisuraPdf;
	IBOutlet NSPanel             *  dlgAppunti;


		// Non gestite da AZDialogs
	IBOutlet NSPanel             *  dlgGesVet;
	IBOutlet NSPanel             *  dlgGesRast;
	IBOutlet NSPanel             *  dlgLegenda;
	IBOutlet NSPanel             *  dlcalRas;
	IBOutlet NSPanel             *  dlcalRasF;
	IBOutlet NSPanel             *  dlrighello;
	IBOutlet NSPanel             *  dlgTesto;
	IBOutlet NSPanel             *  dlsimboli;
	IBOutlet NSPanel             *  dlgNuovaCoord;
	IBOutlet NSPanel             *  dlgMancaPoligonoSelected;
	IBOutlet NSPanel             *  dlgConferma;
	IBOutlet NSPanel             *  dlgComandiAmministrativi;
	IBOutlet NSPanel             *  webusabile;
	IBOutlet WebView             *  webcondizioni;
	IBOutlet NSPanel             *  dlgInfoArea;
	IBOutlet NSPanel             *  dlgInfo;
    IBOutlet LegendaView         *  legendaView;

}

	// gestite da AZDialogs
- (NSPanel        *) dlgEdifici;
- (NSPanel        *) dlgFiltriEdifici;
- (NSPanel        *) dlgTerreni;
- (NSPanel        *) dlgFiltriTerreni;
- (NSPanel        *) dlgICI;
- (NSPanel        *) dlgTarsu;
- (NSPanel        *) dlgAnagrafe;
- (NSPanel        *) dlgFiltriAnagrafe;
- (NSPanel        *) dlgAttivita;
- (NSPanel        *) dlgProprietari;
- (NSPanel        *) dlgFiltraProprietari;
- (NSPanel        *) dlgPossessori;
- (NSPanel        *) dlgPatrimoni;
- (NSPanel        *) dlgCercaFgPart;
- (NSPanel        *) dlgCercaViaCiv;
- (NSPanel        *) dlgGriglia;
- (NSPanel        *) DlgPassword;
- (NSPanel        *) dlgQuantificatori;
- (NSPanel        *) dlgVisuraPdf;
- (NSPanel        *) dlgAppunti;


	// Non gestite da AZDialogs
- (NSPanel        *) dlgGesVet;
- (NSPanel        *) dlgGesRast;
- (NSPanel        *) dlgLegenda;
- (NSPanel        *) dlcalRas;
- (NSPanel        *) dlcalRasF;
- (NSPanel        *) dlrighello;
- (NSPanel        *) dlgTesto;
- (NSPanel        *) dlsimboli;
- (NSPanel        *) dlgNuovaCoord;
- (NSPanel        *) dlgMancaPoligonoSelected;
- (NSPanel        *) dlgConferma;
- (NSPanel        *) dlgComandiAmministrativi;
- (NSPanel        *) webusabile;
- (WebView        *) webcondizioni;
- (NSPanel        *) dlgInfoArea;
- (NSPanel        *) dlgInfo;

- (LegendaView    *) legendaView;

@end
