//
//  Polilinea.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Polilinea.h"
#import "Vertice.h"
#import "funzioni.h"


@implementation Polilinea



- (void)  InitPolilinea                :(bool) chiusa    {
	b_erased=NO;	b_selected=NO;

	if (chiusa) tipo  = 3; else tipo  = 2;
	Spezzata = [[NSMutableArray alloc] init];
	
	BacksInfo = nil;
	
    b_chiusa = chiusa;
	b_regione = NO;
	b_scurva  = NO;
}


- (void) ImpostaBack     : (int) azb : (int) indb : (double) xer : (double) yer  {
		// azb ==1 sposta vertice     =2 Inserisci vertice     =3 cancella vertice
	
	if (BacksInfo==nil) { BacksInfo = [[NSMutableArray alloc] initWithCapacity:40 ]; }
	BeccoVett * locbecco = [BeccoVett alloc];
	[locbecco init: azb : indb : xer : yer];
	[BacksInfo addObject:locbecco];
	
}

- (void) EseguiBack       {
	if (BacksInfo==nil)  return;
	
	BeccoVett * locbecco = [BacksInfo lastObject];
    Vertice * locVt;
		//	[locbecco logga];
	switch ([locbecco azioneback]) {
		case 1:  // spostamento del vertice
			locVt = [Spezzata objectAtIndex:[locbecco indicevtback]];
			[locVt InitVertice:[locbecco xbacco] :[locbecco ybacco]];
			break;
		case 2 :  // visto che e' stato inserito lo elimino
			locVt = [Spezzata objectAtIndex:[locbecco indicevtback]];
            [Spezzata removeObjectAtIndex:[locbecco indicevtback]];
			[locVt release];
			break;
		case 3 :  // visto che e' stato cancellato lo reinserisco
			locVt = [Vertice alloc]; [locVt InitVertice:[locbecco xbacco]:[locbecco ybacco]];	[Spezzata insertObject:locVt atIndex:[locbecco indicevtback]  ];
			break;		
		default:  break;
	}
	
	
	[BacksInfo removeLastObject];
	[locbecco release];
}


- (void)  UpdatePolyInSpline                             {
	if (b_scurva) return;
	b_scurva=YES;
	VertControlList = [[NSMutableArray alloc] init];
	// qui per le gia' create duplicare i vertici di controllo
}

- (void)  setregione                   :(bool) _bol      {
	b_regione=_bol;
}


- (bool)  chiusa                                         {return b_chiusa;}

- (bool)  isspline                                       {return b_scurva;}

- (bool)   isregione                                     {return b_regione;}


- (void)   polyinpoligono                                {
	tipo  = 3;
	b_chiusa = YES;
}


- (void)  chiudi                                         {
	if  ([Spezzata count]<3) return; // se minore di 3 la cancelli anche
	Vertice *a;	Vertice *b;	 
	if (lastVtUp==nil) {  lastVtUp=[Spezzata objectAtIndex:0];	}
	
	
	if (b_scurva) {
		if ( [VertControlList count]<[Spezzata count] ) {
		 b = [Spezzata objectAtIndex:([Spezzata count]-1)];
		 a = [Vertice alloc]; 	[a InitVertice:[b xpos]:[b ypos]];		[VertControlList addObject:a];
		}
		if ( [VertControlList count]<[Spezzata count] ) NSBeep();

		a = [Vertice alloc];  [a InitVertice: [lastVtUp xpos]:[lastVtUp ypos]];		[Spezzata addObject:a];	
		a = [Vertice alloc];  [a InitVertice: [lastVtUp xpos]:[lastVtUp ypos]];		[VertControlList addObject:a];	
		b = [Spezzata objectAtIndex:0];
		if (([b xpos]!=[a xpos]) | ([b ypos]!=[a ypos])) { 
		 a = [Vertice alloc]; 	  [a InitVertice: [lastVtUp xpos]:[lastVtUp ypos]];			[Spezzata addObject:a];
		 a = [Vertice alloc];	  [a InitVertice: [lastVtUp xpos]:[lastVtUp ypos]];			[VertControlList addObject:a];
//		 if ([VertControlList count]<[Spezzata count]) [VertControlList addObject:a];
		}
	}	else 
	{
			//		NSLog(@"chiudo");
	    a = [Vertice alloc];
	    [a InitVertice: [lastVtUp xpos]:[lastVtUp ypos]];	
		[Spezzata addObject:a];	 
	    b = [Spezzata objectAtIndex:0];
        if (([b xpos]!=[a xpos]) | ([b ypos]!=[a ypos])) {
	    a = [Vertice alloc];
	    [a InitVertice: [lastVtUp xpos]:[lastVtUp ypos]];	
	    [Spezzata addObject:a];	 }
	}
//	if ( [VertControlList count]<[Spezzata count] ) NSBeep();

}

- (double) dammixPuntoInd               :(int) ind       {
	Vertice *a;
	long risultato =0;
	a= [Spezzata objectAtIndex:ind];
    risultato = [a xpos];
	return risultato;
}

- (double) dammiyPuntoInd               :(int) ind       {
	Vertice *a;
	long risultato =0;
	a= [Spezzata objectAtIndex:ind];
    risultato = [a ypos];
	return risultato;
}


- (bool)   ptBordo1mm      : (double) x1: (double) y1   {
	bool locres =NO;
	Vertice *a;
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];	
		if (  (fabs([a xpos]-x1)<0.001) & ( fabs([a ypos]-y1)<0.001 )) {
			locres = YES;
		} 
	}
	return locres;
}


- (bool)   ptBordo      : (double) x1: (double) y1   {
	bool locres =NO;
	Vertice *a;
	 for (int i=0; i<Spezzata.count; i++) {  
	   a= [Spezzata objectAtIndex:i];	
	   if (([a xpos]==x1) & ([a ypos]==y1)) {
	   locres = YES;
	   } 
	  }
	return locres;
}


- (bool)   ptInterno      : (double) x1: (double) y1     {
	bool locres =NO;
	double yover; double dy ;
	
	if (x1<limx1) return locres;
	if (x1>limx2) return locres;
	if (y1<limy1) return locres;
	if (y1>limy2) return locres;
	
	Vertice *a,  *b;
	int numint=0;
	if (b_regione) {
		for (int i=1; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i-1];			b= [Spezzata objectAtIndex:i];
            if ( [b givemeifup] ) {
				while (numint>1) {numint=numint-2; }  if (numint==1) locres=!locres;
                numint=0;
				continue;
			}
			if ( ((x1>[a xpos]) &  (x1<=[b xpos])) | ((x1>[b xpos]) &  (x1<=[a xpos])) ) {
				dy = (([b ypos]-[a ypos]) * (x1-[a xpos])) / ([b xpos]-[a xpos]  );
				yover = [a ypos]+dy;
				if (yover>y1) numint++;	}  } 
		while (numint>1) {numint=numint-2; }  if (numint==1) locres=!locres;
	} 
	else {
	 if (b_chiusa)  {
		for (int i=1; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i-1];			b= [Spezzata objectAtIndex:i];
			if ( ((x1>[a xpos]) &  (x1<=[b xpos])) | ((x1>=[b xpos]) &  (x1<[a xpos])) ) {
				dy = (([b ypos]-[a ypos]) * (x1-[a xpos])) / ([b xpos]-[a xpos]  );
				yover = [a ypos]+dy;
								if (yover>y1) numint++;	}
		} 
			 // controllo se le x sono uguali di a e b.
		 a= [Spezzata objectAtIndex:Spezzata.count-1];			b= [Spezzata objectAtIndex:0];
		 if ( ((x1>[a xpos]) &  (x1<=[b xpos])) | ((x1>=[b xpos]) &  (x1<[a xpos])) ) {
			 dy = (([b ypos]-[a ypos]) * (x1-[a xpos])) / ([b xpos]-[a xpos]  );
			 yover = [a ypos]+dy;
			 if (yover>y1) numint++;	}
	 } 
		while (numint>1) {	numint=numint-2; }
		if (numint==1) locres=YES;
	}
	return locres;
}

- (Vertice *) verticeN    : (int) ind {
	return [Spezzata objectAtIndex:ind];
}


- (void)  Disegna:(CGContextRef) hdc: (InfoObj *) _info  {
	
	
	if (b_erased) return;
	
	double ddx = fabs(limx2-limx1)/[_info scalaVista];
	double ddy = fabs(limy2-limy1)/[_info scalaVista];

	if ((ddx<2) & (ddy<2)) {
		CGRect rect ;
		rect.origin.x = (limx1-[_info xorigineVista])/[_info scalaVista];
		rect.origin.y = (limy1-[_info yorigineVista])/[_info scalaVista];
		rect.size.height=1;
		rect.size.width=1;
            //		CGContextFillRect (hdc, rect );	// se piccolo metter comunque un punto
                                        	CGContextStrokeRect (hdc,rect );
		return;}
	
	if (b_scurva) { [self DisegnaSp:hdc :_info];    return;}
	
	Vertice *a,  *bup, *a0;
	bup=nil;
	if (b_regione) { 
        bool toClose=NO; 
		CGContextBeginPath(hdc);
      
		for (int i=0; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i];
			if (i==0) [a moveto:hdc :  _info]; else {
				if ( ![a givemeifup] ) { [a lineto:hdc : _info]; toClose=YES; } 
                else {
						if (toClose) CGContextClosePath ( hdc); [a moveto:hdc :  _info]; toClose=NO;
				}
			}
		} 
		CGContextDrawPath ( hdc,kCGPathFillStroke);
	} else 	{	
	 CGContextBeginPath(hdc);
	 if (Spezzata.count>0) {a0 =  [Spezzata objectAtIndex:0]; 	[a0 moveto:hdc :  _info];	}
	 for (int i=1; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];
		 ddx = fabs(([a xpos]-[a0 xpos])/[_info scalaVista]);
		 ddy = fabs(([a ypos]-[a0 ypos])/[_info scalaVista]);
		 if ((ddx<1.0) & (ddy<1.0)) { continue; }
			  a0=a;
		 [a lineto:hdc : _info];
	 } 

	if ((b_chiusa) & (Spezzata.count>0)) { a= [Spezzata objectAtIndex:0]; [a lineto:hdc : _info];}
	 if (b_chiusa)  { CGContextDrawPath ( hdc,kCGPathFillStroke);	 } else { CGContextStrokePath(hdc);	 }
   }
}

- (void)  DisegnaSp:(CGContextRef) hdc: (InfoObj *) _info{
	Vertice *a,*a0,*c,*d; //,*bup;
		//	CGContextSetLineWidth(hdc, 1.0 );
//	CGContextSetRGBStrokeColor (hdc, 0,0,0,1);
	CGContextBeginPath(hdc);

/* 
	for (int i=0; i<VertControlList.count; i++) {  
		CGContextBeginPath(hdc);
		c= [VertControlList        objectAtIndex:i];
		a= [Spezzata               objectAtIndex:i];
		[a tangento  :hdc :  _info :c];
		CGContextStrokePath(hdc);
	} 
*/	
	
	if (b_regione) {
		CGContextBeginPath(hdc);

		for (int i=0; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i];
			if (i==0) [a moveto:hdc :  _info]; else {
				if ( ![a givemeifup] )  
				{
				    if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;	
					if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
					if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
					[a splineto:hdc : _info:a0:c:d];
				}	else 	{ [a moveto:hdc :  _info];	};
			}
		} 
		CGContextStrokePath(hdc);
		// superficie

		
			//////////////////
			CGContextBeginPath(hdc);
			for (int i=0; i<Spezzata.count; i++) {  
				a = [Spezzata        objectAtIndex:i];
				if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;
				if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
				if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
				if (i==0) [a moveto:hdc :  _info]; else {[a splineto:hdc : _info:a0:c:d]; }
			} 
			CGContextClosePath(hdc);	CGContextFillPath(hdc);
			///////////////////		

			///////////////////		

/*		
		CGContextBeginPath(hdc);
		for (int i=0; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i];
			
			if ( [a givemeifup] ) 	{	CGContextClosePath(hdc); bup=a;	}
			if (i==0) [a moveto:hdc :  _info]; else
			{
				if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;	
				if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
				if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
			    if ( [a givemeifup] ) [a lineto:hdc : _info];	else[a splineto:hdc : _info:a0:c:d];
			}
//				[a lineto:hdc : _info];	
		}
		
			//		[bup lineto:hdc : _info];
		CGContextClosePath(hdc);			CGContextEOFillPath(hdc);
 */
			///////////////////		
		
		
 
    }
	else {
//	 CGContextSetRGBStrokeColor (hdc, 1.0,0,0,1);
	   CGContextBeginPath(hdc);
//		for (int i=0; i<Spezzata.count; i++) {  
			for (int i=0; i<VertControlList.count; i++) {  
			a = [Spezzata        objectAtIndex:i];
			if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;
			if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
			if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
			if (i==0) [a moveto:hdc :  _info]; else {[a splineto:hdc : _info:a0:c:d]; }
        } 
		CGContextStrokePath(hdc);
	
	 if (b_chiusa)  {
  	  CGContextBeginPath(hdc);
		for (int i=0; i<Spezzata.count; i++) {  
			a = [Spezzata        objectAtIndex:i];
			if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;
			if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
			if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
			if (i==0) [a moveto:hdc :  _info]; else {[a splineto:hdc : _info:a0:c:d]; }
			} 
		CGContextClosePath(hdc);	CGContextFillPath(hdc);
	 }
	}
}

- (void)  DisegnaSplineVirtuale: (CGContextRef) hdc : (int) x1: (int) y1: (InfoObj *) _info            {
	Vertice *a,*a0,*c,*d;
	if ([Spezzata count]> [VertControlList count]) {
		CGContextSetRGBStrokeColor (hdc, 1.0,0,0,1);
		CGContextBeginPath(hdc);
        if ([Spezzata count]>=2) {

			a0 = [Spezzata        objectAtIndex:[Spezzata count]-2];
			a  = [Spezzata        objectAtIndex:[Spezzata count]-1];
	 	    c  = [VertControlList objectAtIndex:[VertControlList count]-1]; 
	        double	xcord = [_info xorigineVista]+x1*[_info scalaVista];
	        double	ycord = [_info yorigineVista]+y1*[_info scalaVista];
			d = [Vertice alloc];			[d InitVertice:xcord :ycord ];	
			[a0 moveto:hdc :  _info];		[a  splineto:hdc : _info:a0:c:d]; 
//			[a0 moveto:hdc :  _info];		[d  lineto:hdc : _info]; 

		} 
		CGContextStrokePath(hdc);
	}
}

- (void)  DisegnaAffineSpo     : (CGContextRef) hdc : (InfoObj *) _info : (double) dx : (double) dy    {
	
	Vertice *a,*a0,*c,*d;
	if (b_scurva) {
		CGContextBeginPath(hdc);
		for (int i=0; i<VertControlList.count; i++) {  
			a = [Spezzata        objectAtIndex:i];
			if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;
			if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
			if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
			if (i==0) [a movetoSpo:hdc :  _info:dx:dy]; else {[a splinetoSpo:hdc : _info:a0:c:d:dx:dy]; }
        } 
		CGContextStrokePath(hdc);
	} else 
	{
	 CGContextBeginPath(hdc);
	 for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];
		if (i==0) [a movetoSpo:hdc :  _info:dx:dy]; else [a linetoSpo:hdc : _info:dx:dy]; } 
	 if ((b_chiusa) & (Spezzata.count>0)) { a= [Spezzata objectAtIndex:0]; [a linetoSpo:hdc : _info:dx:dy];}
	 CGContextStrokePath(hdc);
	}
}

- (void)   DisegnaAffineRot    : (CGContextRef) hdc : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  {
	Vertice *a,*a0,*c,*d;
	if (b_scurva) {
		CGContextBeginPath(hdc);
		for (int i=0; i<VertControlList.count; i++) {  
			a = [Spezzata        objectAtIndex:i];
			if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;
			if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
			if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
			if (i==0) [a movetoRot:hdc :  _info:xc:yc:rot];  else 
			{[a splinetoRot:hdc : _info:a0:c:d:xc:yc:rot]; }
        } 
		CGContextStrokePath(hdc);
	} else 
	{
		CGContextBeginPath(hdc);
		for (int i=0; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i];
			if (i==0) [a movetoRot:hdc :  _info:xc:yc:rot]; else [a linetoRot:hdc : _info:xc:yc:rot]; } 
		if ((b_chiusa) & (Spezzata.count>0)) { a= [Spezzata objectAtIndex:0]; [a linetoRot:hdc : _info:xc:yc:rot];}
		CGContextStrokePath(hdc);
	}
}


- (void)   DisegnaAffineSca    : (CGContextRef) hdc : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  {
 Vertice *a,*a0,*c,*d;
	if (b_scurva) {
		CGContextBeginPath(hdc);
		for (int i=0; i<VertControlList.count; i++) {  
			a = [Spezzata        objectAtIndex:i];
			if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;
			if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
			if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
			if (i==0) [a movetoSca:hdc :  _info:xc:yc:sca]; else {[a splinetoSca:hdc : _info:a0:c:d:xc:yc:sca]; }
        } 
		CGContextStrokePath(hdc);
	} else 
	{
		CGContextBeginPath(hdc);
		for (int i=0; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i];
			if (i==0) [a movetoSca:hdc :  _info:xc:yc:sca]; else [a linetoSca:hdc : _info:xc:yc:sca]; } 
		if ((b_chiusa) & (Spezzata.count>0)) { a= [Spezzata objectAtIndex:0]; [a linetoSca:hdc : _info:xc:yc:sca];}
		CGContextStrokePath(hdc);
	}
}

- (void)   DisegnaSpoRotSca     : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot : (double) sca  {
	Vertice *a,*a0,*c,*d;
	if (b_scurva) {
		CGContextBeginPath(hdc);
		for (int i=0; i<VertControlList.count; i++) {  
			a = [Spezzata        objectAtIndex:i];
			if (i>0) a0 = [Spezzata objectAtIndex:i-1]; else a0=a;
			if (i>0)                           c= [VertControlList objectAtIndex:i-1]; else c=a;
			if (i<[VertControlList count])     d= [VertControlList objectAtIndex:i];   else d=a;
			if (i==0) [a movetoSpoRotSca  :hdc : _info:xc:yc:rot:sca];
		  	     else [a splinetoSpoRotSca:hdc : _info:a0:c:d:xc:yc:rot:sca]; 
        } 
		CGContextStrokePath(hdc);
	} else 
	{
		CGContextBeginPath(hdc);
		for (int i=0; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i];
			if (i==0) [a movetoSpoRotSca:hdc :  _info:xc:yc:rot:sca]; 
			else [a linetoSpoRotSca:hdc : _info:xc:yc:rot:sca]; } 
		if ((b_chiusa) & (Spezzata.count>0)) { a= [Spezzata objectAtIndex:0];  [a linetoSpoRotSca:hdc : _info:xc:yc:rot:sca];  }
		if (b_chiusa )	CGContextEOFillPath(hdc);
				else	CGContextStrokePath(hdc);

		
		
	}
} 


- (void)   dispallinispline    : (CGContextRef) hdc : (InfoObj *) _info                                {
	if ([self cancellato]) return;
	if (!b_scurva) return;
	Vertice *a,  *b;
	CGContextSetLineWidth(hdc, 0.4 );
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];
		if (b_scurva) {
			b= [VertControlList objectAtIndex:i];
			[a discrocespline:hdc :_info:b];
		} // else {[a discroce:hdc :_info];}
	} 
}


- (void) DisegnaVtTutti        : (CGContextRef)  hdc : (InfoObj *) _info                               {
	if ([self cancellato]) return;
	Vertice *a;
	CGContextSetLineWidth(hdc, 0.4 );
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];
		[a dispallino:hdc:_info];
	} 
}

- (void) DisegnaVtFinali       : (CGContextRef)  hdc : (InfoObj *) _info                               {
	if ([self cancellato]) return;
	Vertice *a;
	CGContextSetLineWidth(hdc, 0.4 );
	if (Spezzata.count<=0) return;
	a= [Spezzata objectAtIndex:0];	                [a dispallinofinale:hdc:_info];
	a= [Spezzata objectAtIndex:(Spezzata.count-1)];	[a dispallinofinale:hdc:_info];

}


- (double) distsemplice : (double) x1 :(double) y1:(double) x2 :(double) y2                            {
	return hypot( (x2-x1), (y2-y1) );
}

- (double) distaptseg : (double) x1 :(double) y1:(double) x2 :(double) y2:(double) xpt :(double) ypt   {
	double ll; double ll2;
	
	x2=x2-x1;
	y2=y2-y1;
	xpt = xpt-x1;
	ypt = ypt-y1;
	x1=0;
	y1=0;
	
	
   double a = y2-y1;  double b = x1-x2;  double c = x2*y1-x1*y2;
	
	
	if	((a==0)	& (b==0)) {	ll = [self distsemplice :x1 :y1 :xpt :ypt] ;	return ll;	}
    if (a==0)	{   ll = fabs(ypt-y2); 	 return ll;   }
	if (b==0)	{   ll = fabs(xpt-x2); 	 return ll; 	}
	
   double deno=hypot(a,b);
	if (deno>0.001) {ll = (fabs(a*xpt+b*ypt+c)) / deno;	}
	else {
		ll  = [self distsemplice:x2:y2:xpt:ypt ];
		ll2 = [self distsemplice:x1:y1:xpt:ypt];
		if (ll>ll2) ll=ll2;
	}
	if ([self distsemplice:x1:y1:xpt:ypt ]<ll) ll=[self distsemplice:x1:y1:xpt:ypt ];
	return ll;
}


- (double)      lunghezza    {
    double locres =0;
	Vertice *a,  *b;
	for (int i=1; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:  i  ];		b= [Spezzata objectAtIndex:(i-1)];
		if ([a givemeifup]) continue;
		locres = locres + [self distsemplice :[a xpos] : [a ypos] : [b xpos] : [b ypos] ];
	}
	return locres;
}

- (double)      superficie   {
	double locsup =0;
	double localsup =0;

	bool sommare = YES;
	if (b_chiusa) {
 	  Vertice *a,  *b;
	  for (int i=1; i<Spezzata.count; i++) {  
		a = [Spezzata objectAtIndex:i-1];
		b = [Spezzata objectAtIndex:i];
	  	if ([b givemeifup]) { 
			
			if (localsup<0) localsup = -localsup;
			if (sommare) locsup = locsup+localsup; else locsup = locsup-localsup;
			localsup =0;
			sommare = NO;	continue;	
		}
		localsup = localsup + ( ([b xpos]-[a xpos])*(   (([b ypos]-limy1)  + ([a ypos])-limy1) )/2.0 );
	  }
		
				 	  a= [Spezzata objectAtIndex:Spezzata.count-1];			b= [Spezzata objectAtIndex:0];
					  localsup = localsup + ( ([b xpos]-[a xpos])*(   (([b ypos]-limy1)  + ([a ypos])-limy1) )/2.0 );

		
	 if (localsup<0) localsup = -localsup;
 	 if (sommare) locsup = locsup+localsup; else locsup = locsup-localsup;
	localsup =0;
	}
	
  return locsup;
}

- (double)      superficieconsegno   {
	double locsup =0;	
	if (b_chiusa) {
		Vertice *a,  *b;
		for (int i=1; i<Spezzata.count; i++) {  
			a = [Spezzata objectAtIndex:i-1];
			b = [Spezzata objectAtIndex:i];
			locsup = locsup + ( ([b xpos]-[a xpos])*(   (([b ypos]-limy1)  + ([a ypos])-limy1) )/2.0 );
		}
	}
	
	return locsup;
}



- (NSString *)  lunghezzastr                                   {
	NSString *str =@"";	
	str = [str stringByAppendingFormat:	 @"%1.2f",[self lunghezza]];	
	return str;
}

- (NSString *)  dimmitipostr                                   {
    if (b_scurva) {
		if (b_regione)  { return  @"SRegione";} else {
			if (b_chiusa) 	return @"Spoligono"; else 	return @"Splinea";
		}
	}	else {
		if (b_regione)  { return  @"Regione";} else {
			if (b_chiusa) 	return @"Poligono"; else 	return @"PoliLinea";
		}
	}
	return nil;	
}

- (NSString *)  nvtstr {
	NSString *str =@"";	
	str = [str stringByAppendingFormat:	 @"%d",[self numvt]];		
	return str;
}

- (NSString *)  supstr {
	NSString *str =@"";	
	str = [str stringByAppendingFormat:	 @"%1.2f",[self superficie]];	
	return str;
}



- (bool) OrtoInterno : (InfoObj *) _info: (double) x1 :(double) y1:(double) x2 :(double) y2:(double) xpt :(double) ypt   {
	double  deno1,xf,yf,xb2,yb2,xj,yj,xj2,yj2,yj3;
    double  angolo,	xsnaploc, ysnaploc ;
    bool   orto=NO;
    xf=x2-x1;  yf=y2-y1;
	
    if (xf==0)	{ if ( ((ypt>y1) & (ypt<y2)) | ((ypt>y2) & (ypt<y1)) ) { [_info setxysnap:x2:ypt]; orto=YES; } return orto; 	}
	if (yf==0)	{ if ( ((xpt>x1) & (xpt<x2)) | ((xpt>x2) & (xpt<x1)) ) { [_info setxysnap:xpt:y2]; orto=YES; } return orto; 	}
	
	if ((xf!=0) & (yf!=0)) 	{
 	 angolo = atan2(yf,xf);
	 xj  = sin(angolo)*xf; 
	 xb2 = xpt+xj; 
	 yj  = cos(angolo)*xf; 
	 yb2 = ypt-yj;
	 yj2 = ypt-yb2;
	 yj3 = yf*yj2; 
	 xj2 = xb2-xpt; 
	 deno1 = -(xf*yj2+xj2*yf);
	 if (deno1!=0)  {  ysnaploc = ( ((x1*yj3)-(xpt*yj3)-(y1*xf*yj2)-(ypt*xj2*yf)) / deno1);
	                   xsnaploc = ((((ysnaploc-y1)*(x2-x1)) / yf)+x1); }
	} else {
		if (xf==0) { xsnaploc=x1; ysnaploc=ypt; }
		if (yf==0) { ysnaploc=y1; xsnaploc=xpt; }
	}
	
	if ( ( ((xsnaploc>=x1) & (xsnaploc<=x2)) | ((xsnaploc<=x1) & (xsnaploc>=x2)) )	&
		 ( ((ysnaploc>=y1) & (ysnaploc<=y2)) | ((ysnaploc<=y1) & (ysnaploc>=y2)) ) )
	{ [_info setxysnap:xsnaploc:ysnaploc]; orto=YES; };
	return orto;
}

 
- (bool)  SnapFine      : (InfoObj *) _info:  (double) x1: (double) y1           {
	bool locres=NO;	double dx; 	double dy; 
	Vertice *a;
	double off  =  [ _info give_offsetmirino ];
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];
	    dx   =  (x1-[a xpos]); 	dy   =  (y1-[a ypos]); 
    	if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
		if ((dx<off) & (dy<off)) {	[_info setxysnap : [a xpos] : [a ypos]];  locres=YES;  break;}
	} 	
	return locres;
}
 
- (bool)  SnapVicino    : (InfoObj *) _info:  (double) x1: (double) y1           {
	bool locres=NO;	double dd;  double dx,dy;
	Vertice *a, *b;
	double off  =  [ _info give_offsetmirino ];

	for (int i=1; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:(i-1)];
		b= [Spezzata objectAtIndex:i];
		if ([b givemeifup]) continue;
		dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: x1 : y1 ];
        // calcolare dist segmento   // se poi orto allora ... altrimenti il finale 
		if (dd<off) {
			if ([self OrtoInterno: _info:[a xpos]:[a ypos]:[b xpos]:[b ypos]: x1 : y1 ]) {locres=YES; break;}  // DeltaVicinoInterno:=True;
			 else  {
				 dx   =  (x1-[a xpos]); 	dy   =  (y1-[a ypos]); 
				 if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				 if ((dx<off) & (dy<off)) {	[_info setxysnap : [a xpos] : [a ypos]];  locres=YES; break;}
				 dx   =  (x1-[b xpos]); 	dy   =  (y1-[b ypos]); 
				 if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				 if ((dx<off) & (dy<off)) {	[_info setxysnap : [b xpos] : [b ypos]];  locres=YES; break;}		 
			 }
		}
	} 	
	return locres;
}

- (int)  SnapCat          : (InfoObj *)     _info  : (double)     x1      : (double) y1 {
	int locres=-1;	double dd;  double dx,dy;
	Vertice *a, *b;
	double off  =  [ _info give_offsetmirino ];
	for (int i=1; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:(i-1)];
		b= [Spezzata objectAtIndex:i];
		if ([b givemeifup]) continue;
		dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: x1 : y1 ];
			// calcolare dist segmento   // se poi orto allora ... altrimenti il finale 
		if (dd<off) {
			if ([self OrtoInterno: _info:[a xpos]:[a ypos]:[b xpos]:[b ypos]: x1 : y1 ]) {
				if ((distsemplicefunz(x1, y1, [a xpos], [a ypos])<(distsemplicefunz(x1, y1, [b xpos], [b ypos]))))
					locres=i-1; else locres=i;
				break;}  // DeltaVicinoInterno:=True;
			else  {
				dx   =  (x1-[a xpos]); 	dy   =  (y1-[a ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [a xpos] : [a ypos]];  locres=i-1; break;}
				dx   =  (x1-[b xpos]); 	dy   =  (y1-[b ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [b xpos] : [b ypos]];  locres=i; break;}		 
			}
		}
	} 	
	return locres;
}


- (void)  ortosegmenta  : (InfoObj *) _info:  (double) x1: (double) y1           {
	Vertice *vt1, *vt2;

	vt1= [Spezzata objectAtIndex:([Spezzata count]-2)];
	vt2= [Spezzata objectAtIndex:([Spezzata count]-1)];
	double xp1 , yp1 , xp2 , yp2 ;
	xp1 = [vt1 xpos];	yp1 = [vt1 ypos];
	xp2 = [vt2 xpos];	yp2 = [vt2 ypos];
	
	double dd1 = hypot( (xp2-xp1) , (yp2-yp1) ); 
	 
	double a,b,c , diver;
    a     = yp2-yp1; 
    b     = xp1-xp2;  
	c     = yp1*xp2-xp1*yp2;
    diver = hypot(a,b);
	double dd = 0 ; 	if (diver==0) dd = 0; else dd = (a*x1+b*y1+c)/diver;
	
	double dx1 = (dd/dd1)*(yp2-yp1);
	double dy1 = (dd/dd1)*(xp2-xp1);
	 
	double xl = xp2+dx1;     double yl = yp2-dy1;
    [_info setxysnap:xl :yl];
}


- (void) seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati {
	bool locres=NO;	
	double dd;  double dx,dy;
	Vertice *a, *b;
	double off  =  [ _info give_offsetmirino ];
		//			NSLog(@"Off %1.2f",off);
	
	for (int i=1; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:(i-1)];
		b= [Spezzata objectAtIndex:i];
		if ([b givemeifup]) continue;
			//			dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: x1 : y1 ];
		
			dd =  distasegfunz   ([a xpos]  , [a ypos]  ,[b xpos] , [b ypos], x1 , y1 ); 

			//		NSLog(@"disto %1.2f  ",dd);
		
		
        // calcolare dist segmento   // se poi orto allora ... altrimenti il finale 
		if (dd<off) {
				//		NSLog(@"passo disto %1.2f  ",dd);
			
			
			if ([self OrtoInterno: _info:[a xpos]:[a ypos]:[b xpos]:[b ypos]: x1 : y1 ]) {locres=YES; break;}  // DeltaVicinoInterno:=True;
			else  {
				dx   =  (x1-[a xpos]); 	dy   =  (y1-[a ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [a xpos] : [a ypos]];  locres=YES; break;}
				dx   =  (x1-[b xpos]); 	dy   =  (y1-[b ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [b xpos] : [b ypos]];  locres=YES; break;}		 
			}
		}
	} 	
	
	if (locres) {
		[_LSelezionati addObject:self];
	}

}

- (void) seleziona_conPtInterno  : (CGContextRef)  hdc    : (InfoObj *) _info    : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati {
		//  se e' inteno al poligono -> ok
	bool locres=NO;	
	
	if ([self ptInterno : x1: y1 ]) locres=YES;

	
	if (locres) { [_LSelezionati addObject:self]; }
}



- (bool) Match_conPt      : (InfoObj *) _info   : (double) x1  : (double) y1       {
	bool locres=NO;	
	double dd;  double dx,dy;
	Vertice *a, *b;
	double off  =  [ _info give_offsetmirino ];
	
	for (int i=1; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:(i-1)];		b= [Spezzata objectAtIndex:i];
		if ([b givemeifup]) continue;
		dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: x1 : y1 ];
        // calcolare dist segmento   // se poi orto allora ... altrimenti il finale 
		if (dd<off) {
			if ([self OrtoInterno: _info:[a xpos]:[a ypos]:[b xpos]:[b ypos]: x1 : y1 ]) {locres=YES; break;}  // DeltaVicinoInterno:=True;
			else  {
				dx   =  (x1-[a xpos]); 	dy   =  (y1-[a ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [a xpos] : [a ypos]];  locres=YES; break;}
				dx   =  (x1-[b xpos]); 	dy   =  (y1-[b ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [b xpos] : [b ypos]];  locres=YES; break;}		 
			}
		}
	} 	
	return locres;
}

- (bool) selezionaVtconPt : (CGContextRef) hdc  : (InfoObj *) _info :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati {
	
	bool locres=NO;	
	double dd;  double dx,dy;
	Vertice *a, *b,*c1,*c2,*c3;
	double off  =  [ _info give_offsetmirino ];
	if (Spezzata.count<2) return NO;
	if (b_chiusa )	[self   chiudiconVtDown];
	
	int  indselected = 0;
	for (int i=1; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:(i-1)];
		b= [Spezzata objectAtIndex:i];
		if ([b givemeifup] ) continue;  // & (i<(Spezzata.count-1)) & (!b_regione)
		dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: x1 : y1 ];
        // calcolare dist segmento   // se poi orto allora ... altrimenti il finale 
		if (dd<off) {
			if ([self OrtoInterno: _info:[a xpos]:[a ypos]:[b xpos]:[b ypos]: x1 : y1 ]) {locres=YES; // DeltaVicinoInterno:=True;
				if ([self distsemplice :[a xpos]:[a ypos]:x1:y1] < [self distsemplice :[b xpos]:[b ypos]:x1:y1]) indselected=i-1; else indselected=i; break;} 
			else  {
				dx   =  (x1-[a xpos]); 	dy   =  (y1-[a ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [a xpos] : [a ypos]];  locres=YES; indselected=i-1; break;}
				dx   =  (x1-[b xpos]); 	dy   =  (y1-[b ypos]); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[_info setxysnap : [b xpos] : [b ypos]];  locres=YES; indselected=i; break;}		 
			}
		}
	} 	
 	
	if (locres) { [_LSelezionati addObject:self];	

		c1= [Spezzata objectAtIndex:indselected]; [_LSelezionati addObject:c1];	
		if (indselected>0)                  c2=[Spezzata objectAtIndex:indselected-1]; else c2=[Spezzata objectAtIndex:indselected];  [_LSelezionati addObject:c2];
		if (indselected<(Spezzata.count-1)) c3=[Spezzata objectAtIndex:indselected+1]; else c3=[Spezzata objectAtIndex:indselected];  [_LSelezionati addObject:c3];
		[_LSelezionati addObject:a];
		[_LSelezionati addObject:b];
	}
	return locres;
}

- (void) SpostaVerticeSelezionato :(NSMutableArray *) _LSelezionati    : (double) newx    : (double) newy {
	Vertice *a,*b,*c;
	double xold,yold;
	a = [ _LSelezionati objectAtIndex : 1 ];
	xold = [a xpos];	yold = [a ypos];
		// impostazione back
	int trovaindice=0;
	for (int k=0; k<[Spezzata count]; k++) { 
	  if ([a isEqual:[Spezzata objectAtIndex:k]]) {
  	    trovaindice=k;  [self ImpostaBack     : 1 : trovaindice : xold : yold ]; break;
	  }	}
		// impostazione back
	
	[a InitVertice:newx :newy]; 
	if (b_scurva) {
		for (int i=0; i<Spezzata.count; i++) { 
		 b= [Spezzata objectAtIndex:i];
		 if (a==b) {
			 c = [VertControlList objectAtIndex:i]; 
			 [c InitVertice:([c xpos]+(newx-xold) ) :([c ypos]+(newy-yold) )  ];
			 break;  }	}  }
		[self faiLimiti];
}

- (void) InserisciVerticeSelezionato :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy {
	Vertice *a,*b,*c,*d;
	a = [ _LSelezionati objectAtIndex : 4 ];
	for (int i=0; i<Spezzata.count; i++) {  b= [Spezzata objectAtIndex:i];
		if (a==b) {	c = [Vertice alloc]; [c InitVertice:newx:newy];	[Spezzata insertObject:c atIndex:i+1  ];
				// impostazione back
			[self ImpostaBack     : 2 : i+1 : 0 : 0 ]; 
				// impostazione back
			
			
			
			if (b_scurva) {
				d = [VertControlList objectAtIndex:i];
				c = [Vertice alloc]; [c InitVertice:newx+([d xpos]-[a xpos]):newy+([d ypos]-[a ypos])];
				[VertControlList insertObject:c atIndex:i+1  ];
			}
		break;	
	  }
	}
		[self faiLimiti];
}


- (void)   EditVerticeSelezionato      :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy {
	Vertice *a,*b,*c;
	a = [ _LSelezionati objectAtIndex : 1 ];
	if (b_scurva) {
		for (int i=0; i<Spezzata.count; i++) { 
			b= [Spezzata objectAtIndex:i];
			if (a==b) {
				c = [VertControlList objectAtIndex:i]; 
				[c InitVertice:newx:newy];
				break; 
			}
		}
	}
		[self faiLimiti];
}

- (void) CancellaVerticeSelezionato  :(NSMutableArray *) _LSelezionati           {
  Vertice *a,*b;
	a = [ _LSelezionati objectAtIndex : 1 ];
	for (int i=0; i<Spezzata.count; i++) {  b= [Spezzata objectAtIndex:i];	
		if (a==b) {	[Spezzata removeObjectAtIndex:i];
			[self ImpostaBack     : 3 : i : [a xpos] : [a ypos] ]; 
			[b release];
		  if (VertControlList.count>i) [VertControlList removeObjectAtIndex:i];
		break;	}	}
	if (Spezzata.count<2) b_erased=YES;
	[self faiLimiti];
}

- (void)   cancellaultimovt                                   {
	Vertice *a;
	a = [ Spezzata objectAtIndex : (Spezzata.count-1) ];
	[Spezzata removeObjectAtIndex:(Spezzata.count-1)];
	[a release];
	if (VertControlList.count>Spezzata.count) 
	{	a = [ VertControlList objectAtIndex : (VertControlList.count-1) ];
		[VertControlList removeObjectAtIndex: (VertControlList.count-1) ];
		[a release];	}
	
	[self faiLimiti]; // comprensivo che se numvt==0 si cancella
	
	
}



- (void) addvertex      :(double) x1: (double) y1:(int) flag  {
	Vertice *a;
	a = [Vertice alloc];
	[a InitVertice:x1:y1];	
	[Spezzata addObject:a];
	[self faiLimiti];
}

- (void)   addvertexnoUpdate  : (double) x1: (double) y1: (int) flag{
Vertice *a;
a = [Vertice alloc];
[a InitVertice:x1:y1];	
[Spezzata addObject:a];
}



- (void) addcontroll    :(double) x1: (double) y1             {
	Vertice *a;
	a = [Vertice alloc];	[a InitVertice:x1:y1];	[VertControlList addObject:a];

		[self faiLimiti];
}
- (void)   addvertexUp    : (double) x1: (double) y1 {
		//	b_regione = YES;
	Vertice *a;
	a = [Vertice alloc];
	[a InitVerticeUp:x1:y1];	
	[Spezzata addObject:a];
	lastVtUp = a;
		[self faiLimiti];
}

- (bool) addCatVertici  : (InfoObj *) _info :(double) x1: (double) y1 : (Vettoriale *) objvect {
	
	if ([objvect cancellato]) 
		NSLog(@"cancellato");
		
		//		return NO;
	bool resulta=NO;
	bool avanti =NO;
	bool seleavanti = NO;
	Vertice * a;	Vertice * b; Vertice * L;
	int postart=-1;
    int ndiffer=0;
	int posvt=[objvect SnapCat : _info  : x1  : y1 ];
		//	int startpos=-1;
	
	if (posvt>=0) {
		

		L = [Spezzata objectAtIndex:Spezzata.count-1];
		
		for (int i=0; i<[objvect numvt]-1; i++) {  
			b= [objvect verticeN:i];
		    if (([L xpos]==[b xpos]) & ([L ypos]==[b ypos])) { postart = i; break; }
		}
		
		if (postart<0) return NO;

		ndiffer = posvt-postart;
		
		if (ndiffer==0) { return NO; }
		if (ndiffer<0) { seleavanti=NO;	ndiffer=-ndiffer; } else {seleavanti=YES;  }
	
		if (ndiffer< (([objvect numvt]-1)/2)) avanti=YES; else avanti=NO;
	

			if (avanti) {
				if (seleavanti) {
					_info.numVtCorAdded=ndiffer-1;
					for (int k=postart+1; k<=posvt; k++) {  
						a = [objvect verticeN:k];  [self addvertex     : [a xpos]: [a ypos]:0];		resulta=YES;
					}
				} else {
					_info.numVtCorAdded=ndiffer-1;
					for (int k=postart-1; k>= posvt; k--) {  
						a = [objvect verticeN:k];  [self addvertex     : [a xpos]: [a ypos]:0];  	resulta=YES;
					}
				}
			} else {
				if (seleavanti) {
					for (int k=postart-1; k>=0; k--) {  
						a = [objvect verticeN:k];  [self addvertex     : [a xpos]: [a ypos]:0];		resulta=YES;
					}
					for (int k=[objvect numvt]-2; k>=posvt; k--) {  
						a = [objvect verticeN:k];  [self addvertex     : [a xpos]: [a ypos]:0];		resulta=YES;
					}
				}	else {
					for (int k=postart+1; k<[objvect numvt]; k++) {  
						a = [objvect verticeN:k];  [self addvertex     : [a xpos]: [a ypos]:0];		resulta=YES;
					}
					for (int k=1; k<=posvt; k++) {  
						a = [objvect verticeN:k];  [self addvertex     : [a xpos]: [a ypos]:0]; 	resulta=YES;
					}
				}
			}
	}
	
   if (resulta){
	   a = [self verticeN : ([self numvt ]-1)];
	   [_info setxysnap : [a xpos] : [a ypos] ];
   }
	return resulta;
}



- (int)  numvt                                          {
  return [Spezzata count];
}

- (int)  givemenumctrvt                                       { return [VertControlList count]; }



- (void) faiLimiti                                            {
	
	if (Spezzata.count==0) { [self cancella];return;}
	Vertice *a;
		//	if (b_regione) NSLog(@"s##à  %d",	Spezzata.count );

	for (int i=0; i<Spezzata.count; i++) { 
			//	if (b_regione) 		NSLog(@"#  %d",	i );

		
		a= [Spezzata objectAtIndex:i];
		if (i==0) {
		 limx1 = [a xpos];  limy1 = [a ypos];
		 limx2 = limx1;		      limy2 = limy1;
		} else 
		{
		 if (limx1>[a xpos]) limx1 = [a xpos];
		 if (limy1>[a ypos]) limy1 = [a ypos];
		 if (limx2<[a xpos]) limx2 = [a xpos];
		 if (limy2<[a ypos]) limy2 = [a ypos];
		}
	}
	
	
	if (b_scurva) {
		for (int i=0; i<VertControlList.count; i++) {  
			a= [VertControlList objectAtIndex:i];
			if (i==0) {
				limx1 = [a xpos];  limy1 = [a ypos];
				limx2 = limx1;		      limy2 = limy1;
			} else 
			{
				if (limx1>[a xpos]) limx1 = [a xpos];
				if (limy1>[a ypos]) limy1 = [a ypos];
				if (limx2<[a xpos]) limx2 = [a xpos];
				if (limy2<[a ypos]) limy2 = [a ypos];
			}
		}
		
	}
	
}

- (void) Sposta          : (double) dx :  (double) dy         {
	if (Spezzata.count<2) b_erased=YES;
	Vertice *a;
	for (int i=0; i<Spezzata.count; i++)        {  a= [Spezzata objectAtIndex:i];        [a Sposta:dx:dy];  } 
	for (int i=0; i<VertControlList.count; i++) {  a= [VertControlList objectAtIndex:i]; [a Sposta:dx:dy];  }
	[self faiLimiti];
} 

// [ Polyincostruzione addvertex:x1:y1:0 ];

- (Vettoriale *) Copia           : (double) dx :  (double) dy         {
	Polilinea *newpl;
	newpl = [Polilinea alloc];
	[newpl Init:_disegno : _piano];
	[newpl InitPolilinea:[self chiusa]];
	[[_piano  Listavector] addObject:newpl];

	[newpl setregione:b_regione];
	
	Vertice *a,*b;
	for (int i=0; i<Spezzata.count; i++) {  
	 a= [Spezzata objectAtIndex:i];
	 b= [Vertice alloc];
 	 [b CopiaconVt:a];	
	 [[newpl Spezzata] addObject:b];
	}

	if (b_scurva) {
		[newpl UpdatePolyInSpline];
		
		for (int i=0; i<VertControlList.count; i++) {  
			a= [VertControlList objectAtIndex:i];
			b= [Vertice alloc];
			[b CopiaconVt:a];	
			[[newpl VertControlList] addObject:b];
		}
		
	}
	[newpl faiLimiti];
	[self Sposta:dx:dy];
	return newpl;
} 

- (void) Ruota           : (double) xc :  (double) yc : (double) ang {
	[self Sposta:-xc :-yc];	[self Ruotaang:ang];	[self Sposta:xc :yc];
} 

- (void) Ruotaang        : (double) ang                       {
	Vertice *a;
	for (int i=0; i<Spezzata.count; i++)        {  a= [Spezzata objectAtIndex:i];        [a Ruotaang:ang];  } 
	for (int i=0; i<VertControlList.count; i++) {  a= [VertControlList objectAtIndex:i]; [a Ruotaang:ang];  }
} 

- (void) Scala           : (double) xc :  (double) yc : (double) scal {
    [self Sposta:-xc :-yc];	[self Scalasc:scal];	[self Sposta:xc :yc];
} 

- (void) Scalasc         : (double) scal                      {
	Vertice *a;
	for (int i=0; i<Spezzata.count; i++)        {  a= [Spezzata objectAtIndex:i];        [a Scalasc:scal];  } 
	for (int i=0; i<VertControlList.count; i++) {  a= [VertControlList objectAtIndex:i]; [a Scalasc:scal];  }
} 

- (void) CopiainLista    : (NSMutableArray *) inlista         {
	Polilinea *newpl;
	newpl = [Polilinea alloc];	[newpl Init:_disegno : _piano];	[newpl InitPolilinea:[self chiusa]];
	[inlista addObject:newpl];
	[newpl setregione:b_regione];
	Vertice *a,*b;
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];
		b= [Vertice alloc];
		[b CopiaconVt:a];	
		[[newpl Spezzata] addObject:b];
	}
	if (b_scurva) {
		[newpl UpdatePolyInSpline];
		for (int i=0; i<VertControlList.count; i++) {  
			a= [VertControlList objectAtIndex:i];
			b= [Vertice alloc];
			[b CopiaconVt:a];	
			[[newpl VertControlList] addObject:b];
		}
	}
	[newpl faiLimiti];
}

- (Polilinea *)  copiaPura {
	Polilinea *newpl;
	newpl = [Polilinea alloc];	[newpl Init:_disegno : _piano];	[newpl InitPolilinea:[self chiusa]];
	[[_piano  Listavector] addObject:newpl];
	[newpl setregione:b_regione];
	Vertice *a,*b;
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];	b= [Vertice alloc];	[b CopiaconVt:a];	[[newpl Spezzata] addObject:b];	}
	if (b_scurva) {
		[newpl UpdatePolyInSpline];
		for (int i=0; i<VertControlList.count; i++) {  
			a= [VertControlList objectAtIndex:i];		b= [Vertice alloc];		[b CopiaconVt:a];	[[newpl VertControlList] addObject:b];	}
	}
	[newpl faiLimiti];
	return newpl;	
}

- (Polilinea *)  copiaPuraNoaDisegno {
	Polilinea *newpl;
	newpl = [Polilinea alloc];	[newpl Init:_disegno : _piano];	[newpl InitPolilinea:[self chiusa]];
	[newpl setregione:b_regione];
	Vertice *a,*b;
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];	b= [Vertice alloc];	[b CopiaconVt:a];	[[newpl Spezzata] addObject:b];	}
	if (b_scurva) {
		[newpl UpdatePolyInSpline];
		for (int i=0; i<VertControlList.count; i++) {  
			a= [VertControlList objectAtIndex:i];		b= [Vertice alloc];		[b CopiaconVt:a];	[[newpl VertControlList] addObject:b];	}
	}
	[newpl faiLimiti];
	return newpl;	
}

- (Polilinea *)  copiaPuraPrimoPoligono {
	Polilinea *newpl;
	newpl = [Polilinea alloc];	[newpl Init:_disegno : _piano];	[newpl InitPolilinea:[self chiusa]];
	[newpl setregione:NO];
	Vertice *a,*b;
	for (int i=0; i<Spezzata.count; i++) {  
		a= [Spezzata objectAtIndex:i];   if (([a givemeifup]) & (i>0)) break;
		b= [Vertice alloc];	[b CopiaconVt:a];	[[newpl Spezzata] addObject:b];	
	}
	[newpl faiLimiti];
	return newpl;	
}

- (void) svuota                                               {
	Vertice *a;
	while (Spezzata.count>0) {
	  a = [ Spezzata objectAtIndex : (Spezzata.count-1) ];	
	  [Spezzata removeObjectAtIndex:(Spezzata.count-1)];
	  [a release];
	}
	while (VertControlList.count>0) {
		a = [ VertControlList objectAtIndex : (VertControlList.count-1) ];	
		[VertControlList removeObjectAtIndex:(VertControlList.count-1)];
		[a release];
	}
}


- (NSRect) dammilimiti                                        {
    NSRect resulta;
	resulta.origin.x    = limx1;
	resulta.origin.y    = limy1;
    resulta.size.width  = limx2-limx1;
	resulta.size.height = limy2-limy1;
	return resulta;
}

- (NSMutableArray *) Spezzata                                 {
	return Spezzata;
}

- (NSMutableArray *) VertControlList                          {
	return VertControlList;
}



- (void)               salvavettorialeMoM   :(NSMutableData *) _illodata  {
	if (b_chiusa) tipo=3; else tipo=2;
	
	[super salvavettorialeMoM:_illodata];

		//	[_illodata appendBytes:(const void *)&tipo length:sizeof(tipo)];
    int btest;
	if (b_regione) btest=1; else btest=0;
	[_illodata appendBytes:(const void *)&btest length:sizeof(btest)];
	if (b_scurva) btest=1; else btest=0;
	[_illodata appendBytes:(const void *)&btest length:sizeof(btest)];

	int numvt = [self numvt];
	[_illodata appendBytes:(const void *)&numvt length:sizeof(numvt)];
	Vertice *a; 	 double     x;	 double     y;	 double     z;	 bool    visibile;
	for (int i=0; i<numvt; i++) {  
		a= [Spezzata objectAtIndex:i];
		x = [a xpos];		y = [a ypos];			visibile = [a givemeifup];
		[_illodata appendBytes:(const void *)&x length:sizeof(x)];
		[_illodata appendBytes:(const void *)&y length:sizeof(y)];
		[_illodata appendBytes:(const void *)&z length:sizeof(z)];
		if (visibile) btest=1; else btest=0;
		[_illodata appendBytes:(const void *)&btest length:sizeof(btest)];
	}

	
	numvt = [self givemenumctrvt];
	[_illodata appendBytes:(const void *)&numvt length:sizeof(numvt)];
	for (int i=0; i<numvt; i++) {  
		a= [VertControlList objectAtIndex:i];
		x = [a xpos];		y = [a ypos];			
		[_illodata appendBytes:(const void *)&x length:sizeof(x)];
		[_illodata appendBytes:(const void *)&y length:sizeof(y)];
	}

	
}


- (NSUInteger) aprivettorialeMoM     : (NSData *) _data: (NSUInteger) posdata {
	posdata =[super aprivettorialeMoM :_data: posdata];
	int numvt;	int btest;
	[_data getBytes:&btest        range:NSMakeRange (posdata, sizeof(btest))  ];     posdata +=sizeof(btest);
	if (btest==1)  [self setregione:YES];
	[_data getBytes:&btest        range:NSMakeRange (posdata, sizeof(btest))  ];     posdata +=sizeof(btest);
	if (btest==1)  [self UpdatePolyInSpline];
	Vertice *a; 	 double     x;	 double     y;	 double     z;	 
	[_data getBytes:&numvt        range:NSMakeRange (posdata, sizeof(numvt))  ];     posdata +=sizeof(numvt);
	for (int i=0; i<numvt; i++) {  
		a = [Vertice alloc];		[Spezzata addObject:a];
		[_data getBytes:&x        range:NSMakeRange (posdata, sizeof(x))  ];     posdata +=sizeof(x);
		[_data getBytes:&y        range:NSMakeRange (posdata, sizeof(y))  ];     posdata +=sizeof(y);
		[_data getBytes:&z        range:NSMakeRange (posdata, sizeof(z))  ];     posdata +=sizeof(z);
		[_data getBytes:&btest        range:NSMakeRange (posdata, sizeof(btest))  ];     posdata +=sizeof(btest);
		[a InitVertice:x:y];		if (btest==1) [a setVtUp];
	}
	[_data getBytes:&numvt        range:NSMakeRange (posdata, sizeof(numvt))  ];     posdata +=sizeof(numvt);
	for (int i=0; i<numvt; i++) {  
		a = [Vertice alloc];		[VertControlList addObject:a];
		[_data getBytes:&x        range:NSMakeRange (posdata, sizeof(x))  ];     posdata +=sizeof(x);
		[_data getBytes:&y        range:NSMakeRange (posdata, sizeof(y))  ];     posdata +=sizeof(y);
		[a InitVertice:x:y];	
	}
		//	[self chiudiconVtDown];
	[self faiLimiti];
 return posdata;
}

- (NSString *) salvadxf                                      {
	NSString *risulta=@"";
	risulta = [risulta stringByAppendingString:@"  0\n"];
	risulta = [risulta stringByAppendingString:@"LWPOLYLINE\n"];
	risulta = [risulta stringByAppendingString:@"  8\n"];
	risulta = [risulta stringByAppendingString:[_piano givemenomepiano]];	risulta = [risulta stringByAppendingString:@"\n"];
	risulta = [risulta stringByAppendingString:@" 90\n"];
	risulta = [risulta stringByAppendingFormat:@"%9d" ,[self numvt]];	risulta = [risulta stringByAppendingString:@"\n"];
	risulta = [risulta stringByAppendingString:@" 70\n"];
	if (tipo==2) risulta = [risulta stringByAppendingFormat:@"%6d" ,0];	
  		    else risulta = [risulta stringByAppendingFormat:@"%6d" ,1];	
	risulta = [risulta stringByAppendingString:@"\n"];	
	Vertice *a;
	for (int i=0; i<Spezzata.count; i++) {  
			a= [Spezzata objectAtIndex:i];
		risulta = [risulta stringByAppendingString:@" 10\n"];
		risulta = [risulta stringByAppendingFormat:@"%1.2f" ,[a xpos]];  risulta = [risulta stringByAppendingString:@"\n"];
		risulta = [risulta stringByAppendingString:@" 20\n"];     
		risulta = [risulta stringByAppendingFormat:@"%1.2f" ,[a ypos]];  risulta = [risulta stringByAppendingString:@"\n"];
	} 
	
	return risulta;	
	
}

- (void) CatToUtm  : (InfoObj *) _info                       {
	Vertice *a;
	for (int i=0; i<Spezzata.count; i++) {  a= [Spezzata objectAtIndex:i];	[a CatToUtm : _info];  } 
}

- (void) addvertexUpHereToStart  {
    Vertice *a;    Vertice *b;
    if (Spezzata.count<=0) return;
    b = [Spezzata objectAtIndex:0];
    a = [Vertice alloc];	[a InitVerticeUp:[b xpos]:[b ypos]];		[Spezzata addObject:a];
}

- (void) togliVtDoppi            {
		//	 		  NSLog(@"off ");
	Vertice *V1, *V2;
	for (int i=1; i<Spezzata.count; i++) {
	  V1 = [Spezzata objectAtIndex:i-1];
	  for (int j=i; j<Spezzata.count; j++) {
		V2 = [Spezzata objectAtIndex:j];
		  if ((i==1) & (j==Spezzata.count-1)) continue;
		  if (( (fabs([V1 xpos]-[V2 xpos]))<0.01 ) & ( (fabs([V1 ypos]-[V2 ypos]))<0.01 ) ) {	[Spezzata removeObjectAtIndex:j];j--;
				  //		   NSLog(@"off %1.2f  %1.2f",[V1 xpos],[V1 ypos]);
		  } 
		     else break;
	  }
	}
}


- (void) updateRegione           {  // riorienta i poligoni interni per giusta grafica ;
	if (!b_regione) return;  // risistemare questo punto !!!!!!!!!!!!!!!!!!!!!!!  da rendere attivo invece che saltarlo
    double   localsup=0;
    int Indlastvt=0;
   
	Vertice *a,  *b;
        for (int i=1; i<Spezzata.count; i++) {  
            a = [Spezzata objectAtIndex:i-1];
            b = [Spezzata objectAtIndex:i];
			Indlastvt=i;
            if ([b givemeifup]) { Indlastvt=i-1; break; }
            localsup = localsup + ( ([b xpos]-[a xpos])*([b ypos]+[a ypos])/2 );
        }
    if (localsup<0) {   [self rigiraspezzata : 0 : Indlastvt]; 
		
			//		NSLog(@"rigiro per sup<0 %d",Indlastvt);
			// if (b_scurva) [self Srigiraspezzata : 0 : Indlastvt]; 
	
	}  // cosi' il primo poligono e' positivo
   int newstart=Indlastvt+1;
    bool fatto=NO;
    while (!fatto) {
        if ( newstart>=Spezzata.count-1) {
			fatto=YES;	break;	
		}        
        localsup=0;
        for (int i=newstart+1; i<Spezzata.count; i++) {  
            a = [Spezzata objectAtIndex:i-1];
            b = [Spezzata objectAtIndex:i];
			
			Indlastvt=i;
            if ([b givemeifup]) { Indlastvt=i-1; break; }
            localsup = localsup + ( ([b xpos]-[a xpos])*([b ypos]+[a ypos])/2 );
            
            if (i==Spezzata.count-1) fatto=YES;
        }
		
			//		NSLog(@"S %1.2f",localsup);
		
		if (localsup>0) { 
				//		NSLog(@"rigiro interno per sup>0");

			[self rigiraspezzata : newstart+1 : Indlastvt];  }  // cosi' il secondo poligono e' negativo
           //    NSLog(@"rig %d %d",newstart,Indlastvt-newstart);

         newstart=Indlastvt+1;
    }
    
    
    
}

- (void) rigiraspezzata : (int) indp1 : (int) indp2 {
    int diff = (indp2-indp1)/2;
    Vertice *a00; 		a00 = [Spezzata objectAtIndex:indp1]; 
    Vertice *a01; 		a01 = [Spezzata objectAtIndex:indp2]; 
	if ([a00 givemeifup]) [a01 setVtUp];
	[a00 setVtDown];
	
    Vertice *a1;    Vertice *a2;
	for (int i=0 ; i<=diff; i++) {
        a1 = [Spezzata objectAtIndex:indp1+i];
        a2 = [Spezzata objectAtIndex:indp2-i];
        [Spezzata removeObjectAtIndex:indp1+i];   [Spezzata insertObject:a2 atIndex:indp1+i];
        [Spezzata removeObjectAtIndex:indp2-i];   [Spezzata insertObject:a1 atIndex:indp2-i];
    }
}

- (void) Srigiraspezzata : (int) indp1 : (int) indp2 {
    int diff = (indp2-indp1)/2;
    Vertice *a1;    Vertice *a2;
    for (int i=0 ; i<=diff; i++) {
        a1 = [VertControlList objectAtIndex:indp1+i];
        a2 = [VertControlList objectAtIndex:indp2-i];
        [VertControlList removeObjectAtIndex:indp1+i];   [VertControlList insertObject:a2 atIndex:indp1+i];
        [VertControlList removeObjectAtIndex:indp2-i];   [VertControlList insertObject:a1 atIndex:indp2-i];
    }
}

- (void) rigiraspezzataTotale    {
	NSArray *Spezzatamom;
	Spezzatamom = [[NSArray alloc] initWithArray:Spezzata];
	[Spezzata removeAllObjects];
	Vertice * vt;
	for (int i=[Spezzatamom count]-1; i>0; i--) {
		vt = [Spezzatamom objectAtIndex:i];
		[Spezzata addObject:vt];
	}
	
	
}


- (void) partedavtindice :(int) starter {
	Vertice * vt;
	[self chiudiconVtDown];
	[Spezzata removeObjectAtIndex:Spezzata.count-1];

	for (int i=starter-1; i>=0; i--) {
		vt = [Spezzata objectAtIndex:0];
		[Spezzata addObject:vt];
		[Spezzata removeObjectAtIndex:0];
	}
	[self chiudiconVtDown];
}



- (void) chiudiconVtSeAperta     {
    Vertice *a1;    Vertice *a2;
    a1 = [Spezzata objectAtIndex:0];
    a2 = [Spezzata objectAtIndex:Spezzata.count-1];
    if (([a1 xpos]!=[a2 xpos]) | ([a1 ypos]!=[a2 ypos]) ) {
          a2 = [Vertice alloc];	[a2 InitVerticeUp:[a1 xpos]:[a1 ypos]];		[Spezzata addObject:a2];
    }
    
}

- (void) chiudiconVtDown         {
    Vertice *a1;    Vertice *a2;
    a1 = [Spezzata objectAtIndex:0];
    a2 = [Spezzata objectAtIndex:Spezzata.count-1];
    if (([a1 xpos]!=[a2 xpos]) | ([a1 ypos]!=[a2 ypos]) ) {
		a2 = [Vertice alloc];	[a2 InitVertice:[a1 xpos]:[a1 ypos]];		[Spezzata addObject:a2];
    }
    
}


- (void) chiudiSeChiusa          {
    Vertice *a1;    Vertice *a2;
    a1 = [Spezzata objectAtIndex:0];
    a2 = [Spezzata objectAtIndex:Spezzata.count-1];
    if (([a1 xpos]==[a2 xpos]) & ([a1 ypos]==[a2 ypos]) ) { b_chiusa=YES; tipo  = 3; }
}

- (void) Cambia1PoligonoaRegione {  // da fare ricostruendo la lista poligoni.
    if (b_regione) {
    int Indlastvt=0;
    Vertice *a;
    for (int i=0; i<Spezzata.count; i++) {  
      a = [Spezzata objectAtIndex:i];
      if ([a givemeifup]) { Indlastvt=i; break; }
    }
        if (Indlastvt>0) {
            Indlastvt = Indlastvt+1;
        }
        
        [self updateRegione];
    }
}



- (bool) OrtoInternoNoInfo :  (double) x1 :(double) y1:(double) x2 :(double) y2:(double) xpt :(double) ypt   {
	bool orto=NO;
    bool inx=NO;
    bool iny=NO;
	if (  (xpt>(x1-0.01))  & ( xpt < (x2+0.01) ) ) inx=YES;
	if (  (xpt>(x2-0.01))  & ( xpt < (x1+0.01) ) ) inx=YES;
	
	if (  (ypt>(y1-0.01))  & ( ypt < (y2+0.01) ) ) iny=YES;
	if (  (ypt>(y2-0.01))  & ( ypt < (y1+0.01) ) ) iny=YES;
	
	if (inx & iny ) orto=YES;
	
	return orto;
}


- (void) addvicini : (Polilinea *) polext {
	Vertice * vt1;
	Vertice * vtnew;
	Vertice *a, *b;
    double dd,dx,dy;
	
	for (int i=0; i<[[polext Spezzata] count]; i++) {
		vt1 = [[polext Spezzata] objectAtIndex:i];
		
		
		for (int j=1; j<[Spezzata count]; j++) {

			a= [Spezzata objectAtIndex:(j-1)];	b= [Spezzata objectAtIndex:j];
				// se vicino al vertice riappoggia e finisce li
			dx   =  fabs([vt1 xpos]-[a xpos]); 	dy   =  fabs([vt1 ypos]-[a ypos]); 
			if ((dx==0) & (dy==0)) break;
			if ((dx<0.01) & (dy<0.01)) { [vt1 InitVertice:[a xpos] :[a ypos] ];	break; }

			dx   =  fabs([vt1 xpos]-[b xpos]); 	dy   =  fabs([vt1 ypos]-[b ypos]); 
			if ((dx==0) & (dy==0)) break;
			if ((dx<0.01) & (dy<0.01)) { [vt1 InitVertice:[b xpos] :[b ypos] ];	break; }
				//	NSLog(@"Connesso %1.2f %1.2f %d %d", [vt1 xpos], [vt1 ypos], i,j );
			
			if ([b givemeifup]) {	// NSLog(@"Upper %1.2f %1.2f %d %d", [vt1 xpos], [vt1 ypos], i,j);		
				continue;			}
			dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: [vt1 xpos] : [vt1 ypos] ];
	
			
		    if (dd<0.01){
				if ([self OrtoInternoNoInfo: [a xpos]:[a ypos]:[b xpos]:[b ypos]: [vt1 xpos] : [vt1 ypos] ]) { 
					 vtnew = [Vertice alloc]; 	[vtnew InitVertice : [vt1 xpos] : [vt1 ypos]]; 
						[Spezzata insertObject:vtnew atIndex:j]; j++;
						//					 NSLog(@"+ %1.2f  %1.2f %1.2f %d",dd ,[vt1 xpos] , [vt1 ypos] ,j);  
				} 
			}
				//           if (writeit)	{  NSLog(@"+ %1.2f  %1.2f %1.2f %d",dd ,[a xpos] , [a ypos] ,j);   }	

		}

			// se fossero mai in mancanza di una chiusura reale o in penup
		if ([Spezzata count]>2) {
			a= [Spezzata objectAtIndex:0];	b= [Spezzata objectAtIndex:[Spezzata count]-1];
			if ( ([a xpos]!=[b xpos]) |  ([a ypos]!=[b ypos]) ) {
				dx   =  fabs([vt1 xpos]-[a xpos]); 	dy   =  fabs([vt1 ypos]-[a ypos]); 
				if ((dx==0) & (dy==0)) continue;
				if ((dx<0.01) & (dy<0.01)) { [vt1 InitVertice:[a xpos] :[a ypos] ];	continue; }
				dx   =  fabs([vt1 xpos]-[b xpos]); 	dy   =  fabs([vt1 ypos]-[b ypos]); 
				if ((dx==0) & (dy==0)) continue;
				if ((dx<0.01) & (dy<0.01)) { [vt1 InitVertice:[b xpos] :[b ypos] ];	continue; }
				
				
				
			dd = [self distaptseg : [a xpos]: [a ypos]: [b xpos]:[b ypos]: [vt1 xpos] : [vt1 ypos] ];
			if (dd<0.01){
				if ([self OrtoInternoNoInfo: [a xpos]:[a ypos]:[b xpos]:[b ypos]: [vt1 xpos] : [vt1 ypos] ]) { 
					vtnew = [Vertice alloc]; 	[vtnew InitVertice : [vt1 xpos] : [vt1 ypos]]; 
															    [Spezzata addObject:vtnew ]; 
						//		NSLog(@"++ %1.2f  %1.2f %1.2f subente:%d",dd ,[vt1 xpos] , [vt1 ypos],[Spezzata count] );  

				}	
			 }
		   }
		}
		
		
	}
	
	
	
	
}

@end
