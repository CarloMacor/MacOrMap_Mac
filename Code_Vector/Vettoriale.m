//
//  Vettoriale.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Vettoriale.h"


@implementation Vettoriale



- (void) Init      : (DisegnoV *) _dis :(Piano *) _pian        {
	_piano     = _pian;
	_disegno   = _dis;
}

- (void) Disegna:(CGContextRef) hdc: (InfoObj *) _info         {
//
}	
	
- (void) DisegnaAffineSpo : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  {
	//
}

- (void) DisegnaAffineRot : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  {
//
}

- (void) DisegnaAffineSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  {
	//
}

- (void) DisegnaSpoRotSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot : (double) sca  {
		//
} 


- (void) dispallinispline : (CGContextRef)  hdc    : (InfoObj *) _info {
	//
}

- (void) DisegnaSelected  : (CGContextRef)  hdc    : (InfoObj *) _info {
	
}  // solo per i testi


- (void) DisegnaVtTutti   : (CGContextRef)  hdc    : (InfoObj *) _info{
		//
}
- (void) DisegnaVtFinali  : (CGContextRef)  hdc    : (InfoObj *) _info{
		//
}


- (int)  dimmitipo                                             {	return tipo;  }
	

- (NSString *)  dimmitipostr                                   {
	
		// 1 punto  2 plinea  3 poligono 4 regione 5 cerchio
		// 6 testo  7 Splinea 8 Splineachiusa 9 SplineaRegione
		// 10 simbolo ,11 Arco
	
	switch (tipo) {
		case 1:	return @"Punto";	    break;
		case 2:	return @"PoliLinea";	break;
		case 3:	return @"Poligono";	    break;
		case 4:	return @"Regione";	    break;
			
		case 5:	return @"Cerchio";	    break;
		case 6:	return @"Testo";	    break;
			
		case 7:	return @"Splinea";	    break;
		case 8:	return @"Spoligono";    break;
		case 9: return @"SRegione";     break;
			
		case 10:return @"Simbolo";      break;
		case 11:return @"Arco";         break;

		default: return nil;		break;
	}
	return nil;	
}


- (double)      lunghezza                                      {
	return 0;
}

- (double)      superficie  {
	return 0;
}


- (NSString *)  lunghezzastr                                   {
	return @"";
}



- (NSString *)  pianostr                                       {
	return [_piano givemenomepiano];
}

- (NSString *)  disegnostr                                     {
	return [[_disegno nomedisegno] lastPathComponent];
}

- (NSString *)  nvtstr{
	return @"0";
}

- (NSString *)  supstr{
	return @"";
}

- (void) chiudiSeChiusa  {
    
}

- (void) Cambia1PoligonoaRegione {
    
}



- (bool)   addCatVertici  : (double) x1: (double) y1 : (Vettoriale *) objvect {
	return NO;
}


- (void) salvavettorialeMoM    :(NSMutableData *) _illodata       {
	[_illodata appendBytes:(const void *)&tipo         length:sizeof(tipo)];
	[_illodata appendBytes:(const void *)&indicedbase  length:sizeof(indicedbase)];
	[_illodata appendBytes:(const void *)&indicedbase2 length:sizeof(indicedbase2)];
}

- (NSUInteger) aprivettorialeMoM     : (NSData *) _data  : (NSUInteger) posdata  {
	[_data getBytes:&indicedbase        range:NSMakeRange (posdata, sizeof(indicedbase))  ];     posdata +=sizeof(indicedbase);
	[_data getBytes:&indicedbase2       range:NSMakeRange (posdata, sizeof(indicedbase2)) ];     posdata +=sizeof(indicedbase2);
	return posdata;
}

- (bool) SnapFine  : (InfoObj *) _info:  (double) x1: (double) y1             { return NO; }

- (bool) SnapVicino: (InfoObj *) _info:  (double) x1: (double) y1             {
		return NO;
}


- (int)  SnapCat   : (InfoObj *) _info:  (double) x1: (double) y1             {
	return -1;

}



- (void) seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info: (double) x1 : (double) y1: (NSMutableArray *) _LSelezionati {
	//
	
}

- (void) seleziona_conPtInterno  : (CGContextRef)  hdc    : (InfoObj *) _info    : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati {
		//
}
- (bool)   ptInterno      : (double) x1: (double) y1{
	return NO;
}

- (Vertice *) verticeN    : (int) ind {
	return nil;
}


- (bool) selezionaVtconPt : (CGContextRef) hdc  : (InfoObj *) _info: (double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati {
	bool locres=NO;
	return locres;
}

- (void) SpostaVerticeSelezionato    :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy {
//
}

- (void) InserisciVerticeSelezionato :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy {
	//
}

- (void) CancellaVerticeSelezionato  :(NSMutableArray *) _LSelezionati {
	//
}

- (void) EditVerticeSelezionato      :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy {
	//
}



- (bool) Match_conPt                 : (InfoObj *) _info   : (double) x1 : (double) y1     {
	//
	return NO;
}

- (void) faiLimiti                                                            {
//
}

- (bool) testinternoschermo : (InfoObj *) _info                               {
	bool locres=YES;
	if (limx2<[_info xorigineVista]  )  return NO;
	if (limx1>[_info x2origineVista] ) return NO;
	if (limy2<[_info yorigineVista]  )  return NO;
	if (limy1>[_info y2origineVista] ) return NO;
	return locres;
}

- (double) limx1                                                              { return limx1;};
- (double) limy1                                                              { return limy1;};
- (double) limx2                                                              { return limx2;};
- (double) limy2                                                              { return limy2;};

- (void) Sposta            : (double) dx :  (double) dy                       {
//	
}

- (Vettoriale *) Copia             : (double) dx :  (double) dy                       {
	//	
	return nil;
}




- (void) Ruota             : (double) xc :  (double) yc : (double) ang        {
	//	
}

- (void) Ruotaang          : (double) ang                                     {
	//
} 

- (void) Scala             : (double) xc :  (double) yc : (double) scal       {
	//
} 

- (void) Scalasc           : (double) scal                                    {
	//
} 

- (void) CopiainLista      : (NSMutableArray *) inlista                       {
		//
}


- (void) cancella                                              {
	b_erased=YES;
}

- (void) Decancella                                            {
	b_erased=NO;
}


- (bool) cancellato                                            {
	return b_erased;
}

- (NSString *) salvadxf                                        {
	NSString *risulta=@"";
	return risulta;	
}

- (void) svuota                                                {
		//
}

- (bool) isspline                                              {
	return NO;
}

- (int)  numvt                                                 {
 return	0;
}


- (void) CatToUtm     : (InfoObj *) _info                      {
		//
}

- (void) TestoAltoQU                                           {
	
}


- (Piano    *) piano                                           {
	return _piano;	
}

- (DisegnoV *) disegno                                         {
	return _disegno;
	
}

- (Vettoriale *) copiaPura                                     {
	return nil;
}

- (Vettoriale *) copiaPuraNoaDisegno                           {
	return nil;
}


- (NSString *) caratteritesto                                  {
	return nil;
}

- (double)     altezzatesto                                    {
	return 0;
}


@end
