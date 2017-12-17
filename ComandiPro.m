//
//  ComandiPro.m
//  MacOrMap
//
//  Created by Carlo Macor on 25/02/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "ComandiPro.h"
#import "funzioni.h"


@implementation ComandiPro

- (void)     initComandiPro                              {
	
}

- (void)     Match_conPt                                 {
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
		if ( [locdisvet Match_conPt : varbase.d_xcoordLast : varbase.d_ycoordLast ] )  { [varbase CambioVector:i];	 break;	}
	}
}

- (void)     CancellaVerticeSelezionato                  {
	if  ([varbase ListaEditvt].count<2) return;
	Vettoriale *objvector;
	objvector = [ [varbase ListaEditvt] objectAtIndex : 0 ];
    [objvector CancellaVerticeSelezionato :[varbase ListaEditvt]];
	[[[varbase MUndor] prepareWithInvocationTarget:objvector] EseguiBack];

}

- (void)     SpostaVerticeSelezionato                    :(double) newx:(double) newy  {
	Vettoriale *objvector;
    objvector = [ [varbase ListaEditvt] objectAtIndex : 0 ];
	[objvector SpostaVerticeSelezionato :[varbase ListaEditvt] : newx : newy]; //[varbase MUndor]];

	[[[varbase MUndor] prepareWithInvocationTarget:objvector] EseguiBack];

}

- (void)     InserisciVerticeSelezionato                 :(double) newx:(double) newy  {
	Vettoriale *objvector;
    objvector = [ [varbase ListaEditvt] objectAtIndex : 0 ];
	[objvector InserisciVerticeSelezionato :[varbase ListaEditvt] : newx : newy];
	[[[varbase MUndor] prepareWithInvocationTarget:objvector] EseguiBack];

}

- (void)     EditVerticeSelezionato                      :(double) newx:(double) newy  {
	Vettoriale *objvector;
    objvector = [ [varbase ListaEditvt] objectAtIndex : 0 ];
	[objvector EditVerticeSelezionato :[varbase ListaEditvt] : newx : newy];
}


- (void)     seleziona_conPt                             {
	[info update_offsetmirino];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
        [locdisvet seleziona_conPt : hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase ListaSelezionati]];
	}
}

- (void)     selezInfo_conPt                             {
	[[varbase ListaInformati]  removeAllObjects];
	[info update_offsetmirino];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
        [locdisvet seleziona_conPt : hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase ListaInformati]];
	}
}

- (void)     selezInfo_conPtInterno                      {
	[[varbase ListaInformati]  removeAllObjects];
	[info update_offsetmirino];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
		
		if (![locdisvet editabile]) {  continue;	}
        [locdisvet seleziona_conPtInterno : hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase ListaInformati]];
	}
}

- (void)     selezEdif_conPtInterno                      : (CGContextRef) hdc   {
	[[varbase ListaSelezEdifici]  removeAllObjects];
	[info update_offsetmirino];
		//	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
		[locdisvet selezionaEdif_conPtInterno : hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase ListaSelezEdifici]];
	}
		// [LayerVirtuale display];
		//	[LayerVirtuale  DisegnaListaSelezEdifici     : varbase  : LeInfo];
}

- (void)     selezTerra_conPtInterno                     : (CGContextRef) hdc   {
	[[varbase ListaSelezTerreni]  removeAllObjects];
	[info update_offsetmirino];
		//	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
		[locdisvet selezionaTerre_conPtInterno: hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase ListaSelezTerreni]];
	}
	
		//	[LayerVirtuale display];
		//	[LayerVirtuale  DisegnaListaSelezTerreni     : varbase  : LeInfo];
}

- (void)     SpostaSelezionati                           {
	if ([varbase ListaSelezionati].count<=0)	return;
	[[varbase MUndor] beginUndoGrouping ];
	Vettoriale *objvector;
	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		[objvector Sposta:(varbase.d_x2coord-varbase.d_x1coord) : (varbase.d_y2coord-varbase.d_y1coord) ];
		[[[varbase MUndor] prepareWithInvocationTarget:objvector] Sposta:-(varbase.d_x2coord-varbase.d_x1coord) : -(varbase.d_y2coord-varbase.d_y1coord)];

	}
	objvector=nil;
	[[varbase MUndor] endUndoGrouping ];
}

- (void)     CopiaSelezionati                            {
	if ([varbase ListaSelezionati].count<=0)	return;
	[[varbase MUndor] beginUndoGrouping ];

	Vettoriale *objvector;
	Vettoriale *Copiedobjvector;

	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		Copiedobjvector = [objvector Copia:(varbase.d_x2coord-varbase.d_x1coord) : (varbase.d_y2coord-varbase.d_y1coord)   ];
		[[[varbase MUndor] prepareWithInvocationTarget:objvector] cancella];
	}
	objvector=nil;
	[[varbase MUndor] endUndoGrouping ];

}

- (void)     RuotaSelezionati                            {
	if ([varbase ListaSelezionati].count<=0)	return;
	[[varbase MUndor] beginUndoGrouping ];

	double angrot;	double dx,dy;
	dx = varbase.d_x2coord-varbase.d_x1coord;	dy = varbase.d_y2coord-varbase.d_y1coord; 
	if ((dx==0)  & (dy==0)) return;
	if (dx==0) { angrot = M_PI/2;             if (dy<0) angrot += M_PI;  } else 
	{ angrot = atan( dy / dx );    if (dx<0) angrot = M_PI+angrot; if (angrot<0) angrot += 2*M_PI;	}
	Vettoriale *objvector;
	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		[objvector Ruota:varbase.d_x1coord :varbase.d_y1coord :angrot ]; 
		[[[varbase MUndor] prepareWithInvocationTarget:objvector] Ruota:varbase.d_x1coord :varbase.d_y1coord :-angrot ];
	}
	[[varbase MUndor] endUndoGrouping ];
}

- (void)     ScalaSelezionati                            {
	if ([varbase ListaSelezionati].count<=0)	return;
	[[varbase MUndor] beginUndoGrouping ];
    double scal;         double dx,dy,dd;
	dx = varbase.d_x2coord-varbase.d_x1coord;	dy = varbase.d_y2coord-varbase.d_y1coord; 
    dd = hypot(dx, dy);
	if (dd==0) return;
	dd   = (dd / [info scalaVista]);
	scal = (dd / [info dimyVista])*10;
	Vettoriale *objvector;
	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		[objvector Scala:varbase.d_x1coord :varbase.d_y1coord :scal ]; 
		[[[varbase MUndor] prepareWithInvocationTarget:objvector]  Scala:varbase.d_x1coord :varbase.d_y1coord :1/scal ];

	}
	[[varbase MUndor] endUndoGrouping ];
}

- (bool)     selezionaVtconPt                            {
	[[varbase ListaEditvt] removeAllObjects];
	bool locres=NO;
	[info update_offsetmirino];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
		if ([locdisvet selezionaVtconPt : hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase ListaEditvt]]) { locres=YES; break; }
	}
	return locres;
}

- (bool)     selezionaVtspconPt                          {
	[[varbase ListaEditvt] removeAllObjects];
    bool locres=NO;
	[info update_offsetmirino];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
		if ([locdisvet selezionaVtspconPt : hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase ListaEditvt]]) { locres=YES; break; }
	}
	return locres;
}

- (void)     deseleziona                                 { 
	[[varbase ListaSelezionati] removeAllObjects];
}




- (DisegnoV *) ExecPol1 : (bool) inFasetest :(Polilinea *) P1 : (Polilinea *) P2       {
	
	if (!inFasetest) return nil;
	
	int IndDisVirtual = -1; 
	DisegnoV *diswork= nil;

	Piano * piano1, *piano2, *piano3,*pianoextra;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		diswork = [[varbase ListaVector] objectAtIndex:i];
		if ([[diswork nomedisegno] isEqualToString: @"Virtual"]) { IndDisVirtual=i; break; }
	}
	if (IndDisVirtual<0) {	// qui caricare forzatamente il disegno
		diswork = [DisegnoV  alloc];    
		[diswork InitDisegno:info];
		[[varbase ListaVector] addObject:diswork]; 
		[diswork setpianocorrente:0];
		[diswork setnomedisegno:	@"Virtual"];
		[varbase DoNomiVectorPop];
		IndDisVirtual = [varbase ListaVector].count-1;
	}
	[varbase CambioVector : IndDisVirtual];
	
	NSString * newnomepianoint = [[NSString alloc] initWithFormat:@"%@***%@",[[P1 piano] givemenomepiano],[[P2 piano] givemenomepiano]];
	int  IndPianoPolRisulta =  [[varbase DisegnoVcorrente]	indicePianoconNome : newnomepianoint];
	if (IndPianoPolRisulta<0) {
		[[varbase DisegnoVcorrente]  addLayerCorrente:newnomepianoint];
		IndPianoPolRisulta = [[varbase DisegnoVcorrente] damminumpiani]-1;
	} else [[varbase DisegnoVcorrente] setpianocorrente:IndPianoPolRisulta];
	[[varbase DisegnoVcorrente]   setcolorepianorgb:IndPianoPolRisulta: 1.0 : 1.0 : 0.0];
	[varbase DoNomiVectorPop];
	
	if (inFasetest)   {
		
		[[varbase DisegnoVcorrente]  addLayerCorrente:@"P1"];
		piano1 = [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:([[varbase DisegnoVcorrente] damminumpiani]-1)];
		[[varbase DisegnoVcorrente]  addLayerCorrente:@"P2"];
		piano2 = [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:([[varbase DisegnoVcorrente] damminumpiani]-1)];
		[[varbase DisegnoVcorrente]  addLayerCorrente:@"PCostruito"];
		piano3 = [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:([[varbase DisegnoVcorrente] damminumpiani]-1)];
		[[varbase DisegnoVcorrente]  addLayerCorrente:@"PExtra"];
		pianoextra = [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:([[varbase DisegnoVcorrente] damminumpiani]-1)];
		
		[piano1 setcolorpianorgb:0.2 :0.2 :1.0];
		[piano2 setcolorpianorgb:0.8 :0.2 :1.0];
		[piano3 setcolorpianorgb:0.8 :0.1 :0.0];
		[pianoextra setcolorpianorgb:0.5 :0.5 :0.5];
        [piano1 setalphasup:0.5];
        [piano2 setalphasup:0.5];
		[piano3 setalphasup:0.5];
		[varbase DoNomiVectorPop];
	}
	return diswork;
}

- (void)       ExecPol2 : (bool) inFasetest :(Polilinea *) P1 : (Polilinea *) P2  : (DisegnoV *) diswork     {
	[P1 chiudiconVtDown];	[P2 chiudiconVtDown];
	if ([P1 superficieconsegno]<0) [P1 rigiraspezzataTotale];
	if ([P2 superficieconsegno]<0) [P2 rigiraspezzataTotale];
	[P1 togliVtDoppi];	    [P2 togliVtDoppi];
	[P1 addvicini:P2];		[P2 addvicini:P1];
		// qui riporto le due P1 e P2 su piano di controllo
		// da usare solo per test estremi dato che introduce altre poly 
/*    if (inFasetest)   {	 Piano * piano1, *piano2;
	 piano1 = [[diswork ListaPiani] objectAtIndex:2];	 piano2 = [[diswork ListaPiani] objectAtIndex:3];
	 [[piano1 Listavector] addObject:P1];	 [[piano2 Listavector] addObject:P2];
    }
 */
	[P1 togliVtDoppi];	    [P2 togliVtDoppi];
	[P1 chiudiconVtDown];	[P2 chiudiconVtDown];
}

- (void)       ExecPol3 : (bool) inFasetest :(Polilinea *) P1 : (Polilinea *) P2 : (DisegnoV *) diswork : (CGContextRef) hdc {
	NSMutableArray * momIntersListInter = [[NSMutableArray alloc] init];
	Vertice * V1 ,*V2, *V3, *V4 ,*Vint;	
	double xint;		double yint;
	for (int i=1; i<[P1 Spezzata].count; i++) {
		V1 = [[P1 Spezzata] objectAtIndex:i-1];			V2 = [[P1 Spezzata] objectAtIndex:i];
		[momIntersListInter removeAllObjects];
		for (int j=1; j<[P2 Spezzata].count; j++)	{
			V3 = [[P2 Spezzata] objectAtIndex:j-1];	       V4 = [[P2 Spezzata] objectAtIndex:j];
			int res = intersezione  ([V1 xpos] ,[V1 ypos] ,[V2 xpos] ,[V2 ypos] , [V3 xpos] ,[V3 ypos] ,[V4 xpos] ,[V4 ypos] ,&xint , &yint   );
			if (res>0) { 
				if (inFasetest)   {
				    [diswork setpianocorrente:4];
				    [[varbase DisegnoVcorrente] faicerchio:hdc :xint :yint :xint+1 :yint+1 : [varbase MUndor]];
				}  
				Vint = [Vertice alloc]; [Vint InitVertice:xint :yint]; 	
				[ [P2 Spezzata]  insertObject:Vint atIndex:j];  j++; // spostiamoci di uno visto che ho inserito; inserisco qui in P2 ma poi reinserico l'intersezione anche in P1
				[momIntersListInter addObject:Vint]; 
			}
		}
			// riusare la lista delle mom inters per apliare P1;
	    while (momIntersListInter.count>0) {
			int candidato =0; double distaVtmin; double distaVt;
			Vint = [momIntersListInter objectAtIndex:0];
			distaVtmin = distsemplicefunz([V1 xpos] , [V1 ypos], [Vint xpos], [Vint ypos]);
			for (int j=1; j<momIntersListInter.count; j++)	{
				Vint = [momIntersListInter objectAtIndex:j];
				distaVt = distsemplicefunz([V1 xpos] , [V1 ypos], [Vint xpos], [Vint ypos]);
				if (distaVt<distaVtmin) { distaVtmin = distaVt; candidato = j; }
			} 
			Vint = [momIntersListInter objectAtIndex:candidato];
			if (inFasetest)   {
				[diswork setpianocorrente:3];
				[[varbase DisegnoVcorrente] faicerchio:hdc :xint :yint :xint+1.2 :yint+1.2 : [varbase MUndor]];
			}  
			[ [P1 Spezzata]  insertObject:Vint atIndex:i];  i++; // spostiamoci di uno visto che ho inserito
			[momIntersListInter removeObjectAtIndex:candidato];  // sfrondo la lista delle mominters
		}
	} // i <P1.spezzata
	
	[P1 togliVtDoppi];	    [P2 togliVtDoppi];
	[P1 chiudiconVtDown];	[P2 chiudiconVtDown];
	
}

- (void)       ExecPol4 : (bool) inFasetest :(Polilinea *) P1 : (Polilinea *) P2 : (DisegnoV *) diswork : (CGContextRef) hdc {
	Vertice * V1 ;	
	if (!inFasetest) return;
	// della P1 e P2 metto la numerazione attuale dei vertici
	if (NO) {	[diswork setpianocorrente:1];
		for (int i=1; i<[P1 Spezzata].count; i++) {	V1 = [[P1 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 1 : 0 :[NSString stringWithFormat: @"-%d",i ]: [varbase MUndor]]; 	}		
				[diswork setpianocorrente:2];
		for (int i=1; i<[P2 Spezzata].count; i++) {	V1 = [[P2 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 2 : 0 :[NSString stringWithFormat: @"+%d",i ]: [varbase MUndor]]; 	}		

	//  della P1   * al Bordo di P2     I interno alla P2    E esterno alla P2
		 [diswork setpianocorrente:0];
		 for (int i=1; i<[P1 Spezzata].count; i++) {	V1 = [[P1 Spezzata] objectAtIndex:i];
		   if ([P2 ptBordo : [V1 xpos] : [V1 ypos]]) {
		   [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 3 : 0 :[NSString stringWithFormat: @"b" ]: [varbase MUndor]]; 			
		  } else {
		   if ([P2 ptInterno : [V1 xpos]: [V1 ypos]]) 
		   [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 3 : 0 :[NSString stringWithFormat: @"I" ]: [varbase MUndor]]; 			
		    else [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 3 : 0 :[NSString stringWithFormat: @"E" ]: [varbase MUndor]]; 			
		  }
		 }
	//  della P2   (* al Bordo di P1 fatto sopra)     I interno alla P1    E esterno alla P1
		 [diswork setpianocorrente:4];
		 for (int i=1; i<[P2 Spezzata].count; i++) {	V1 = [[P2 Spezzata] objectAtIndex:i];
		   if ([P1 ptBordo : [V1 xpos] : [V1 ypos]]) {
				   //		   [[varbase DisegnoVcorrente] faicerchio:hdc : [V1 xpos] : [V1 ypos] :[V1 xpos]+2 : [V1 ypos]+2 : [varbase MUndor]]; 			
		 } else {
		   if ([P1 ptInterno : [V1 xpos]: [V1 ypos]]) 
		   [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 3 : 0 :[NSString stringWithFormat: @"I" ]: [varbase MUndor]]; 			
		 else [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 3 : 0 :[NSString stringWithFormat: @"E" ]: [varbase MUndor]]; 			
		  }
		 }
	}
	
}

- (bool)       ExecPol5 : (Polilinea *) P1  :(Polilinea *) P2 : (Polilinea *) Risulta  {
    Vertice * V1;
	bool tuttodentro =YES;
	for (int i=0; i<[P1 Spezzata].count; i++) {
		V1 = [[P1 Spezzata] objectAtIndex:i];
		if ([P2 ptBordo : [V1 xpos] : [V1 ypos]]) {	  tuttodentro =NO; break;	
			}
		else {	if (![P2 ptInterno : [V1 xpos]: [V1 ypos]]) { tuttodentro =NO;	break;} }	 
	}
	if (tuttodentro) {
	  for (int i=0; i<[P1 Spezzata].count; i++) { V1 = [[P1 Spezzata] objectAtIndex:i];
		  [Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	}
	}  // ritorna il poligono costruito
	return tuttodentro;
}

- (bool)       ExecPol6 : (Polilinea *) P1 : (Polilinea *) P2 {
	bool risulta=NO;	int IndStartInterno;
	Vertice * V1;
	for (int i=0; i<[P1 Spezzata].count; i++) {
		V1 = [[P1 Spezzata] objectAtIndex:i]; 
		if ([P2 ptBordo : [V1 xpos] : [V1 ypos]]) continue;
		if ([P2 ptInterno : [V1 xpos]: [V1 ypos]]) {IndStartInterno = i; risulta=YES; break;	} 
	}
	if (IndStartInterno==0) {
		for (int i=[P1 Spezzata].count-1; i>0; i--) {
			V1 = [[P1 Spezzata] objectAtIndex:i]; 
			if ([P2 ptBordo   : [V1 xpos] : [V1 ypos]]) break;
			if ([P2 ptInterno : [V1 xpos] : [V1 ypos]]) {IndStartInterno = i;	} else break;
		}
	}
	if (risulta) {	[P1 partedavtindice : IndStartInterno];	}
	return risulta;
}

- (void)       ExecPol7 : (bool) inFasetest :(Polilinea *) P1 : (DisegnoV *) diswork : (int) indSuBordoIniziale : (CGContextRef) hdc {
	Vertice * V1;
	if (inFasetest) 	{
		[diswork setpianocorrente:1];
		for (int i=indSuBordoIniziale+1; i<[P1 Spezzata].count; i++) {	V1 = [[P1 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 1 : 0 :[NSString stringWithFormat: @"%d-",i ]: [varbase MUndor]]; 	
		}	
		[diswork setpianocorrente:0];
	}	
	
}


- (void)       ExecPol12 : (bool) inFasetest : (Polilinea *) Risulta : (Polilinea *) P1 : (Polilinea *) P2 : (Vertice *) V1 :  (Vertice *) V2 : (CGContextRef) hdc  {
	
	Vertice *Vp;	
		// mettiamo G1 e G2 come riferimenti iniziali e finali del pezzo che costruiamo
	if (inFasetest)   [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] :3 : 0 :[NSString stringWithFormat: @"G1" ]: [varbase MUndor]];
	if (inFasetest)   [[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] :3 : 0 :[NSString stringWithFormat: @"G2" ]: [varbase MUndor]];
		// troviamo indice di partenza in P2
	for (int ki=0  ; ki<[P2 Spezzata].count; ki++) {
		Vp = [[P2 Spezzata ] objectAtIndex:ki];
		if (([Vp xpos]==[V1 xpos]) & ([Vp ypos]==[V1 ypos])) {	[P2 partedavtindice : ki];	break;	}
	}

	
		//	if ([Risulta numvt]>9) { [[varbase DisegnoVcorrente] faitesto  :hdc : [Vp xpos] : [Vp ypos] : 2 : 0 :[NSString stringWithFormat: @"ò%d",ki ]: [varbase MUndor]];  }

		 
	for (int ki=0  ; ki<[P2 Spezzata].count; ki++) {  // fino al G2 aggiungiamo elementi della P2
		Vp = [[P2 Spezzata ] objectAtIndex:ki];
		if (([Vp xpos]==[V2 xpos]) & ([Vp ypos]==[V2 ypos])) { break;  }
		
			//	if ([Risulta numvt]>9) { [[varbase DisegnoVcorrente] faitesto  :hdc : [Vp xpos] : [Vp ypos] : 1 : 0 :[NSString stringWithFormat: @"ò%d",ki ]: [varbase MUndor]];  }

			//	if (inFasetest)	  [[varbase DisegnoVcorrente] faitesto  :hdc : [Vp xpos] : [Vp ypos] : 2 : 0 :[NSString stringWithFormat: @"ò%d",ki ]: [varbase MUndor]]; 			
		
			// da considerarla come altrenativa		
			// if (([P1 ptInterno: [Vp xpos] : [Vp ypos]])  | ([P1 ptBordo: [Vp xpos] : [Vp ypos]] ) ) 	  [Risulta addvertex:[Vp xpos] :[Vp ypos] :0];	
		if ([P1 ptInterno: [Vp xpos] : [Vp ypos]]) 	{ [Risulta addvertex:[Vp xpos] :[Vp ypos] :0];	    }
	}

	
	
	[Risulta addvertex:[V2 xpos] :[V2 ypos] :0];	
	
} 

- (Polilinea *) ExecPolNoreciprociInterni : (Polilinea *) P1 : (Polilinea *) P2 : (CGContextRef) hdc  {

	Polilinea * Risulta=nil;	Risulta = [Polilinea alloc]; 	[Risulta InitPolilinea:YES];
	Vertice * V1, *V2; int starterP1=-1; int starterP2=-1;
	for (int i=0; i<[P1 numvt]; i++) {
		V1 = [[P1 Spezzata] objectAtIndex:i];
		for (int j=0; j<[P2 numvt]; j++) {
			V2 = [[P2 Spezzata] objectAtIndex:j];
			if (([V1 xpos]== [V2 xpos]) & ([V1 ypos]== [V2 ypos]) ) {
				starterP1=i; starterP2 = j;			break;	
			}
		}
		if (starterP1>=0) break;
	}
	if (starterP1<0) return nil;
	[P1 partedavtindice : starterP1];
	[P2 partedavtindice : starterP2];
	
	for (int i=1; i<[P1 Spezzata].count; i++) {	V1 = [[P1 Spezzata] objectAtIndex:i];
		[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : 1 : 0 :[NSString stringWithFormat: @"%d",i ]: [varbase MUndor]]; 	}		
	V1 = [[P1 Spezzata] objectAtIndex:0];	[Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	
	starterP1=1; starterP2=1;
	for (int i=1; i<[P1 numvt]; i++) {
 	  V1 = [[P1 Spezzata] objectAtIndex:i];
	  for (int j=starterP2; j<[P2 numvt]; j++) {
		V2 = [[P2 Spezzata] objectAtIndex:j];	
		  if (([V1 xpos]== [V2 xpos]) & ([V1 ypos]== [V2 ypos]) ) {
			  starterP2=j;
			  [Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	
			  break;	
		  }
      }
		
	}
	
	

	
	return Risulta;
}


- (Polilinea *)     Esecuzione2Poligoni  :(Polilinea *) P1 : (Polilinea *) P2  : (bool) costruisciImg {
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	NSMutableArray * ListaBordo    = [[NSMutableArray alloc] init];
	Polilinea * Risulta=nil;	Risulta = [Polilinea alloc]; 	[Risulta InitPolilinea:YES];

	
	
	bool inFasetest=NO;

	// si crea un disegno per introdurre la polilinea generata ma anche P1 e P2 
	// da usare solo per fare test della procedura altrimenti si risponda solo con la polilinea creata
	     DisegnoV *diswork = [self ExecPol1:inFasetest : P1 : P2 ];

	// sia P1 superfiice piu' piccola di P2 
	Polilinea * P3=nil;  if ([P2 superficie]<[P1 superficie]) { P3 = P1; P1=P2; P2=P3; }

		//  non vi siano aperture , snap vicino con inserimento   // eventualmente pone le due P1 e P2 ai piani di controllo per vederle dopo
	[self ExecPol2:inFasetest : P1 : P2 :diswork];

	// facciamo le intersezioni tra i due poligoni ... caso di Fasetest facciamo doppiocerchietto in fase intersezione
	[self ExecPol3:inFasetest : P1 : P2 :diswork:hdc];

		// solo disegni test   // numerazione vertici P1 e P2 -num e +num  // b I E per bordo Interno ed esterno allo altro poligono
    [self ExecPol4:inFasetest : P1 : P2 :diswork:hdc];

		// test di totale contenimento di P1 in P2
	if ([self ExecPol5 : P1 : P2 :Risulta]) { [self deseleziona]; 	 goto exitlabel; }
	
		// troviamo il primo punto interno di P1 in P2 e da li si parte
	Vertice  *V1interno=nil;  	
	if ([self ExecPol6 : P1 : P2]) { V1interno = [[P1 Spezzata] objectAtIndex:0]; 
	}
	else {
			//	NSLog(@"qui il caso in cui nessun pt P1 e' in P2");
			// tra le opportunita quello di scambiare P1 e P2 
		Polilinea * P3=nil;  P3 = P1; P1=P2; P2=P3;
		if ([self ExecPol6 : P1 : P2]) { V1interno = [[P1 Spezzata] objectAtIndex:0]; }
		else 
		{	// NSLog(@"Ma neanche un punto di P2 in P1");	
			[self deseleziona];
			Risulta = [self ExecPolNoreciprociInterni:P1 : P2 :hdc]; 	
            goto exitlabel;
		
		}  // invece trovare la soluzione nel caso abbiano in comune solo bordo
	}
	
	
	
	
	Vertice * V1 ,*V2, *Vp,*Vt;	
	
if (inFasetest) 
		//    1 e' il primo punto interno alla P2
	if (V1interno!=nil) {[[varbase DisegnoVcorrente] faitesto  :hdc : [V1interno xpos] : [V1interno ypos] :6 : 0 :[NSString stringWithFormat: @"1" ]: [varbase MUndor]]; }

	if (V1interno!=nil) {
		if (inFasetest) [diswork setpianocorrente:4];
		
// si Parte dal primo punto interno e questa prima parte conclude o ad esaurimento quindi fatto tutto il poligono oppure 
// 1 primo punto interno   b  sul bordo    i   interno		non appena il punto della P1 e' sul bordo della P2 si esce dal ciclo.

// introduco come primo punto il primo vertice interno fino al tornare sul bordo
	int indSuBordoIniziale=0;		bool sonosubordo = NO;
	{
		[Risulta addvertex:[V1interno xpos] :[V1interno ypos] :0];	
			// ora si cicla su tutti i Vt della P1 di cui il primo indice 0 gia inserito come V1interno
		for (int i=1; i<[P1 Spezzata].count; i++) {
		 V1 = [[P1 Spezzata] objectAtIndex:i]; 
		 if ([P2 ptBordo : [V1 xpos] : [V1 ypos]]) {
			 [Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	
		if (inFasetest)  [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] :3 : 0 :[NSString stringWithFormat: @"b" ]: [varbase MUndor]];
			 indSuBordoIniziale = i; sonosubordo = YES;
			 [ListaBordo addObject:V1];
			 break;
		 }
	     if ([P2 ptInterno : [V1 xpos]: [V1 ypos]]) {
			 [Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	
        if (inFasetest) { [diswork setpianocorrente:3];	
	                      [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] :3 : 0 :[NSString stringWithFormat: @"i" ]: [varbase MUndor]];
          }
		 }
				// se fino ad ultimo punto e' interno posso chiudere la procedura
			if (i==[P1 Spezzata].count-1) {	[ [varbase DisegnoVcorrente] chiudipoligono:hdc :[varbase MUndor]];	            goto exitlabel;	}
	    }
	}
		// per ora messi dal primo punto interno a tutti gli interni fino al bordo con primo vertice bordo compreso indicato con la b
// introduco come primo punto il primo vertice interno fino al tornare sul bordo -FINE-
		
		
	// sono sul bordo con la b e la ListaBordo ha un suo elemento proprio b indbordoiniziale e' indice di b e si partirta' da li
		
	// mettiamo i testi dal bordo appena trovato al termine della P1 solo per controllare
	[self  ExecPol7 : inFasetest : P1 : diswork :indSuBordoIniziale:hdc];

			// listabordo ne ha gia' uno che e' il primo vt di bordo prima di decidere se entrare uscire o rimanere su bordo.
      if (sonosubordo) {
			  //	  bool inattesadiritornosulbordo=NO;
		   bool	 allinternoconP1=NO;
		   bool	 allinternoconP2=NO;
			  //	  bool successivoP1BordoEstenoP2=NO;
		  for (int i=indSuBordoIniziale+1; i<[P1 Spezzata].count; i++) {
			  V1 = [[P1 Spezzata] objectAtIndex:i]; 
				  //			  if ([Risulta numvt]>9) {  NSLog(@"post %d",i); }
				  // cicliamo sulla rimanente spezzata ( sono partito dall'interno e sono arrivato al bordo ... da li sono partito
			  if ([P2 ptBordo1mm : [V1 xpos] : [V1 ypos]]) {  // se e' sul bordo aggiungerlo al bordo
				  [ListaBordo addObject:V1];
					  
				  if (allinternoconP1) { [Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	 allinternoconP1= NO;  }
				  if (allinternoconP2) { [Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	 allinternoconP2= NO;  }
			  }  // se e' sul bordo aggiungerlo al bordo
			  else {
				  if ([P2 ptInterno : [V1 xpos]: [V1 ypos]]) {  // utilizzare tutta la lista Bordo
					// se e' interno prima fai tutto il bordo e poi metti il pt interno
					// considerare che se sono due interni di seguito la lista bordo si e' annullata.
					  for (int j=1; j<[ListaBordo count]; j++) {
						  Vp = [ListaBordo objectAtIndex:j-1]; 			  V2 = [ListaBordo objectAtIndex:j]; 
							  // qui ritrovare i vt della P2 che coincidono con il segmento e controllare che non ci siano rientri od uscite (nel caso tutto ok)
						  for (int ki=0  ; ki<[P2 Spezzata].count; ki++) {
							  Vt = [[P2 Spezzata] objectAtIndex:ki]; 
							  if (([Vt xpos]==[Vp xpos]) & ([Vt ypos]==[Vp ypos]) ) {  [P2 partedavtindice : ki];  break;  }
						  }	 // la P2 e' iniziante con il stesso punto Vp
							 // ora se da Vp a V2 non ci sono rientri od uscite e' tutto ok
						  for (int ki=1  ; ki<[P2 Spezzata].count; ki++) {
							  Vt = [[P2 Spezzata] objectAtIndex:ki]; 
                              if ([P1 ptBordo : [Vt xpos] : [Vt ypos] ] )  { break;}
                              if ([P1 ptInterno : [Vt xpos] : [Vt ypos] ] )  {
								  [Risulta addvertex:[Vt xpos] :[Vt ypos] :0];	
if (inFasetest) 				  [[varbase DisegnoVcorrente] faitesto  :hdc : [Vt xpos] : [Vt ypos] :3 : 0 :[NSString stringWithFormat: @"#" ]: [varbase MUndor]];
							  } else break;
						  }
						  [Risulta addvertex:[V2 xpos] :[V2 ypos] :0];	
if (inFasetest) 	  [[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] :2 : 0 :[NSString stringWithFormat: @"ç%d",[Risulta numvt] ]: [varbase MUndor]];
							  //				  if ([Risulta numvt]>8) {  goto exitlabel;	   }
					  }
					  [Risulta addvertex:[V1 xpos] :[V1 ypos] :0];	
						  // H il punto interno dopo essere stato sul bordo					  
if (inFasetest) 					  [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] :3 : 0 :[NSString stringWithFormat: @"H" ]: [varbase MUndor]];
					  allinternoconP1=YES; allinternoconP2=NO;
					  [ListaBordo removeAllObjects];
				  } // se il successivo P1 e' interno a P2 allora usare tutta la lista bordo
					// H il punto interno dopo essere stato sul bordo
					// # il punto della P2 che e' interno alla P1 tra un bordo e l'altro
					// ç il punto sul bordo , ma poi sono passato all'interno
				  
				  else // potrei passare dal bordo all'esterno anziche interno come sopra.
				  { 
					  allinternoconP2=YES;  allinternoconP1=NO; // ovviamente metto a No la variabile di controllo di back sul bordo dall'interno P1 in P2
						  // V1 e' esterno a P2 e non e' su bordo
							// P1 esce dal P2 quindi P1 non costruisce ma costruisce P2 dall'ultimo bordo al rientro!
if (inFasetest) 					  [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] :3 : 0 :[NSString stringWithFormat: @"E" ]: [varbase MUndor]];
						  // cosa farne della frontiera?
						  // qui prima rifare tutto il percorso di bordo gia' fatto come sopra
						  // V1 sia ultimo bordo prima di uscire
					  bool SoloSuBordoP1= YES;
					  for (int j=1; j<[ListaBordo count]; j++) {
						  Vp = [ListaBordo objectAtIndex:j-1]; 			  V2 = [ListaBordo objectAtIndex:j]; 
							  // qui ritrovare i vt della P2 che coincidono con il segmento e controllare che non ci siano rientri od uscite (nel caso tutto ok)
						  for (int ki=0  ; ki<[P2 Spezzata].count; ki++) {
							  Vt = [[P2 Spezzata] objectAtIndex:ki]; 
							  if (([Vt xpos]==[Vp xpos]) & ([Vt ypos]==[Vp ypos]) ) {  [P2 partedavtindice : ki];  break;  }
						  }	 // la P2 e' iniziante con il stesso punto Vp
							 // ora se da Vp a V2 non ci sono rientri od uscite e' tutto ok
						  for (int ki=1  ; ki<[P2 Spezzata].count; ki++) {
							  Vt = [[P2 Spezzata] objectAtIndex:ki]; 
                              if ([P1 ptBordo : [Vt xpos] : [Vt ypos] ] )  { break;}
                              if ([P1 ptInterno : [Vt xpos] : [Vt ypos] ] )  {
								  [Risulta addvertex:[Vt xpos] :[Vt ypos] :0];	
if (inFasetest) 	  [[varbase DisegnoVcorrente] faitesto  :hdc : [Vt xpos] : [Vt ypos] :3 : 0 :[NSString stringWithFormat: @"§" ]: [varbase MUndor]];
								  SoloSuBordoP1= NO;
							  } else break;
						  }
						  if (SoloSuBordoP1) {
							  [Risulta addvertex:[V2 xpos] :[V2 ypos] :0];	
if (inFasetest) 	  [[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] :3 : 0 :[NSString stringWithFormat: @"*" ]: [varbase MUndor]];
						  }
					  }
						  //		  [[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] :3 : 0 :[NSString stringWithFormat: @"H" ]: [varbase MUndor]];
					  V1 = [ListaBordo objectAtIndex:[ListaBordo count]-1];
						  // ora trovare il ritorno su bordo
					  for (int ki=i  ; ki<[P1 Spezzata].count; ki++) {
						  V2 = [[P1 Spezzata] objectAtIndex:ki]; 
							  //						  if ([P2 ptBordo : [V2 xpos] : [V2 ypos]]) { i = ki+1; break; }
						  if ([P2 ptBordo : [V2 xpos] : [V2 ypos]]) { i = ki; break; }
					  }	
						  // 	da G1 a G2 metto tutti i punti della P2 interni alla P1		
					  
				  
					  

					  [self  ExecPol12 : inFasetest : Risulta : P1 : P2 : V1 : V2 :hdc];
					  // svuoto la listabordo ma riaggiungo ultimo elemento
					  [ListaBordo removeAllObjects];   [ListaBordo addObject:V2];
						  //	  NSLog(@"qui %d",[Risulta numvt]);
						  //					  goto exitlabel;
					  
				  } // sono passato all'esterno
			  } // V1 non e' bordo di P2
		  } // ciclo i su indSuBordoIniziale+1  
	  }  // test sonosubordo - FINE-
		else {
			NSLog(@"Sorry non ero sul bordo");
		}

		
		
	}  // v1interno quindi parto da punto interno // FINE
	   // se non vi e' punto interno allora o tutto sul bordo o tutto esterno
	
	exitlabel : 	

	if (costruisciImg & (Risulta!=nil)) {
		int IndDisVirtual = -1; 
		DisegnoV *locdis;
		for (int i=0; i<[varbase ListaVector].count; i++) {  
			locdis = [[varbase ListaVector] objectAtIndex:i];
			if ([[locdis nomedisegno] isEqualToString: @"Virtual"]) { IndDisVirtual=i; break; }		}
		if (IndDisVirtual<0) {	// qui caricare forzatamente il disegno
			locdis = [DisegnoV  alloc];    
			[locdis InitDisegno:info];
			[[varbase ListaVector] addObject:locdis]; 
			[locdis setpianocorrente:0];
			[locdis setnomedisegno:	@"Virtual"];
			[varbase DoNomiVectorPop];
			IndDisVirtual = [varbase ListaVector].count-1;		}
		[varbase CambioVector : IndDisVirtual];
		
		NSString * newnomepianoint = [[NSString alloc] initWithFormat:@"%@***%@",[[P1 piano] givemenomepiano],[[P2 piano] givemenomepiano]];
		int  IndPianoPolRisulta =  [[varbase DisegnoVcorrente]	indicePianoconNome : newnomepianoint];
		if (IndPianoPolRisulta<0) {
			[[varbase DisegnoVcorrente]  addLayerCorrente:newnomepianoint];
			IndPianoPolRisulta = [[varbase DisegnoVcorrente] damminumpiani]-1;
		} else [[varbase DisegnoVcorrente] setpianocorrente:IndPianoPolRisulta];
		[[varbase DisegnoVcorrente]   setcolorepianorgb:IndPianoPolRisulta: 1.0 : 1.0 : 0.0];
		[varbase DoNomiVectorPop];
		
		DisegnoV *diswork = [varbase DisegnoVcorrente];
		Piano    *piawork = [[diswork ListaPiani] objectAtIndex:IndPianoPolRisulta];
		[Risulta  Init: diswork : piawork ];
		[[piawork Listavector] addObject:Risulta];
		[diswork faiLimiti];
	}

	
	[diswork faiLimiti];
	[self deseleziona];
	return Risulta;
}



- (void)     Intersezione2Poligoni                       {

	if ([[varbase ListaSelezionati] count]!=2) {
		[self deseleziona];  NSBeep(); return;
	}
	
	Polilinea * P1=nil;	Polilinea * P2=nil; 
	{
		Vettoriale *locobj;
		for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
			locobj= [[varbase ListaSelezionati] objectAtIndex:i];
			
				//			NSLog(@"TT %d",[locobj dimmitipo]);
			
			if ([locobj dimmitipo] ==3 ) {
				if (P1==nil) {  P1 = [[[varbase ListaSelezionati] objectAtIndex:i] copiaPuraPrimoPoligono] ;} 
				        else {  P2 = [[[varbase ListaSelezionati] objectAtIndex:i] copiaPuraPrimoPoligono] ; break;}			
			}
		}
		if (P1==nil) {	[self deseleziona];   return;	} //else { NSLog(@"P1 numvt :  %d ",[P1 numvt]);	}
		if (P2==nil) {	[self deseleziona];   return;	} //else { [P2 numvt]);	}
	}		
	
	Polilinea * polbuild =	[self Esecuzione2Poligoni:P1:P2:NO];	
	if (polbuild==nil) return;
		// creazione del disegno Virtual
	{
		int IndDisVirtual = -1; 
		DisegnoV *locdis;
		for (int i=0; i<[varbase ListaVector].count; i++) {  
			locdis = [[varbase ListaVector] objectAtIndex:i];
			if ([[locdis nomedisegno] isEqualToString: @"Virtual"]) { IndDisVirtual=i; break; }		}
		if (IndDisVirtual<0) {	// qui caricare forzatamente il disegno
			locdis = [DisegnoV  alloc];    
			[locdis InitDisegno:info];
			[[varbase ListaVector] addObject:locdis]; 
			[locdis setpianocorrente:0];
			[locdis setnomedisegno:	@"Virtual"];
			[varbase DoNomiVectorPop];
			IndDisVirtual = [varbase ListaVector].count-1;		}
		[varbase CambioVector : IndDisVirtual];

		NSString * newnomepianoint = [[NSString alloc] initWithFormat:@"%@***%@",[[P1 piano] givemenomepiano],[[P2 piano] givemenomepiano]];
		int  IndPianoPolRisulta =  [[varbase DisegnoVcorrente]	indicePianoconNome : newnomepianoint];
		if (IndPianoPolRisulta<0) {
			[[varbase DisegnoVcorrente]  addLayerCorrente:newnomepianoint];
			IndPianoPolRisulta = [[varbase DisegnoVcorrente] damminumpiani]-1;
		} else [[varbase DisegnoVcorrente] setpianocorrente:IndPianoPolRisulta];
		[[varbase DisegnoVcorrente]   setcolorepianorgb:IndPianoPolRisulta: 1.0 : 1.0 : 0.0];
		[varbase DoNomiVectorPop];
		
		DisegnoV *diswork = [varbase DisegnoVcorrente];
		Piano    *piawork = [[diswork ListaPiani] objectAtIndex:IndPianoPolRisulta];
		[polbuild  Init: diswork : piawork ];
		[[piawork Listavector] addObject:polbuild];
		[diswork faiLimiti];

	}
	
	return;
	
	NSMutableArray * ListaIntersezioni    = [[NSMutableArray alloc] init];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	int IndDisVirtual = -1; 
  	bool tuttoon =NO;	double htP1 = 1.0; 	double htP2 = 1.0; 
	DisegnoV *locdis;
	Vettoriale *locobj; 	Vertice    * V1;  Vertice    * V2;	
	                        Vertice    * V3;  Vertice    * V4;  
	                        Vertice   *Vint;  Vertice  *Vint1;  
	                        Vertice  *Vint2;  Vertice  *lastBordo;
	bool iniziatoPol = NO;
	double xint;		double yint;

	
	bool disegnoPuntiInt = NO;	bool disegnoTxtP1    = NO;	bool disegnoTxtP2    = NO;	bool disptint2       = NO; 	bool mettitestosulleintersezioni = NO;
	if (tuttoon) {
		disegnoPuntiInt = YES;		disegnoTxtP1    = YES;		disegnoTxtP2    = YES;		disptint2       = YES;		mettitestosulleintersezioni = YES;
	}
	
	[varbase comando00];

	if ([varbase ListaSelezionati].count!=2) {  NSBeep(); [self deseleziona ];  return;   }
	// creazione del disegno Virtual
	{
	 for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdis = [[varbase ListaVector] objectAtIndex:i];
		if ([[locdis nomedisegno] isEqualToString: @"Virtual"]) { IndDisVirtual=i; break; }
	 }
	 if (IndDisVirtual<0) {	// qui caricare forzatamente il disegno
		locdis = [DisegnoV  alloc];    
		[locdis InitDisegno:info];
		[[varbase ListaVector] addObject:locdis]; 
		[locdis setpianocorrente:0];
        [locdis setnomedisegno:	@"Virtual"];
		[varbase DoNomiVectorPop];
		IndDisVirtual = [varbase ListaVector].count-1;
	 }
	 [varbase CambioVector : IndDisVirtual];
	}
	
		// creazione delle copie dei 2 poligoni da intersecare tra loro mettendoli in P1 e P2
		//	Polilinea * P1=nil;	Polilinea * P2=nil; 
	Polilinea * P3=nil;  Polilinea * locPdaCopiare;
	{
	  for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		locobj= [[varbase ListaSelezionati] objectAtIndex:i];
		if ([locobj dimmitipo] ==3 ) {
			if (P1==nil) { locPdaCopiare = [[varbase ListaSelezionati] objectAtIndex:i]; P1 = [locPdaCopiare copiaPuraPrimoPoligono] ;} 
			else { locPdaCopiare = [[varbase ListaSelezionati] objectAtIndex:i]; P2 = [locPdaCopiare copiaPuraPrimoPoligono] ; break;}			
		}
	}
	  if (P1==nil) {	[self deseleziona];   return;	} //else { NSLog(@"P1 numvt :  %d ",[P1 numvt]);	}
	  if (P2==nil) {	[self deseleziona];   return;	} //else { [P2 numvt]);	}
	  [P1 togliVtDoppi];	[P2 togliVtDoppi];
 	  [P1 chiudiconVtDown];	[P2 chiudiconVtDown];

	  if ([P1 superficieconsegno]<0) [P1 rigiraspezzataTotale];
	  if ([P2 superficieconsegno]<0) [P2 rigiraspezzataTotale];
  	  [P1 togliVtDoppi];	[P2 togliVtDoppi];
	  [P1 chiudiconVtDown];	[P2 chiudiconVtDown];

			//	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 0.0, 1.0 ); CGContextSetRGBFillColor   (hdc, 1.0, 1.0, 0.0, 0.1 );
			//	[P1 Disegna:hdc :info];	[P2 Disegna:hdc :info];
	}	
	
		// imposta nuovo piano per mettere il poligono di intersezione
	{
	 NSString * newnomepianoint = [[NSString alloc] initWithFormat:@"%@***%@",[[P1 piano] givemenomepiano],[[P2 piano] givemenomepiano]];
	 int  IndPianoPolRisulta =  [[varbase DisegnoVcorrente]	indicePianoconNome : newnomepianoint];
	 if (IndPianoPolRisulta<0) {
		[[varbase DisegnoVcorrente]  addLayerCorrente:newnomepianoint];
		IndPianoPolRisulta = [[varbase DisegnoVcorrente] damminumpiani]-1;
	 } else [[varbase DisegnoVcorrente] setpianocorrente:IndPianoPolRisulta];
	 [[varbase DisegnoVcorrente]   setcolorepianorgb:IndPianoPolRisulta: 1.0 : 1.0 : 0.0];
	 [varbase DoNomiVectorPop];
	}

	
	bool tuttodentro =YES;
	bool tuttofuori =YES;
	if ((P1==nil) | (P2==nil)) { return; }
	[P1 addvicini:P2];	[P2 addvicini:P1];	[P1 togliVtDoppi];	[P2 togliVtDoppi];  // si mettano i vertici anche quando sono molto vicini tra loro vertici con segmenti.
	
		//	Piano * pianoloc =   [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:1];		[[pianoloc Listavector] addObject:P1];	[[pianoloc Listavector] addObject:P2];
		//		 disegnoTxtP2=NO; // testo ai vertici di P2 +%d
	if (disegnoTxtP2) {
		for (int i=0; i<[P2 Spezzata].count; i++) {	V1 = [[P2 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP2 : 0 :[NSString stringWithFormat: @"+%d",i ]: [varbase MUndor]]; 	}		
	}
		//		 disegnoTxtP1 = NO;// testo ai vertici di P1 -%d
	if (disegnoTxtP1) {
		for (int i=0; i<[P1 Spezzata].count; i++) {	V1 = [[P1 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP1 : 0 :[NSString stringWithFormat: @"-%d",i ]: [varbase MUndor]]; 	}		
	}
	
	

	
	NSMutableArray * momIntersListInter = [[NSMutableArray alloc] init];
	// P1 e' il poligono piccolo che puo' essere contenuto in P2
	if ([P2 superficie]<[P1 superficie]) { P3 = P1; P1=P2; P2=P3; }
	
	
	// test di completo contenimento o completo esterno al secondo poligono;
    for (int i=0; i<[P1 Spezzata].count; i++) {
		V1 = [[P1 Spezzata] objectAtIndex:i];
		if (([P2 ptInterno : [V1 xpos]: [V1 ypos]]) | ([P2 ptBordo : [V1 xpos]: [V1 ypos]]) ) {tuttofuori = NO;  //  
			//				if ([P2 ptInterno : [V1 xpos]: [V1 ypos]]) {
			//					[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP2*2 : 0 :[NSString stringWithFormat: @"^%d",i ]: [varbase MUndor]];
			//				} else {[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP2*2 : 0 :[NSString stringWithFormat: @"#%d",i ]: [varbase MUndor]];	}
		} else {tuttodentro = NO;}
	}
		
	///   qui faccio le intersezioni e le aggiungo ai poligoni
    for (int i=1; i<[P1 Spezzata].count; i++) {
		V1 = [[P1 Spezzata] objectAtIndex:i-1];			V2 = [[P1 Spezzata] objectAtIndex:i];
		[momIntersListInter removeAllObjects];
		for (int j=1; j<[P2 Spezzata].count; j++)	{
			V3 = [[P2 Spezzata] objectAtIndex:j-1];	       V4 = [[P2 Spezzata] objectAtIndex:j];
			int res = intersezione  ([V1 xpos] ,[V1 ypos] ,[V2 xpos] ,[V2 ypos] , [V3 xpos] ,[V3 ypos] ,[V4 xpos] ,[V4 ypos] ,&xint , &yint   );
			if (res>0) { //  [[varbase DisegnoVcorrente] faipunto   :hdc : xint : yint : [varbase MUndor]];  
						 //	disegnoPuntiInt = YES;			if (  disegnoPuntiInt ) {  [[varbase DisegnoVcorrente] faicerchio:hdc :xint :yint :xint+1 :yint+1 : [varbase MUndor]];  }
				Vint = [Vertice alloc]; [Vint InitVertice:xint :yint]; 	
				[ [P2 Spezzata]  insertObject:Vint atIndex:j];  j++; // spostiamoci di uno visto che ho inserito; inserisco qui in P2 ma poi reinserico l'intersezione anche in P1
				[momIntersListInter addObject:Vint]; [ListaIntersezioni addObject:Vint];
			}
		}
				// riusare la lista delle mom inters per apliare P1;
	    while (momIntersListInter.count>0) {
		  int candidato =0; double distaVtmin; double distaVt;
		  Vint = [momIntersListInter objectAtIndex:0];
		  distaVtmin = distsemplicefunz([V1 xpos] , [V1 ypos], [Vint xpos], [Vint ypos]);
		  for (int j=1; j<momIntersListInter.count; j++)	{
			Vint = [momIntersListInter objectAtIndex:j];
			distaVt = distsemplicefunz([V1 xpos] , [V1 ypos], [Vint xpos], [Vint ypos]);
			if (distaVt<distaVtmin) { distaVtmin = distaVt; candidato = j; }
		  } 
		  Vint = [momIntersListInter objectAtIndex:candidato];
				//		  if (  disegnoPuntiInt ) {  [[varbase DisegnoVcorrente] faicerchio:hdc :[Vint xpos] :[Vint ypos] :[Vint xpos] +2 :[Vint ypos]+2 : [varbase MUndor]];  }
		  [ [P1 Spezzata]  insertObject:Vint atIndex:i];  i++; // spostiamoci di uno visto che ho inserito
			[momIntersListInter removeObjectAtIndex:candidato];  // sfrondo la lista delle mominters
		}
	} // i <P1.spezzata
	
	// in questo momneto abbiamo P1 e P2 che sono implementate delle intersezioni e conosciamo anche la lista delle intersezioni : ListaIntersezioni
	
		// se e' tuttofuori o tutto dentro fare il poligono  , ma le intersezioni sono 0 altrimenti e' da fare come un qualsiasi altro poligono
	if (tuttofuori  & ([ListaIntersezioni count]==0) ) {[self deseleziona ]; return;}
	if (tuttodentro  & ([ListaIntersezioni count]==0) ) {  // attenzione !!! potrebbe essere tutto dentro e poi intersecare piu' volte il bordo passando da dentro a dentro
		for (int i=0; i<[P1 Spezzata].count; i++) {
			V1 = [[P1 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faipoligono:hdc : [V1 xpos] : [V1 ypos]  : [varbase fasecomando]];   [varbase setfasecomandopiu1]; 
		}
		[self deseleziona];
		return;
	}
	
		// togliamo i doppi vertici susseguenti ai poligoni
	
		//			disegnoTxtP2=YES; // testo ai vertici di P2 +%d
	if (disegnoTxtP2) {
		for (int i=0; i<[P2 Spezzata].count; i++) {	V1 = [[P2 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP2 : 0 :[NSString stringWithFormat: @"+%d",i ]: [varbase MUndor]]; 	}		
	}
//					 disegnoTxtP1 = YES;// testo ai vertici di P1 -%d
	if (disegnoTxtP1) {
		for (int i=0; i<[P1 Spezzata].count; i++) {	V1 = [[P1 Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP1*3 : 0 :[NSString stringWithFormat: @"-%d",i ]: [varbase MUndor]]; 	}		
	}

	


	

	
	// realizzo la lista listaint2 realizzata con le intersezioni che sono anche su P1 
	NSMutableArray * listaint2 = [[NSMutableArray alloc] init];
	if ([[P1 Spezzata] count]<2) return;
	for (int i=0; i<[P1 Spezzata].count; i++) {
	
		V1 = [[P1 Spezzata] objectAtIndex:i];
		bool fattocomeIntersezione=NO;
		for (int j=0; j<ListaIntersezioni.count; j++) {
			if ([V1 isEqual:[ListaIntersezioni objectAtIndex:j]]) {
			//			for (int j=0; j<[P2 Spezzata].count; j++) {
			//				V2 = [[P2 Spezzata] objectAtIndex:j];
					//				if ([V1 isEqual:[[P2 Spezzata] objectAtIndex:j]]) 
					//  if (( (fabs([V1 xpos]-[V2 xpos]))<0.01 ) & ( (fabs([V1 ypos]-[V2 ypos]))<0.01 ) ) {					
				[listaint2 addObject:V1];
					//								[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP1 : 0 :[NSString stringWithFormat: @"-%d-",j ]: [varbase MUndor]]; 			

				fattocomeIntersezione=YES;
				break;
			}
		}
			// vediamo se e' sul bordo ed eventualmente come trattarlo per farlo diventare intersezione.
			// se e' 0 da analizzare a parte
		bool precedInterno =NO;
		bool succesInterno =NO;
        if (!fattocomeIntersezione) {
			if ([P2 ptBordo : [V1 xpos] : [V1 ypos]]) { // qui il punto qunando veramente e' frontiera di intersezione ?
				if (i==0) { V2 = [[P1 Spezzata] objectAtIndex:([P1 Spezzata].count-2)];	}	else {	 V2 = [[P1 Spezzata] objectAtIndex:i-1];		}
                if (![P2 ptBordo : [V2 xpos] : [V2 ypos]]) {
					if ([P2 ptInterno : [V2 xpos]: [V2 ypos]]) precedInterno = YES; else precedInterno = NO; // compreso se prima della frontiera era dentro o fuori.
					
						//				if (precedInterno) [[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] : htP1 : 0 :[NSString stringWithFormat: @"I" ]: [varbase MUndor]]; 			
						//					else [[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] : htP1 : 0 :[NSString stringWithFormat: @"E" ]: [varbase MUndor]]; 	
						//					[[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] : htP1 : 0 :[NSString stringWithFormat: @"-K" ]: [varbase MUndor]]; 			
					
					
					bool deterseEsceoNo = NO;
					for (int k=i+1; k<[P1 Spezzata].count; k++) {
						V2 = [[P1 Spezzata] objectAtIndex:k];
						if ([P2 ptBordo : [V2 xpos] : [V2 ypos]]) {
							lastBordo = V2;
								//							[[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] : htP1 : 0 :[NSString stringWithFormat: @"°" ]: [varbase MUndor]]; 			
							continue;
						} 
                        deterseEsceoNo = YES;
						if ([P2 ptInterno : [V2 xpos]: [V2 ypos]]) {succesInterno = YES;} else  {succesInterno = NO;}
							//							[[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] : htP1 : 0 :[NSString stringWithFormat: @"+K" ]: [varbase MUndor]]; 			

						break;
					}
					if (!deterseEsceoNo) {
						for (int k=0; k<i; k++) {
							V2 = [[P1 Spezzata] objectAtIndex:k];
							if ([P2 ptBordo : [V2 xpos] : [V2 ypos]]) 
							{	lastBordo = V2;	continue;			}
							deterseEsceoNo = YES;
							if ([P2 ptInterno : [V2 xpos]: [V2 ypos]]) {succesInterno = YES;} else  {succesInterno = NO;}
							break;
						}
					}
			if ((precedInterno & !succesInterno )  )
			{
				[listaint2 addObject:V1];
					//				[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP1*4 : 0 :[NSString stringWithFormat: @"K" ]: [varbase MUndor]]; 
			} 
			if  (!precedInterno & succesInterno )
			{
				[listaint2 addObject:lastBordo];
					//		[[varbase DisegnoVcorrente] faitesto  :hdc : [lastBordo xpos] : [lastBordo ypos] : htP1*4 : 0 :[NSString stringWithFormat: @"N" ]: [varbase MUndor]]; 
			} 
					

		   }

		 }  // e' sul bordo che fare lo metto come frontiera ?
		
		
		}
	}
	
	

	if (listaint2.count>0) { Vint = [listaint2 objectAtIndex:0];	[listaint2 addObject:Vint];	}

			 disptint2 = YES; //se voglio vedere -%d- la listaint2
	if (disptint2) {
		for (int k=0; k<listaint2.count; k++) {
			Vint2 = [listaint2 objectAtIndex:k];
				//				[[varbase DisegnoVcorrente] faitesto  :hdc : [Vint2 xpos] : [Vint2 ypos] : 4 : 0 :[NSString stringWithFormat: @"-%d-",k ]: [varbase MUndor]]; 
		}
	}
	

	// parto dalle intersezioni 
    for (int k=1; k<listaint2.count; k++) {
	//	for (int k=1; k<2; k++) {
		
		Vint2 = [listaint2 objectAtIndex:k];	Vint1 = [listaint2 objectAtIndex:k-1];
		if (k==1) {[[varbase DisegnoVcorrente] faipoligono:hdc : [Vint1 xpos] : [Vint1 ypos]  : [varbase fasecomando]];   [varbase setfasecomandopiu1]; 
			iniziatoPol = YES;		
				//							[[varbase DisegnoVcorrente] faitesto  :hdc : [Vint1 xpos] : [Vint1 ypos] : 3 : 0 :[NSString stringWithFormat: @"S" ]: [varbase MUndor]]; 
		}
			//	if (k==2) break;
			//		if (k==2)	[[varbase DisegnoVcorrente] faitesto  :hdc : [Vint2 xpos] : [Vint2 ypos] : 3 : 0 :[NSString stringWithFormat: @"S" ]: [varbase MUndor]]; 
		for (int i=0; i<[P1 Spezzata].count; i++) {
			V1 = [[P1 Spezzata] objectAtIndex:i];	
				//		if ([V1 isEqual:Vint1]) {
				if (([V1 xpos]==[Vint1 xpos]) & ([V1 ypos]==[Vint1 ypos])) {
						//	NSLog(@"Inizio P1 con intersezione in -%d- ",i);
				[[varbase DisegnoVcorrente] faipoligono  :hdc : [Vint1 xpos] : [Vint1 ypos] : [varbase fasecomando] ]; [varbase setfasecomandopiu1]; 
						//		[[varbase DisegnoVcorrente] faicerchio:hdc :[Vint1 xpos] :[Vint1 ypos] :[Vint1 xpos]+1 :[Vint1 ypos]+1 : [varbase MUndor]];  
						// sull bordo intersezione
				bool riconnesso=NO;				bool addedVt=NO;
				for (int j=i+1; j<[P1 Spezzata].count; j++) {
						//	NSLog(@"Passo da qui -%d- ",j);
					V2 = [[P1 Spezzata] objectAtIndex:j];	
						if (([V2 xpos]==[Vint2 xpos]) & ([V2 ypos]==[Vint2 ypos])) {
	//		NSLog(@"Inizio P1 con intersezione  22 in -%d- ",j);
						if (addedVt) { [[varbase DisegnoVcorrente] faipoligono  :hdc : [Vint2 xpos] : [Vint2 ypos] : [varbase fasecomando] ]; [varbase setfasecomandopiu1]; 
	//		[[varbase DisegnoVcorrente] faicerchio:hdc :[Vint2 xpos] :[Vint2 ypos] :[Vint2 xpos]+1 :[Vint2 ypos]+1 : [varbase MUndor]];  
						}
						riconnesso=YES;	break;	
					}
					if ([P2 ptInterno : [V2 xpos]: [V2 ypos]]) {
						[[varbase DisegnoVcorrente] faipoligono  :hdc : [V2 xpos] : [V2 ypos] : [varbase fasecomando] ]; [varbase setfasecomandopiu1];
							//								[[varbase DisegnoVcorrente] faicerchio:hdc :[V2 xpos] :[V2 ypos] :[V2 xpos]+1 :[V2 ypos]+1 : [varbase MUndor]];  
							// !!   fino al fondo polilinea
						addedVt = YES;
					}
				}
				if (addedVt & !riconnesso) {
					for (int j=0; j<i; j++) {
							//	NSLog(@"Passo da qui 2 -%d- ",j);

						V2 = [[P1 Spezzata] objectAtIndex:j];	
						if (([V2 xpos]==[Vint2 xpos]) & ([V2 ypos]==[Vint2 ypos])) {
								//		NSLog(@"Inizio PP1 con intersezione in -%d- ",j);
							if (addedVt) {
								[[varbase DisegnoVcorrente] faipoligono  :hdc : [Vint2 xpos] : [Vint2 ypos] : [varbase fasecomando] ];  [varbase setfasecomandopiu1]; }
								//		[[varbase DisegnoVcorrente] faicerchio:hdc :[Vint2 xpos] :[Vint2 ypos] :[Vint2 xpos]+3 :[Vint2 ypos]+3 : [varbase MUndor]];  
							riconnesso=YES;	break;	
						}
							//		NSLog(@"Pretest -%d- ",j);

						if ([P2 ptInterno : [V2 xpos]: [V2 ypos]]) {
								//		NSLog(@"testato -%d- ",j);

							[[varbase DisegnoVcorrente] faipoligono  :hdc : [V2 xpos] : [V2 ypos] : [varbase fasecomando] ]; [varbase setfasecomandopiu1]; 
								//		[[varbase DisegnoVcorrente] faitesto  :hdc : [V2 xpos] : [V2 ypos] : 3 : 0 :[NSString stringWithFormat: @"%d",j ]: [varbase MUndor]]; 
								//		[[varbase DisegnoVcorrente] faicerchio:hdc :[V2 xpos] :[V2 ypos] :[V2 xpos]+1 :[V2 ypos]+1 : [varbase MUndor]];  

							addedVt = YES;
						}
					}
				}
					// estensione se si gira al contrario tra loro ...
					// se ho trovato gli interni bene altrimenti e' la P2 che costruisce
				if (!addedVt) {
					int start=0; int end=0;
					for (int j=0; j<[P2 Spezzata].count; j++) {	V2 = [[P2 Spezzata] objectAtIndex:j];	//		if ([V2 isEqual:Vint1])  { start = j;  }	
						if (([V2 xpos]==[Vint1 xpos]) & ([V2 ypos]==[Vint1 ypos])) { start = j;  }		//		if ([V2 isEqual:Vint2])  { end   = j;  }				
					    if (([V2 xpos]==[Vint2 xpos]) & ([V2 ypos]==[Vint2 ypos])) { end = j;  }	
	                }
						//								NSLog(@"Non avendo interni di P1 uso la P2 da start-end : %d %d ",start , end);
					bool superadded =NO;
						if (start<end) { //NSLog(@"+start<end %d %d %d",start , end,[[P2 Spezzata] count]);
							for (int j=start+1; j<end; j++) {
								V2 = [[P2 Spezzata] objectAtIndex:j];	
								if ([P1 ptInterno : [V2 xpos]: [V2 ypos]]) {superadded=YES;
										//									[[varbase DisegnoVcorrente] faitesto  :hdc : [Vint1 xpos] : [Vint1 ypos] : 1 : 0 :[NSString stringWithFormat: @"°%d",k-1 ]: [varbase MUndor]]; 

										//									NSLog(@"+Vt di P2 interno %d %d %d",j ,start , end);
									[[varbase DisegnoVcorrente] faipoligono  :hdc : [V2 xpos] : [V2 ypos] : [varbase fasecomando] ]; [varbase setfasecomandopiu1]; 	}
							
									//				[[varbase DisegnoVcorrente] faicerchio:hdc :[V2 xpos] :[V2 ypos] :[V2 xpos]+1 :[V2 ypos]+1 : [varbase MUndor]];  

							}
						}
						else {	// NSLog(@"s e %d %d %d",start , end,[[P2 Spezzata] count]);

							for (int j=start+1; j<[[P2 Spezzata] count]; j++) {	//	NSLog(@"a %d %d %d ",j,start , end);
								V2 = [[P2 Spezzata] objectAtIndex:j];	
								if ([P1 ptInterno : [V2 xpos]: [V2 ypos]]) {	superadded=YES;
										//									[[varbase DisegnoVcorrente] faitesto  :hdc : [Vint1 xpos] : [Vint1 ypos] : 1 : 0 :[NSString stringWithFormat: @"°°%d",j ]: [varbase MUndor]]; 
									[[varbase DisegnoVcorrente] faipoligono  :hdc : [V2 xpos] : [V2 ypos] : [varbase fasecomando] ]; [varbase setfasecomandopiu1]; 	}
						
									//								[[varbase DisegnoVcorrente] faicerchio:hdc :[V2 xpos] :[V2 ypos] :[V2 xpos]+1 :[V2 ypos]+1 : [varbase MUndor]];  

							}
							for (int j=1; j<end; j++) {			//	NSLog(@"a %d %d %d ",j,start , end);
								V2 = [[P2 Spezzata] objectAtIndex:j];	
								if ([P1 ptInterno : [V2 xpos]: [V2 ypos]]) {			superadded=YES;
									[[varbase DisegnoVcorrente] faipoligono  :hdc : [V2 xpos] : [V2 ypos] : [varbase fasecomando] ]; [varbase setfasecomandopiu1]; 	}
									//						[[varbase DisegnoVcorrente] faicerchio:hdc :[V2 xpos] :[V2 ypos] :[V2 xpos]+1 :[V2 ypos]+1 : [varbase MUndor]];  

							}
							
						}	
					
					if (superadded) {
						[[varbase DisegnoVcorrente] faipoligono  :hdc : [Vint2 xpos] : [Vint2 ypos] : [varbase fasecomando] ]; 
							//					[[varbase DisegnoVcorrente] faicerchio:hdc :[Vint2 xpos] :[Vint2 ypos] :[Vint2 xpos]+1 :[Vint2 ypos]+1 : [varbase MUndor]];  

						[varbase setfasecomandopiu1]; 	
					}
				}

			}
		}

	}
	
/*
	Piano * locpia = [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex :[[varbase DisegnoVcorrente] IndicePianocorrente]];
	locPdaCopiare = [[locpia Listavector] objectAtIndex:[[locpia Listavector] count]-1];
		for (int i=11; i<[locPdaCopiare Spezzata].count; i++) {	V1 = [[locPdaCopiare Spezzata] objectAtIndex:i];
			[[varbase DisegnoVcorrente] faitesto  :hdc : [V1 xpos] : [V1 ypos] : htP1 : 0 :[NSString stringWithFormat: @"^%d",i ]: [varbase MUndor]]; 	}		
*/
	
	[self deseleziona];
	
} 





@end
