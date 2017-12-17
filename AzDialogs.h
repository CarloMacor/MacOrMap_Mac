//
//  AzDialogs.h
//  MacOrMap
//
//  Created by Carlo Macor on 22/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Varbase.h"
#import "Progetto.h"
#import "BarileDlg.h"
#import "BarileCtr.h"
#import "Interface.h"
#import "InterfaceDlg.h"
#import "AzExtra.h"

@interface AzDialogs : NSObject {
	IBOutlet Varbase                * varbase;
	IBOutlet Progetto               * progetto;
    IBOutlet InfoObj                * info;
	IBOutlet BarileDlg              * bariledlg;
	IBOutlet BarileCtr              * barilectr;
	IBOutlet Interface              * interface;
	IBOutlet InterfaceDlg           * interfacedlg;
	IBOutlet AzExtra                * azextra;

}

- (void) InitAzDialogs      ;


	// dlg Fabbricati 
- (IBAction) ApriDlgFabbricati              : (id) sender;
- (IBAction) OKdlgFabbricati                : (id) sender;
- (IBAction) ApriDlgFiltriFabbricati        : (id) sender;
- (IBAction) ApriDlgIcidaFabbricati         : (id) sender;
- (IBAction) ApriDlgTarsudaFabbricati       : (id) sender;
- (IBAction) ApriDlgTarsuSeccadaFabbricati  : (id) sender;
- (IBAction) ApriDlgTarsuCircadaFabbricati  : (id) sender;
- (IBAction) ApridlgAnagrafedaFabbricati    : (id) sender;
- (IBAction) VaiGrafEdifdaFabbricati        : (id) sender;
- (IBAction) ApridlgPossdaFabbricati        : (id) sender;
- (IBAction) ApriVisuradaFabbricati         : (id) sender;
	// dlg Filtra Fabbricati 
- (IBAction) OKdlgFiltriEdifici             : (id) sender;



	// dlg Terreni 
- (IBAction) ApriDlgTerreni                 : (id) sender;
- (IBAction) OkdlgTerreni                   : (id) sender;
- (IBAction) ApriDlgFiltriTerreni           : (id) sender;
- (IBAction) VaiGrafTerradaTerra            : (id) sender;
- (IBAction) ApridlgPossdaTerra             : (id) sender;
- (IBAction) ApriVisuradaTerreni            : (id) sender;
	// dlg Filtra Terreni 
- (IBAction) OKdlgFiltriTerreni             : (id) sender;


	// dlg ICI
- (IBAction) ApriDlgICI                     : (id) sender;
- (IBAction) OkdlgICI                       : (id) sender;
- (IBAction) ApriDlgTarsudaIci              : (id) sender;
- (IBAction) ApridlgAnagrafedaIci           : (id) sender;
- (IBAction) VaiGrafEdifdaIci               : (id) sender;
- (IBAction) ApridlgPossdaIci               : (id) sender;


	// dlg Tarsu
- (IBAction) ApriDlgTarsu                   : (id) sender;
- (IBAction) OkdlgTarsu                     : (id) sender;
- (IBAction) ConnettiTarsuFabbricati        : (id) sender;
- (IBAction) TarsuCambiaFlag                : (id) sender;
- (IBAction) ApriDlgIcidaTarsu              : (id) sender;
- (IBAction) ApridlgAnagrafedaTarsu         : (id) sender;
- (IBAction) VaiGrafEdifdaTarsu             : (id) sender;
- (IBAction) ApridlgPossdaTarsu             : (id) sender;
- (IBAction) ApridlgEdifdaTarsu             : (id) sender;

- (IBAction) ConnettiAnagrafeTarsuFab       : (id) sender;


	// dlg Anagrafe
- (IBAction) ApriDlgAnagrafe                : (id) sender;
- (IBAction) OkdlgAnagrafe                  : (id) sender;
- (IBAction) ApriDlgFiltriAnagrafe          : (id) sender;
- (IBAction) ApriDlgTarsudaAnagrafe         : (id) sender;
- (IBAction) ApridlgPatrdaAnagrafe          : (id) sender;
- (IBAction) VaiGrafEdifdaAnagrafe          : (id) sender;
- (IBAction) VaiTabellaEdifdaAnagrafe       : (id) sender;

	// dlg Filtro Anagrafe
- (IBAction) OkdlgFiltroAnag         : (id)sender;


    // dlg Attivita'
- (IBAction) ApriDlgAttivita                : (id) sender;
- (IBAction) OkdlgAttivita                  : (id) sender;

    // dlg Proprietari
- (IBAction) ApridlgProprietari             : (id) sender;
- (IBAction) OkdlgProprietari               : (id) sender;
- (IBAction) ApridlgPatrdaProprietari       : (id) sender;
    // dlg Filtra Proprietari
- (IBAction) ApriDlgFiltraProprietari       : (id) sender;
- (IBAction) OkDlgFiltraProprietari         : (id) sender;


    // dlg Possessori
- (IBAction) OkdlgPossessori                : (id) sender;
- (IBAction) ApridlgPatrdaPossessori        : (id) sender;


    // dlg Patrimonio
- (IBAction) OkdlgPatrimoni                 : (id) sender;
- (IBAction) ApridlgPossdaPatri             : (id) sender;
- (IBAction) VaiGrafEdifdaPatrimAll         : (id) sender;
- (IBAction) VaiGrafEdifdaPatrim            : (id) sender;
- (IBAction) ApridlgImmodaPatrim            : (id) sender;
- (IBAction) ApriVisuradaPatrimonio         : (id) sender;


	// dlg cerca Particelle catastali
- (IBAction) ApriDlgCercaPart               : (id) sender;
- (IBAction) OkdlgCercaPart                 : (id) sender;
- (IBAction) ImpostaFgCercaPart             : (id) sender;
- (IBAction) ChiudiDlgCercaPart             : (id) sender;
- (IBAction) ApriDlgCercaViaCiv             : (id) sender;
- (IBAction) OkdlgCercaViaCiv               : (id) sender;
- (IBAction) ImpostaViaCercaSubalterno      : (id) sender;
- (IBAction) ChiudiDlgCercaViaCiv           : (id) sender;


    // dlg Griglia
- (IBAction) ApriDlgGriglia                 : (id) sender;
- (IBAction) AttivaGriglia                  : (id) sender;
- (IBAction) OkdlgGriglia                   : (id) sender;


    // dlg Password
- (IBAction) ApriDlgPassword                : (id) sender;
- (IBAction) OkDlgPassword                  : (id) sender;


    // dlg Quantificatori
- (IBAction) ApriDlgQuantificatori          : (id) sender;
- (IBAction) OkDlgQuantificatori            : (id) sender;

	// dlg visura
- (IBAction) ChiudiVisuraPdf                : (id) sender;

    // dlg Conferma
- (void)     ApriDlgConferma                : (int)codmsg;
- (IBAction) OKdlgConferma                  : (id) sender;
- (IBAction) CanceldlgConferma              : (id) sender;

	// dlg legenda Immagine Raster
- (IBAction) OkDlgLegendaImmagine           : (id) sender;

	// dlg simboli
- (IBAction) Apridlgsimboli                 : (id)sender;
- (IBAction) Chiudidlgsimboli               : (id)sender;



	// dlgWeb condizioni google e MacOrMap web site
- (IBAction) ApridlgGoogleCondizioni        : (id)sender;
- (IBAction) ApridlgWebMacOrMap             : (id)sender; 
- (IBAction) OKdlgGoogleCondizioni          : (id)sender;

    // dlg Comandi amministrativi
- (IBAction) ApriDlgComandiamministrativi   : (id) sender;
- (IBAction) OKdlgComandiAmministrativi     : (id) sender;


	// dlg appunti
- (IBAction) OKdlgAppunti                   : (id) sender;
- (IBAction) SalvaAppunti                   : (id) sender;

@end
