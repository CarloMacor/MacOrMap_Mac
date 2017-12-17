//
//  DisegnoR.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "DisegnoR.h"
#import "Raster.h"


@implementation DisegnoR


- (void)    InitDisegnoR :(NSString *) _nomefile : (InfoObj *) _info         {
	Raster         *MyRaster;
	infoObj_Raster = _info;
	ListaImgRaster = [[NSMutableArray alloc] initWithCapacity:30  ];
	MyRaster       = [Raster alloc];	 
	[MyRaster InitRaster:_nomefile:_info];
	[ListaImgRaster addObject:MyRaster];
	b_visibileraster = YES;
	b_maskabile      =  NO;
	i_mascheraBianco =  0;
	f_alpha          = 1.0;
	indiceSubRastercorrente =0;
}

- (void)    InitDisegnoRPost                     : (InfoObj *) _info         {
	Raster         *MyRaster;
	infoObj_Raster = _info;
	ListaImgRaster = [[NSMutableArray alloc] initWithCapacity:30];
	MyRaster       = [Raster alloc];	 
	[ListaImgRaster addObject:MyRaster];
	b_visibileraster = YES;
	b_maskabile      =  NO;
	i_mascheraBianco =  0;
	f_alpha          = 1.0;
	indiceSubRastercorrente =0;
}

- (void)    impostaUndoCorrenteTutto             : (NSUndoManager  *) MUndor {
	Raster         *MyRaster;
    MyRaster= [ListaImgRaster objectAtIndex:indiceSubRastercorrente];	[MyRaster impostaUndoTutto:MUndor];
}

- (void)    impostaUndoCorrenteOrigine           : (NSUndoManager  *) MUndor {
	Raster         *MyRaster;
    MyRaster= [ListaImgRaster objectAtIndex:indiceSubRastercorrente];	[MyRaster impostaUndoOrigine:MUndor];
}

- (void)    impostaUndoCorrenteScala             : (NSUndoManager  *) MUndor {
	Raster         *MyRaster;
    MyRaster= [ListaImgRaster objectAtIndex:indiceSubRastercorrente];	[MyRaster impostaUndoScala:MUndor];
}

- (void)    impostaUndoCorrenteAngolo            : (NSUndoManager  *) MUndor {
	Raster         *MyRaster;
    MyRaster= [ListaImgRaster objectAtIndex:indiceSubRastercorrente];	[MyRaster impostaUndoAngolo:MUndor];
}


- (void)    FissaUndoSeNonRotScaSubcorrente      : (NSUndoManager  *) MUndor {
	Raster         *MyRaster;   MyRaster= [ListaImgRaster objectAtIndex:indiceSubRastercorrente];
	if (([MyRaster angolo]==[MyRaster Eanglerot]) & ([MyRaster xscala]==[MyRaster Exscala]) )
	{
		[self impostaUndoCorrenteTutto:MUndor];
	}
		
}


- (void)    impostaUndoTuttiOrigine              : (NSUndoManager  *) MUndor {
	Raster         *MyRaster;
	for (int i=0; i<ListaImgRaster.count; i++) { MyRaster= [ListaImgRaster objectAtIndex:i];	[MyRaster impostaUndoOrigine:MUndor];   }
}


- (int)     IndiceSepresenteSubRaster            : (NSString       *) nomefile {
	int resulta =-1;
	Raster         *MyRaster;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		if ([nomefile isEqualToString:[MyRaster interonomefile] ]) {resulta = i;	break;	}
	}
	return resulta;
}


- (int)     numimg                                               {
	return [ListaImgRaster count];
}
- (float)   alpha                                                { return f_alpha;              }
- (float)   alphaindice                 :(int)    ind            {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex: ind];
	return [MyRaster alpha];
}
- (double)  angoloindice                :(int)   _ind            {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex: _ind];
	return [MyRaster angolo];
}
- (double)  scalaindice                 :(int)   _ind {
	Raster         *MyRaster;

    MyRaster = [ListaImgRaster objectAtIndex: _ind];
    return [MyRaster xscala];
}

- (double)  xorigineIndice             :(int)   _ind {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex: _ind];
    return [MyRaster xorigine];
}

- (double)  yorigineIndice             :(int)   _ind {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex: _ind];
    return [MyRaster yorigine];
}



- (double)  limitex1                                             {return limx1; }
- (double)  limitey1                                             {return limy1; }
- (double)  limitex2                                             {return limx2; }
- (double)  limitey2                                             {return limy2; }
- (bool)    isvisibleRaster                                      {return b_visibileraster; }
- (bool)    visibleRasterIndice         :(int) indice            { 
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex:indice];
	return [MyRaster visibile]; 
}

- (bool)    isMaskableRaster                                     { return b_maskabile; }
- (int)     isMaskabianca                                        { return i_mascheraBianco; }
- (int)     getdimx_indrast             :(int) indice            {  
	Raster         *MyRaster;
	MyRaster= [ListaImgRaster objectAtIndex:indice];
	return [MyRaster dimx];
}
- (int)     getdimy_indrast             :(int) indice            {  
	Raster         *MyRaster;
	MyRaster= [ListaImgRaster objectAtIndex:indice];
	return [MyRaster dimy];
}

- (CGImageRef) dammiImgRef                                       {
	Raster         *MyRaster = [ListaImgRaster objectAtIndex:indiceSubRastercorrente];
	return [MyRaster ImgRef];
}
- (NSString *) damminomefile            :(int) indice            {  
	Raster         *MyRaster;
	MyRaster= [ListaImgRaster objectAtIndex:indice];
	return [MyRaster nomefile];
}

- (NSString *)     interonomefile       :(int) indice            {
	Raster         *MyRaster;
	MyRaster= [ListaImgRaster objectAtIndex:indice];
	return [MyRaster interonomefile];
}


- (NSString *) damminomefileNoExt       :(int) indice            {
	Raster         *MyRaster;
	MyRaster= [ListaImgRaster objectAtIndex:indice];
	return [MyRaster nomefilenoExt];
}

- (CGImageRef) imgRefIndice             :(int) indice            {
	Raster         *LocRaster;
    LocRaster = [ListaImgRaster objectAtIndex:indice];
	return [LocRaster ImgRef];
}
- (NSDictionary *) imgPropIndice        :(int) indice            {
	Raster         *LocRaster;
    LocRaster = [ListaImgRaster objectAtIndex:indice];
	return [LocRaster ImgProp];
}
- (NSString *) imgUTTypeIndice          :(int) indice            {
	Raster         *LocRaster;
    LocRaster = [ListaImgRaster objectAtIndex:indice];
	return [LocRaster imgUTType];
}
// azioni
- (NSMutableArray *) Listaimgraster  {
	return ListaImgRaster;
}


- (int)     indiceSubRastercorrente                              {
	return indiceSubRastercorrente;
}

- (void)    setindiceSubRasterCorrente     :(int) indice         {
	indiceSubRastercorrente = indice;
}



- (void)  RemoveDisegnoR                                         {
	Raster         *MyRaster;
	for (int i=ListaImgRaster.count-1; i>=0; i--) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster RemoveRaster];
	}
	MyRaster =nil;
    [ListaImgRaster release];
}
- (void)  RemoveDisegnoRindice :(int) indice                     {
	Raster         *MyRaster;
	MyRaster= [ListaImgRaster objectAtIndex:indice];
	[ListaImgRaster removeObjectAtIndex:indice];
	[MyRaster RemoveRaster];	
	MyRaster =nil;
}
- (void)  updateLimiti                                           { 
	Raster *locRaster;
	locRaster= [ListaImgRaster objectAtIndex:0];        	[locRaster updateLimiti];
	limx1=[locRaster limx1];  	limy1=[locRaster limy1];  
    limx2=[locRaster limx2];    limy2=[locRaster limy2];
	for (int i=1; i<ListaImgRaster.count; i++) {  
		locRaster= [ListaImgRaster objectAtIndex:i];		[locRaster updateLimiti];
		if (limx1>[locRaster limx1]) limx1=[locRaster limx1];
		if (limx2<[locRaster limx2]) limx2=[locRaster limx2];
		if (limy1>[locRaster limy1]) limy1=[locRaster limy1];
		if (limy2<[locRaster limy2]) limy2=[locRaster limy2];
	}
}
- (void)  updateInfoConLimiti                                    {
	[self updateLimiti];
	[infoObj_Raster  setLimitiDisR :limx1 : limy1 : limx2 : limy2];
}
- (void)  updateInfoConLimitiSubraster                           {
    Raster * LocRaster= [ListaImgRaster objectAtIndex:indiceSubRastercorrente];	
	[LocRaster updateInfoConLimiti];
	LocRaster =nil;
}
- (void)  InitRasterImgRef  :(CGImageRef)   _imgref              {
	Raster         *MyRaster=[ListaImgRaster objectAtIndex:indiceSubRastercorrente];	
	[MyRaster InitRasterImgRef:_imgref];
}
- (void)  addDisegnoR :(NSString *) _nomefile                    {
	Raster         *MyRaster;
	MyRaster = [Raster alloc];	    [MyRaster InitRaster:_nomefile  : infoObj_Raster] ;
	[ListaImgRaster addObject:MyRaster];
}
- (void)  setalpha                    :(float)  _alpha           {
	f_alpha=_alpha;
}
- (void)  setalphaindice              :(int)_ind  :(float)_alpha {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex:_ind];
	[MyRaster setalpha:_alpha];
}
- (void)  setvisibile                 :(int)_state               {
	if (_state==NSOnState) b_visibileraster=YES; else b_visibileraster=NO;
}
- (void)  setmaskabile                :(int)_state:(int) _white  {
	Raster         *MyRaster;
	if (_state==NSOnState) b_maskabile=YES; else b_maskabile=NO;
	i_mascheraBianco = _white;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster setmaskabile:b_maskabile :_white];
	}
}
- (void)  setvisibileindice           :(int) indice :(bool) stat {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex:indice];
	[MyRaster setvisibile:stat];
}
- (void)  BiancoTrasparente                                      {
	Raster         *MyRaster;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster BiancoTrasparente ];
	}
}
- (void)  SpostaOrigine               :(double)_dx  :(double) _dy
									  :(bool) tutti: (int)indice {
	Raster         *MyRaster;
    if (tutti)	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster SpostaOrigine :_dx:_dy];
    } else { MyRaster= [ListaImgRaster objectAtIndex:indice];	[MyRaster SpostaOrigine :_dx:_dy];	}
}


- (void)  setscalaDisraster           :(double)sca_x:(double) sca_y  : (bool) tutti:(int)indice;{
	Raster         *MyRaster;
	if (tutti)	
		for (int i=0; i<ListaImgRaster.count; i++) {  
			MyRaster= [ListaImgRaster objectAtIndex:i];
			[MyRaster setscalaDisraster:sca_x : sca_y];
		}
	else { MyRaster= [ListaImgRaster objectAtIndex:indice];	[MyRaster setscalaDisraster:sca_x : sca_y];	}
}

- (void)  setscalaraster1             : (bool) tutti:(int)indice;{
	Raster         *MyRaster;
	if (tutti)	
		for (int i=0; i<ListaImgRaster.count; i++) {  
			MyRaster= [ListaImgRaster objectAtIndex:i];
			[MyRaster setscalaDisraster1];
		}
	else { MyRaster= [ListaImgRaster objectAtIndex:indice];	[MyRaster setscalaDisraster1];	}
}


- (void)  setangolorot                :(double) _angle            {
	Raster         *MyRaster;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster ruota:_angle];
	}
}

- (void)  setangolorotindice          :(double) _angle Indice:(int) indice{
	Raster         *MyRaster;
	MyRaster= [ListaImgRaster objectAtIndex:indice];
	[MyRaster ruota:_angle];
}


- (void)  resetimmagine               :(int)_ind                 {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex:_ind];
	[MyRaster resetimmagine];
}

- (void)  FissaOrigine                :(int)_ind  : (double) xc : (double) yc            {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex:_ind];	
	[MyRaster FissaOrigine : xc : yc];
}

- (void)  setscalaindice              :(int)_ind : (double) xs : (double) ys             {
	Raster         *MyRaster;
	MyRaster = [ListaImgRaster objectAtIndex:_ind];	
	[MyRaster setscala : xs : ys];
}



- (void)  Disegna:(CGContextRef) hdc                             {
	Raster         *MyRaster;
	if (!b_visibileraster) return;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		
			//	if (i>11) continue;
		
		MyRaster= [ListaImgRaster objectAtIndex:i];
			//	[MyRaster setcolorefondo:(i+1)];
		
			//		if ([MyRaster NoBianco]) CGContextSetAlpha (hdc,f_alpha*[MyRaster alpha]*2.0 );
			//                       else 	 CGContextSetAlpha (hdc,f_alpha*[MyRaster alpha] );
		
		CGContextSetAlpha (hdc,f_alpha*[MyRaster alpha]) ;
		
		[MyRaster Disegna:hdc];
	}
}


- (void)  disegnarasterino            :(CGContextRef) hdc   : (NSRect) fondo     {
	Raster * LocRaster= [ListaImgRaster objectAtIndex:indiceSubRastercorrente];
	[LocRaster disegnarasterino:hdc:  fondo];
}

- (void)  CropConPoligono           :(NSMutableArray *) _List: (bool) tutti: (int) indice           {
	Raster         *MyRaster;
	if (tutti)	
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster CropConPoligono:_List];
     }	
	 else { MyRaster= [ListaImgRaster objectAtIndex:indice];	[MyRaster CropConPoligono:_List];	
	}
}

- (void)  CropConRettangolo           :(NSMutableArray *) _List: (bool) tutti: (int) indice{
	Raster         *MyRaster;
	if (tutti)	
		for (int i=0; i<ListaImgRaster.count; i++) {  
			MyRaster= [ListaImgRaster objectAtIndex:i];
			[MyRaster CropConRettangolo:_List];
		}	
	else { MyRaster= [ListaImgRaster objectAtIndex:indice];	[MyRaster CropConRettangolo:_List];	
	}
	
}



- (void)  MaskConPoligono           :(NSMutableArray *) _List: (bool) tutti: (int) indice           {
	Raster         *MyRaster;
	if (tutti)	
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i]; 
		[MyRaster MaskConPoligono:_List :0 :0 :1 :1];
     }
	 else { MyRaster= [ListaImgRaster objectAtIndex:indice];	[MyRaster MaskConPoligono:_List :0 :0 :1 :1];	
	}
}
- (void)  rotoscala                 :(double)i_x1coord :(double) i_y1coord :(double)i_x2coord :(double) i_y2coord 
									:(double)i_x3coord :(double) i_y3coord :(double)i_x4coord :(double) i_y4coord
									: (bool) tutti: (int) indice                                    {
	Raster         *MyRaster;
	if (tutti)	
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster rotoscala:i_x1coord : i_y1coord :i_x2coord : i_y2coord :i_x3coord : i_y3coord :i_x4coord : i_y4coord]; 
    }
	else { MyRaster= [ListaImgRaster objectAtIndex:indice];	
		[MyRaster rotoscala:i_x1coord : i_y1coord :i_x2coord : i_y2coord :i_x3coord : i_y3coord :i_x4coord : i_y4coord];	}
} 
- (void)  Calibra8pt : (double)_x1: (double)_y1: (double)_x2: (double)_y2: (double)_x3: (double)_y3: (double)_x4: (double)_y4 
                     : (double)_x5: (double)_y5: (double)_x6: (double)_y6: (double)_x7: (double)_y7: (double)_x8: (double)_y8 
					 : (bool) tutti: (int) indice   : (NSLevelIndicator   *) LevelIndicatore                       {
	Raster         *MyRaster;
	if (tutti)	
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i]; 
		[MyRaster Calibra8pt : _x1: _y1: _x2: _y2: _x3: _y3: _x4: _y4: _x5: _y5: _x6: _y6: _x7: _y7: _x8: _y8 :LevelIndicatore] ;
   }
	else { MyRaster= [ListaImgRaster objectAtIndex:indice];	
		[MyRaster Calibra8pt : _x1: _y1: _x2: _y2: _x3: _y3: _x4: _y4: _x5: _y5: _x6: _y6: _x7: _y7: _x8: _y8 :LevelIndicatore]; 	}

}

- (void)  RuotaconCentro    : (double) xc : (double) yc : (double) rot      : (int) indice          {
	Raster         *MyRaster;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster RuotaconCentro:xc:yc:rot];

	}
		//	MyRaster= [ListaImgRaster objectAtIndex:indice];	
		//	[MyRaster RuotaconCentro:xc:yc:rot];
}

- (void)  ScalaconCentro              : (double) xc : (double) yc : (int) modo : (double) scal  : (int) indice   {
	Raster         *MyRaster;
		//	NSLog(@"B %d %2.2f "  , modo,scal);

	
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster ScalaconCentro:xc:yc:modo:scal];
		
	}
	
		//	MyRaster= [ListaImgRaster objectAtIndex:indice];	
		//	[MyRaster ScalaconCentro:xc:yc:scal];
}

- (void)  SalvaInfoRaster                                                                           {
	// da ciclare sui tutti
	Raster         *MyRaster;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i]; 
	    [MyRaster SalvaInfoRaster];
	}
}

- (void)  SalvaInfoRasterUno : (int) indice                                                         {
	Raster         *MyRaster;
     MyRaster= [ListaImgRaster objectAtIndex:indice];	
    [MyRaster SalvaInfoRaster];
}


- (void)  CambiaColore : (NSColor *) colore                                                         {
	Raster         *MyRaster;
	for (int i=0; i<ListaImgRaster.count; i++) {  
		MyRaster= [ListaImgRaster objectAtIndex:i];
		[MyRaster CambiaColore : colore];
	}		
}





@end
