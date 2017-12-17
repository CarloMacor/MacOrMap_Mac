//
//  Progetto.h
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

	// #import <AppKit/AppKit.h>

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <WebKit/WebKit.h>
#import "googleno.h"
#import "Varbase.h"
#import "InfoObj.h"
#import "ComandiPro.h"
#import "ComandiToolBar.h"
#import "ProgDialogs.h"

	// #import "VirtLayer.h"

@interface Progetto : NSView {
	
	IBOutlet NSWindow    *  mainwindow;

	
	IBOutlet InfoObj                * LeInfo;
	IBOutlet Varbase                * varbase;
	IBOutlet ComandiPro             * comandiPro;
	IBOutlet ComandiToolBar         * comandiToolBar;
	IBOutlet ProgDialogs            * progdialogs;

	bool     InConfermaSoftware;
	NSString *VersioneSoftware;  // prima versione
	IBOutlet PDFView       *  _mypdf;
		// Google
	IBOutlet NSLevelIndicator     * Indicaframeloaded;
	IBOutlet WebView       *  _myweb;

	bool qualeweb;
	IBOutlet WebView       *  Testweb;
	IBOutlet NSSlider      * sliderGoogletime;

	IBOutlet NSView        * ViewContenitore;
	
	int              contaframeweb;
    int              contatuttiweb;
	int              Ultimoframeweb;

	CIImage *SfondoCIImage;
	IBOutlet NSTextField   *  oldDistdlgRighello;
	IBOutlet NSImageView   *  ImgViewerRaster;
	NSTrackingArea *trackingArea;
	googleno   *googleterreno;
	double      d_xclickdown ,  d_yclickdown;
	int         i_xmouselast ,  i_ymouselast;
	double      d_x5coord,  d_y5coord;	double       d_x6coord,  d_y6coord;		double      d_x7coord,  d_y7coord;	double       d_x8coord,  d_y8coord;
	bool        b_limitisetted;
		// pre zoom window
	long       l_xprezoomw; 	long       l_yprezoomw;	float      f_sprezoomw;
	NSInteger  FaseRegione;
	NSInteger  Lastcomando;
	bool       incomandotrasparente;
	NSInteger  LastComandotrasparente;
	NSInteger  LastFaseComandotrasparente;
	double     x1spazialevirt; 	double       y1spazialevirt;
	NSRect     _inrectPan;
    int        modoaperturavet;    // se 1 distingue catasto-utm
	bool       sfondobianco;
	NSRect     pageRect;
	bool       rettangoloStampaSingolo;
	int        NumPaginaInStampa;
		NSTimer   *googletimer;
		NSDate    *BaseDateGoogle;
	
	double     DealyGoogleWegGet;
}


@property(nonatomic) bool	rettangoloStampaSingolo;

- (bool) isRettangoloStampa;

- (IBAction) ChiusuraSoftware                   : (id)sender;

- (bool) ChiusuraSoftwareSuNome;


- (void) InitProgetto  ;

- (void) configurazioneDaFileEsterno;

- (IBAction )  vediBoxImmagini : (id) sender;
- (IBAction )  vediBoxDisegni  : (id) sender;



- (void) Disegna : (CGContextRef) hdc;
- (void) DisegnaSelezionati                 ;
- (void) DisegnaInformati                   ;
- (void) DisegnaListaSelezEdifici           ;
- (void) DisegnaListaSelezTerreni           ;
- (void) DisegnarettangoloStampa     ;
- (void) DisegnaRettangoloStampaVirtuale    : (double) x1   : (double) y1    : (double) x2    : (double) y2 ; 
- (void) DisegnaExtraStampa                 : (CGContextRef) hdc ;


- (void) updatescala:(int)modo;
- (void) apriprogetto;
- (void) ricordaposultimavista ;

- (int)  modoaperturavet;    // se 1 distingue catasto-utm

- (IBAction) SvuotaRasVet                   : (id)sender;



- (void)     chiusuracomandoprecedente;

// comandi di vista
- (IBAction) Vista_Zoompiu                  : (id)sender;
- (IBAction) Vista_Zoommeno                 : (id)sender;
- (IBAction) Vista_Pan                      : (id)sender;
- (IBAction) Vista_ZoomFinestra             : (id)sender;
- (IBAction) Vista_ZoomTutto                : (id)sender;
- (IBAction) Vista_ZoomUltima               : (id)sender;
- (IBAction) Vista_ZoomCentro               : (id)sender;


- (IBAction) ZoomAllRaster                  : (id)sender;
- (IBAction) ZoomLocRaster                  : (id)sender;
- (IBAction) ZoomDisegno                    : (id)sender;
- (IBAction) ZoomPianoCorrente              : (id)sender;
- (IBAction) ZoomAll                        : (id)sender;
- (void)     ZoomC                          :(double) newx:(double) newy;


- (void)     attivaComando                  : (NSInteger) _comando;

// Vettoriale

 
- (IBAction) cancellaultimovt               : (id)sender;

- (IBAction) comando_Righello               : (id)sender;

- (IBAction) setSfondoBianco               : (id)sender;

// edit



- (void) DisegnaVirtuale                    : (int) x1 : (int) y1 : (int) x2 : (int) y2  ;

- (void) DisegnaSplineVirtuale              : (int) x1 : (int) y1 ;  

- (void) DisegnaCerchioVirtuale             : (int) x1 : (int) y1 : (int) x2 : (int) y2  ;

- (void) DisegnaquadroVirtuale              : (int) x1 : (int) y1 : (int) x2 : (int) y2  ;

- (void) DisegnaPan                         :(double) dx  :(double) dy ;

- (bool) SnappaGriglia                      :(double) xc  :(double) yc;
- (void) DisegnaGriglia                     : (CGContextRef) hdc;


- (void) DisSpostaVirtuale                  :(double) x1 : (double) y1 : (double) xm : (double) ym; 
- (void) DisCopiaVirtuale                   :(double) x1 : (double) y1 : (double) xm : (double) ym; 
- (void) DisRuotaVirtuale                   :(double) x1 : (double) y1 : (double) xm : (double) ym; 
- (void) DisScalaVirtuale                   :(double) x1 : (double) y1 : (double) xm : (double) ym; 

- (void) DisSpostaDisegno                   :(double) x1 : (double) y1 : (double) xm : (double) ym; 
- (void) DisRuotaDisegno                    :(double) xc : (double) yc : (double) xm : (double) ym; 
- (void) DisScalaDisegno                    :(double) xc : (double) yc : (double) xm : (double) ym; 

- (void) DisSimbolovirtualeang              :(double) angrot;
- (void) DisSimbolovirtualesca              :(double) parscal;

- (void) DisTestoVirtuale                   :(double) xc : (double) yc : (double) sc : (double) ang;


- (void) DisDoppiaVirtual                   :(int)  modo : (double) xm : (double) ym;
- (void) dispallinispline;

- (void) ricordasfondo ;
- (void) ridisegnasfondo;
- (void) ridisegnasfondodxdy                :(double) dx : (double) dy;


	// il caso delle immagini satellitari

- (IBAction) MostraColoriperRaster          : (id)sender;
- (void)     colorrasterchanged :(NSColorPanel *) pancol;



- (IBAction) Google_updateweb               : (id)sender;
- (IBAction) Google_getwebimg               : (id)sender;
- (IBAction) Google_action                  : (id)sender;

- (IBAction) CambiaDelayWebGoole            : (id)sender;




- (IBAction) ComandoSpampaPdf               : (id)sender;

- (void)     SpampaPdf                      : (NSSavePanel *) sheet  returnCode:(int)code ;


- (IBAction) Intersezione2Poligoni  : (id)sender; 


- (googleno  *)  googleno;

- (IBAction) VediGooglevero                  : (id)sender; 
- (IBAction) VedoSliderGoogleMapsTime        : (id)sender;



@end
