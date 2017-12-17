//
//  Varbase.h
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BarileDlg.h"
#import "BarileCtr.h"
#import "Interface.h"
#import "DisegnoR.h"
#import "Immobili.h"
#import "Proprietari.h"
#import "Anagrafe.h"
#import "Tax.h"


typedef enum {
	kStato_nulla,
	kStato_Pan,
	kStato_zoomWindow,
	kStato_zoomC,
	
	kStato_spostaRaster_uno,
	kStato_spostaRaster_tutti,
	
	kStato_spostaRaster2pt_uno,
	kStato_spostaRaster2pt_tutti,
	kStato_rotoScal2PtCentrato,
	
	
	kStato_FixCentroRot,
	kStato_FixVCentroRot,
	kStato_Calibraraster,
	kStato_CalibrarasterFix,
	
	
	kStato_scalarighello,                   	
	kStato_rotoscalaraster,    
	kStato_calibra8click,	
	kStato_Punto,                	
	kStato_Polilinea,                    	
	kStato_Poligono,                   	
	kStato_Regione,                    	
	kStato_Cerchio, 
	
	kStato_CatPoligono,                    	
	kStato_PtTastiera,                    	

	
	
	kStato_Splinea,
	kStato_Spoligono,
	kStato_Sregione,
	
	kStato_Simbolo,
	kStato_SimboloRot,
	kStato_SimboloRotSca,
	kStato_SimboloFisso,
	kStato_Testo,
	kStato_TestoRot,
	kStato_TestoRotSca,

	
	kStato_Rettangolo,
	
		// edit
	kStato_Seleziona,
	kStato_Deseleziona,
	kStato_CancellaSelected,
	kStato_SpostaSelected,
	kStato_CopiaSelected,
	kStato_ScalaSelected,
	kStato_RuotaSelected,
		// edit vertice
	kStato_SpostaVertice,
	kStato_InserisciVertice,
	kStato_CancellaVertice,
	kStato_EditSpVt,
	
	kStato_SpostaDisegno,                	
        //    kStato_RuotaDisegno,
        //	kStato_ScalaDisegno,
	
	kStato_Righello,
	
	kStato_Info,
	kStato_InfoSup,
	kStato_InfoLeg,
	kStato_InfoIntersezione2Poligoni,

	kStato_Match,
	
	kStato_InfoEdificio,
	kStato_InfoTerreno,
	
	kStato_RettangoloStampa,
	kStato_RettangoloDoppioStampa,

	kStato_TarquiniaFogliopt,
	
	
	kStato_InfoTaxTerreno

} ComandoStato;





@interface Varbase : NSObject {
	IBOutlet   BarileDlg         * bariledlg;
	IBOutlet   BarileCtr         * barilectr;
	IBOutlet   Interface         * interface;
	IBOutlet   InterfaceWindow   * interfacewindow;

	int      TipoProiezione;          // 0 = UTM    ; 1 : catastale   ; 2 Lat-Long

	NSInteger  Comando;
	NSInteger  FaseComando;
	double      d_x1coord,  d_y1coord;	double       d_x2coord,  d_y2coord;		
	double     	d_x3coord,  d_y3coord;	double       d_x4coord,  d_y4coord;	
	double      d_lastdist;
	bool                      rispostaconferma;
	
	bool       inGriglia;
    bool       AutorizzatoDatiSensibili;
	
	NSMutableArray *ListaEditvt;

		// Raster
	NSMutableArray *ListaRaster;
	DisegnoR       *DisRcorrente;
    int             indiceRasterCorrente;
		// Vettoriale
	NSMutableArray *ListaVector;
	NSMutableArray *ListaDefSimboli;
	DisegnoV       *DisVcorrente;
    int             indiceVectorCorrente;
	NSMutableArray *ListaSelezionati;
	NSMutableArray *ListaInformati;
	NSMutableArray *ListaSelezEdifici;
	NSMutableArray *ListaSelezTerreni;
	NSMutableArray *Listaproprietari;
	NSMutableArray *ListaproprietariFiltrata;

		// Vector
	double     xcentrorot; 
	double     ycentrorot;
	double     xcentrorotV; 
	double     ycentrorotV;
	
	int        indicecurrentsimbolo;
	
	Immobili  * TuttiImmobili;
	Immobili  * TuttiImmobiliFiltrati;

	Tax     * TuttaTax;
	Tax     * TuttaTaxFiltrata;
	
    Anagrafe  * anagrafe;

    
    NSString  * Dir_Catastali;
	NSString  * COD_Comune;
	NSString  * Dir_basedati;
	NSString  * NomeFileImmobiliCatOrmap;

	
	
	double     x1virt; 	double       y1virt;	
	double     x2virt; 	double       y2virt;
	double     d_xcoordLast, d_ycoordLast;

	NSString       * VersioneImmobili;
	NSString       * CodiceComune;
	NSString       * nomecomune;
	
	int           indiceinformato;

	NSMutableArray *IconeEdificiLista;

    NSString * nomequadronione;

	bool    giacaricatoCat;
	bool    intematerreni ;

	Polilinea  * rettangoloStampa;

}

- (BarileDlg   *) bariledlg;
- (BarileCtr   *) barilectr;


- (Interface   *) interface;



- (void) InitVarbase  ;

- (NSUndoManager  *) MUndor;

- (void) setnomeQUnione : (NSString *) nome ;
- (void) setcod_comune  : (NSString *) nome ;
- (void) setdircatastali: (NSString *) nome ;
- (void) setdirbasedati : (NSString *) nome ;



- (void) caricaIconeEdifici;

- (int) IndiceSepresenteDisegno    : (NSString *) nomefile;

- (int) presenteDisegno            : (NSString *) nomefile;


- (int) IndiceSepresenteRaster     : (NSString *) nomefile;


- (void) AggiornaInterfaceComandoAzione ;
- (void) txtInterfaceComandoAzione:(NSString *) msg;


- (void) upinterfacevector       ;
- (void) upinterfaceraster       ;

	// su comando e fasecomnado

- (void) setcomando              : (NSInteger) com    ; 
- (void) setfasecomando          : (NSInteger) fascom ; 
- (void) setfasecomandopiu1; 
- (void) comando00               ; 


- (void) setcomandofasecomando   : (NSInteger) com    : (NSInteger ) fascom; 

- (NSInteger) comando            ; 

- (NSInteger) fasecomando        ; 

- (void) comandodabottone        : (NSInteger) com    ;    // proviene dai bottoni di Az

	// su comando e fasecomnado

- (void) passatogliinformati : (bool) modo : (int) indice;

- (DisegnoR *)  DisegnoRcorrente;
- (DisegnoV *)  DisegnoVcorrente;


- (void)     aggiornaslideCalRaster ;
- (void)     aggiornaslideCalVector ;

	// sulle liste dei raster
- (NSMutableArray *) Listaraster;
- (void)             RifareNomiRasPop;
- (void)             DoNomiRasPop;
- (void)             DoNomiSubRasPop;
- (void)             DoNomiVectorPop;
- (void)             DoNomiSubVectPop;
- (void)             RimuovituttiRasters;

- (void)             AggiornaParametriListeRaster;


- (void)             setrastercorrente : (int) indice;
- (int)              indiceRasterCorrente;
- (void)             setindiceRasterCorrente   : (int) indice;
- (NSView*)          ViewRasterino;
- (NSView*)          ViewVettorino;
- (void)             RimuovituttiVettoriali;

- (void)             setindsimbcorrente        : (int) indice;
- (int)              indicecurrentsimbolo;

	// raffinamento cal raster
- (void)             SetupminMaxRotCen   : (bool) seup  minmax : (bool) seminimo rotsca : (bool) serot;
- (void)             Set0SlRotScaXYRas   : (int) slind ;
- (void)             SetMinMaxSlRas      : (int) slind :(bool) condup;



- (void)             Set0SlRotScaXYVet   : (int) slind ;
- (void)             SetMinMaxSlVet      : (int) slind :(bool) condup;


- (void)             updateInfoPanel;


	//  Vector
- (NSMutableArray *) ListaVector;
- (int)              indiceVectorCorrente;
- (void)             setindiceVectorCorrente   : (int) indice;
- (void)             CambioSubVector           : (int) indice; 
- (void)             CambioVector              : (int) indice;

- (void)             Disegnailpianino;
- (void)             paintboxcolorepiano;
- (void)             Disegnarasterino;


- (NSMutableArray *) ListaDefSimboli;

- (NSMutableArray *) ListaSelezionati;
- (NSMutableArray *) ListaInformati;

- (NSMutableArray *) ListaSelezEdifici;
- (NSMutableArray *) ListaSelezTerreni;
- (NSMutableArray *) Listaproprietari;
- (NSMutableArray *) ListaproprietariFiltrata;

- (NSMutableArray *) ListaEditvt;



- (NSSegmentedControl *)  ESxcord;
- (NSSegmentedControl *)  ESycord;
- (NSSegmentedControl *)  ESFuso;
- (NSSegmentedControl *)  ESSnap;
- (NSTextField        *)  txtDimxyraster;
- (NSBox              *)  bcolPiano;
- (NSPanel            *)  dlcalRas;
- (NSPanel            *)  dlcalRasF;
- (NSPanel            *)  dlrighello;
- (NSTextField        *)  FieldAltezzaTesto;
- (NSTextField        *)  FieldTxtTesto;
- (NSView             *)  viewsimb;

- (void)     RimuoviSelezionatiDelDisegno :(DisegnoV *) Dis;


	// dlg di conferma

- (void)     updatedlgEdifici               : (int) indice;
- (void)     updatedlgTerreni               : (int) indice;


	// dati immobiliari

- (Immobili  *) TuttiImmobili;
- (Immobili  *) TuttiImmobiliFiltrati;

- (Tax     *) TuttaTax;
- (Tax     *) TuttaTaxFiltrata;


- (NSMutableArray *) ListTerreCatFoglio;
- (void)     MostraEdifInfo  ;
- (void)     MostraTerraInfo ;

- (int)      pianoDlgSelezionato;

- (IBAction) salvaListaProprietari   : (id)  sender;
- (void)     apriListaProprietari;

- (void)     apriImmobili;

- (void)     apriResidenti;

- (void)     apriTarsu;


- (NSString  *) Dir_Catastali;
- (NSString  *) COD_Comune;
- (NSString  *) Dir_basedati;
- (void)        SetNomeFileImmobiliCatOrmap : (NSString * ) nome;


- (void)     addstringaData   : (NSMutableData *) dat : (NSString *) str ;
- (void)     addstringaData2   : (NSMutableData *) dat : (NSString *) str;

- (NSString *) GetStringaData : (NSFileHandle  *) fileHandle ;
- (NSString *) GetStringaData2 : (NSData  *) data : (int *) pos ;


- (IBAction) alternasporcademo ;

- (int)      indiceinformato;
- (void)     setindiceInformato : (int) ind;

- (NSString *) nomequadronione;


- (NSArray  *) righetestofile : (NSString *) nomefile;

- (Anagrafe *) anagrafe;
- (void)       iniziarettangolostampa;
- (void)       setnilrettangolostampa;
- (Polilinea *) rettangoloStampa;

- (void)       caricaDatiCAT ;
- (void)       aprodatiSensibili ;
- (IBAction)   switchStatoDatiSensibili : (id)  sender; 


- (IBAction)  TestTogliCivicoTarsu   : (id) sender  ;

@property(nonatomic) double	xcentrorot;
@property(nonatomic) double	ycentrorot;
@property(nonatomic) double	xcentrorotV;
@property(nonatomic) double	ycentrorotV;
@property(nonatomic) bool 	rispostaconferma;

@property(nonatomic) double d_x1coord;
@property(nonatomic) double d_y1coord;
@property(nonatomic) double d_x2coord;
@property(nonatomic) double d_y2coord;		
@property(nonatomic) double	d_x3coord;
@property(nonatomic) double d_y3coord;
@property(nonatomic) double d_x4coord;
@property(nonatomic) double d_y4coord;	
@property(nonatomic) double d_lastdist;	

@property(nonatomic) double x1virt; 	
@property(nonatomic) double y1virt;	
@property(nonatomic) double x2virt; 	
@property(nonatomic) double y2virt;
@property(nonatomic) double d_xcoordLast;
@property(nonatomic) double d_ycoordLast;

@property(nonatomic) bool	inGriglia;
@property(nonatomic) bool	giacaricatoCat;
@property(nonatomic) bool	intematerreni;

@property(nonatomic) bool	AutorizzatoDatiSensibili;
@property(nonatomic) int 	TipoProiezione;




@end
