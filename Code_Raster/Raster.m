//
//  Raster.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Raster.h"
// #import "GIS2010AppDelegate.h"
#import "funzioni.h"


@implementation Raster


- (void)        InitRaster  :(NSString *) _nomefile  : (InfoObj *) _info   {
	
	info=_info;
    [NomefileRaster release]; NomefileRaster = [[NSString alloc] initWithString:_nomefile]; [NomefileRaster retain];
	f_anglerot        = 0.0;
	f_alpha           = 1.0;
	scalax   = 1.0;                	scalay   = scalax;
	Escalax  =1.0;	Escalay  =1.0;
	Eanglerot =0.0;
	
	xorigine = 0;
	yorigine = 0;
	b_visibile        = YES;
	b_masheracolore   = NO;
	i_mascheraBianco  = 0;
	
	coloredelBlack = [NSColor blackColor];
	
	NSString *estensione = [_nomefile pathExtension];
	NSRange myrange;
	myrange.location=0;
	myrange.length = 3;
	if ([estensione compare:@"pdf" options:NSCaseInsensitiveSearch range:myrange] ==0)  {
		float scalapdfv = 2.0;
		PDFView       *  locpdf= [info pdf];
	
		[locpdf setHidden:NO];
			
		
		PDFDocument *pdfDoc;
		pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: _nomefile]];
		[locpdf setDocument:pdfDoc];	[locpdf setShouldAntiAlias:NO];
					[locpdf setScaleFactor:scalapdfv];
			//	[locpdf setScaleFactor:12.0];
	
		NSPDFImageRep   *pdfRep;
		NSRect          frame;
		
	
		pdfRep = [NSPDFImageRep imageRepWithContentsOfFile: _nomefile];
			//		  NSImage         *pdfImage;
			//		pdfImage = [[NSImage alloc] init];
			//		[pdfImage addRepresentation: pdfRep];
			//		CGImageRef		imageref ;

			//		NSRect       *JproposedDestRect;
			//		NSGraphicsContext *Jcontext; 
			//		NSDictionary *Jhints;
			//	imageref = [pdfRep  CGImageForProposedRect:JproposedDestRect  context:Jcontext hints: Jhints];

			//		return;
		
			//				NSLog(@" H %d", [pdfRep pixelsHigh]);
			//		NSLog(@" A %d", [locpdf shouldAntiAlias]);
		
			//		[locpdf setShouldAntiAlias:YES];
			//		NSLog(@" A %d", [locpdf shouldAntiAlias]);
	
		
		frame = [pdfRep bounds];
		frame.size.width=frame.size.width*scalapdfv;
		frame.size.height=frame.size.height*scalapdfv;
					[locpdf setFrame:frame];
					[locpdf setBounds:frame];	
		
			//	[locpdf 		
			//
		NSBitmapImageRep *_fanta;  
		NSRect RR;
		RR = [locpdf bounds];
		_fanta = [locpdf bitmapImageRepForCachingDisplayInRect:RR];
		[ locpdf cacheDisplayInRect:RR toBitmapImageRep:_fanta];
		imageref = CGImageCreateCopy([_fanta CGImage]);

		dimx = CGImageGetWidth (imageref);
		dimy = CGImageGetHeight(imageref);
		
			[locpdf setHidden:YES];

			//        [pdfRep release];
	}
	
	
	if (imageref==nil) {
		NSURL *      url = [NSURL fileURLWithPath: _nomefile];
		CGImageSourceRef    isr = CGImageSourceCreateWithURL( (CFURLRef)url, NULL);
     if (isr)
		{
		 imageref = CGImageSourceCreateImageAtIndex(isr, 0, NULL);
	 if (imageref) {
			 imgProp = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(isr, 0, (CFDictionaryRef)imgProp);
			 imgUTType = (NSString*)CGImageSourceGetType(isr);
			 [imgUTType retain];
			 [imgProp retain];
           dimx = CGImageGetWidth (imageref);
		   dimy = CGImageGetHeight(imageref);
		 }
			
		 CFRelease(isr);
		}
	}

	NSString      * CollaNomefileRaster1;
    NSString      * CollaNomefileRaster2;
    CollaNomefileRaster1 = NomefileRaster;
	
	CollaNomefileRaster2 = [CollaNomefileRaster1 stringByPaddingToLength:([CollaNomefileRaster1 length]-1) withString: @"w" startingAtIndex:0];

	NSString      * CollaNomefileRaster;
    CollaNomefileRaster = [CollaNomefileRaster2 stringByAppendingString:@"w"];
	

	NSArray *Righeconf = [self righetestofile : CollaNomefileRaster];
	
	bool calibrato = NO;
	
	if ([Righeconf count]>4 ) {
		xorigine  = [[Righeconf objectAtIndex:0] doubleValue];
		yorigine  = [[Righeconf objectAtIndex:1] doubleValue];
		scalax    = [[Righeconf objectAtIndex:2] doubleValue];
		scalay    = [[Righeconf objectAtIndex:3] doubleValue];
		f_anglerot= [[Righeconf objectAtIndex:4] doubleValue];
		Exorigine =xorigine;
		Eyorigine =yorigine;
		Escalax = scalax;
		Escalay = scalay;
		Eanglerot = f_anglerot;
		calibrato = YES;
		
	}
    else {
	 xorigine  = [info xorigineVista];	yorigine  = [info yorigineVista];
	}

		// aggiunta per il caso in cui ci sia il tfw
	if (!calibrato) {
		NSString      * nomecolRast;
		nomecolRast = [NomefileRaster stringByDeletingPathExtension];
			//		NSLog(@"- - - %@",nomecolRast);
		NSString      * nomecolRast2;
		nomecolRast2 = [[NSString alloc] initWithFormat:@"%@%@",nomecolRast,@".tfw"];
			//		NSLog(@"- - * %@",nomecolRast2);
		NSArray *Righeco = [self righetestofile : nomecolRast2];
		
		if (Righeco !=nil) {
			for (int i=0; i<[Righeco count]; i++) {
					//				NSLog(@"* * * -%d- %@",i,[Righeco objectAtIndex:i ]);
					//				NSLog(@"-%d- %1.2f",i,[[Righeco objectAtIndex:i ] floatValue]);
				if (i==0) {scalax    = [[Righeco objectAtIndex:i ] doubleValue]; scalay = scalax; }
				if (i==4) {xorigine    = [[Righeco objectAtIndex:i ] doubleValue]+2020000;  }
				if (i==5) {yorigine    = [[Righeco objectAtIndex:i ] doubleValue]-dimy*scalay;  }
			}
		}
		
			//		NSLog(@"* * * %d %@",[Righeco count],Righeco);
		

	}

	
	
	b_sfondobianco =YES;
 
}

- (NSArray  *) righetestofile : (NSString *) nomefile {
	NSFileHandle *fileHandle;
	NSMutableString *buffer;
	fileHandle = [NSFileHandle fileHandleForReadingAtPath:nomefile];
	if (fileHandle==nil) return nil;
	NSData *data = [fileHandle availableData];
        //	NSLog(@"Data %lu",[data length]);
	
	NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // 	NSLog(@"str %lu",[str length]);
	
	buffer =[[NSMutableString alloc] init];
	[buffer appendString:str];
	[str release];
	return [buffer componentsSeparatedByString:@"\n"];
}



- (void)        InitRasterImgRef  :(CGImageRef)   _imgref                  {
	imageref = CGImageCreateCopy ( _imgref  );
//	Iimage = [[CIImage alloc]initWithCGImage:imageref];
	dimx = CGImageGetWidth (imageref);
	dimy = CGImageGetHeight(imageref);
	
		//	NomefileRaster = @"Mom";

}


- (void)       impostaUndoTutto  : (NSUndoManager  *) MUndor {
	Escalax=scalax;	        Escalay=scalay;
	Exorigine=xorigine;     Eyorigine=yorigine;
	Eanglerot=f_anglerot;
	[[MUndor prepareWithInvocationTarget:self] EseguiUndoTutto];
}

- (void)       impostaUndoOrigine  : (NSUndoManager  *) MUndor {
	Exorigine=xorigine;     Eyorigine=yorigine;
	[[MUndor prepareWithInvocationTarget:self] EseguiUndoOrigine];
}

- (void)       impostaUndoScala    : (NSUndoManager  *) MUndor {
	Escalax=scalax;	        Escalay=scalay;
	[[MUndor prepareWithInvocationTarget:self] EseguiUndoScala];
}

- (void)       impostaUndoAngolo   : (NSUndoManager  *) MUndor {
	Eanglerot=f_anglerot;
	[[MUndor prepareWithInvocationTarget:self] EseguiUndoAngolo];
}


- (void)       EseguiUndoTutto                                             {
	scalax=Escalax;	        scalay=Escalay;
	xorigine=Exorigine;     yorigine=Eyorigine;
	f_anglerot=Eanglerot;
}

- (void)       EseguiUndoOrigine                                           {
	xorigine=Exorigine;     yorigine=Eyorigine;
	
}

- (void)       EseguiUndoScala                                             {
	scalax=Escalax;	        scalay=Escalay;
}

- (void)       EseguiUndoAngolo                                            {
	f_anglerot=Eanglerot;
}



// settaggi
- (double)      xscala                                                     {
	return scalax;
}
- (double)      yscala                                                     {
	return scalay;
}
- (double)      Exscala  {
	return Escalax;
}

- (double)      limx1                                                      {	return limx1;	}
- (double)      limy1                                                      {	return limy1;	}
- (double)      limx2                                                      {	return limx2;	}
- (double)      limy2                                                      {	return limy2;	}
- (double)      xorigine                                                   {
	return xorigine;
}
- (double)      yorigine                                                   {
	return yorigine;
}
- (double)      dimx                                                       {
	return dimx;
}
- (double)      dimy                                                       {
	return dimy;
}
- (double)      angolo                                                     {
	return f_anglerot;
}
- (double)     Eanglerot {
	return Eanglerot;
}

- (float)       alpha                                                      {
	return f_alpha;
}
- (bool)        visibile                                                   {
	return b_visibile;
}
- (NSString *)  nomefile                                                   {
	return  [NomefileRaster lastPathComponent];
}
- (NSString *)  nomefilenoExt  {
	return [ [NomefileRaster lastPathComponent]	stringByDeletingPathExtension];
}

- (NSString *)  interonomefile                                             {
	return NomefileRaster;
}
- (CGImageRef)  ImgRef                                                     {
	return imageref;
}
- (NSDictionary *) ImgProp                                                 {
	return imgProp;
}
- (NSString *)  imgUTType                                                  {
	return imgUTType;
}
- (NSColor      *) coloredelBlack {
	return coloredelBlack;
}

// azioni

- (void)        RemoveRaster                                               {
	CGImageRelease (imageref);
	info=nil;
	[imgProp release];
	[imgUTType release];
	[NomefileRaster release];
}
- (void)        updateLimiti                                               {
	double locx1 , locy1;
	double locx2 , locy2;
	double locx3 , locy3;

	limx1 = xorigine;            	limy1 = yorigine; 
	limx2 = xorigine;            	limy2 = yorigine; 
    // basso dx
	locx1  = xorigine+dimx*scalax*cos(f_anglerot);
	locy1  = yorigine+dimx*scalay*sin(f_anglerot);

	if (locx1<limx1) limx1=locx1;	if (locx1>limx2) limx2=locx1;
	if (locy1<limy1) limy1=locy1;	if (locy1>limy2) limy2=locy1;
	// alto sx
	locx2  = xorigine+dimy*scalax*cos(M_PI/2+f_anglerot);
	locy2  = yorigine+dimy*scalay*sin(M_PI/2+f_anglerot);
	if (locx2<limx1) limx1=locx2;	if (locx2>limx2) limx2=locx2;
	if (locy2<limy1) limy1=locy2;	if (locy2>limy2) limy2=locy2;

    locx3  = locx1+locx2-xorigine;
	locy3  = locy1+locy2-yorigine;
	if (locx3<limx1) limx1=locx3;	if (locx3>limx2) limx2=locx3;
	if (locy3<limy1) limy1=locy3;	if (locy3>limy2) limy2=locy3;

}
- (void)        updateInfoConLimiti                                        {
	[self updateLimiti];
	[info  setLimitiRas  : limx1 : limy1 : limx2 : limy2 ];
}
- (void)        setvisibile           :(bool)  modo                        {
	b_visibile=modo;
}
- (void)        setalpha              :(float) alpha                       {
	f_alpha=alpha;
}
- (void)        setmaskabile          :(bool)  modo : (int) _white         {
	b_masheracolore=modo;
	i_mascheraBianco = _white;
}
- (void)        setcolorefondo        :(int)   _col                        {
	i_colorefondo=_col;
}

- (void)        Disegna               :(CGContextRef) hdc                  {
	if (!b_visibile) return;
	[self updateLimiti];

	if (limx1 > [info x2origineVista] )         {	return;	}
	if (limy1 > [info y2origineVista] )         {	return;	}

	if (limx2 < [info xorigineVista])          {	return;	}
	if (limy2 < [info yorigineVista])          {	return;	}
	
	double xr1, xr2,yr1,yr2;

	xr1 = (xorigine - [info xorigineVista])/ [info scalaVista] ; // anche lo scala raster
	yr1 = (yorigine - [info yorigineVista])/ [info scalaVista] ;
	xr2 = xr1+(dimx * scalax)                       / [info scalaVista];
	yr2 = yr1+(dimy * scalay)                       / [info scalaVista];	
	
	CGContextSaveGState (hdc);

	if (f_anglerot!=0) {
		CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( f_anglerot );
		CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -xr1 ,-yr1 );
		CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  xr1 , yr1 );
		CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trRot );
		CGAffineTransform trAll2  = CGAffineTransformConcat          ( trAll , tr1 );
        CGContextConcatCTM (hdc	, trAll2 );
	}
	CGRect destarect;
	CGRect sRect;

	destarect.origin.x=xr1; 	destarect.origin.y=yr1;
	destarect.size.width  = xr2-xr1;	
	destarect.size.height = yr2-yr1;	
	
	sRect.origin.x=0;	        sRect.origin.y=0;
	sRect.size.width  = dimx;	sRect.size.height = dimy;
	
		//////////////////////////////////
	
/*
	CGImageRef myMaskedImage;
	const CGFloat myMaskingColors[8] = { 255, 255, 255, 255, 255, 255 };
	myMaskedImage = CGImageCreateWithMaskingColors (imageref, myMaskingColors);
	CGContextDrawImage (hdc, destarect, myMaskedImage);
*/	

		//	CGContextSetAllowsAntialiasing (hdc, NO);
		//	CGContextSetShouldAntialias(hdc, NO);

	
    if (b_masheracolore) {	
					if (i_mascheraBianco>0)	CGContextSetBlendMode (hdc, kCGBlendModeMultiply); 	   
					            else		CGContextSetBlendMode (hdc, kCGBlendModeLighten); 
	   }
	CGContextDrawImage  (hdc,destarect,imageref);   
 
		//	CGContextSetAllowsAntialiasing (hdc, YES);
		//	CGContextSetShouldAntialias(hdc, YES);

	if (b_masheracolore) { 		CGContextDrawImage  (hdc,destarect,imageref);   	}

   CGContextRestoreGState ( hdc );
}


- (void)        disegnarasterino      :(CGContextRef) hdc : (NSRect) fondo {
	double rapx,rapy,rap;
	rapx = dimx/fondo.size.width;
	rapy = dimy/fondo.size.height;
	
	if (rapx<rapy) rap=rapy; else rap=rapx;
	CGRect destarect;
	CGRect sRect;

	destarect.size.width  = dimx/rap;	
	destarect.size.height = dimy/rap;	

	destarect.origin.x=0; 	
	if (rapx<rapy) { destarect.origin.x= (fondo.size.width-dimx/rap)/2; }
	destarect.origin.y=0;
	if (rapy<rapx) { destarect.origin.y= (fondo.size.height-dimy/rap)/2; }

	sRect.origin.x=0;
	sRect.origin.y=0;
	sRect.size.width  = dimx;
	sRect.size.height = dimy;
	
	CGContextDrawImage  (hdc,destarect,imageref);
	
}


- (void)        SpostaOrigine         :(double) _dx      :(double) _dy     {
	xorigine=xorigine+_dx;
	yorigine=yorigine+_dy;
	if ([info rasterautosave])	[self SalvaInfoRaster];
}

- (void)        ruota                 :(double) _angle                     {
	f_anglerot = _angle;
}

- (void)        setscalaDisraster     : (double) sca_x : (double) sca_y    {
	scalax = scalax/sca_x;
	scalay = scalay/sca_y;
	if ([info rasterautosave])	[self SalvaInfoRaster];
}

- (void)        setscalaDisraster1                                         {
	scalax = 1;
	scalay = 1;
}


- (void)        CropConPoligono       :(NSMutableArray *) _List            {
	Polilinea *_pol;	_pol =nil;
	Vettoriale *objvector;
	for (int i=0; i<_List.count; i++) {  
		objvector= [_List objectAtIndex:i];
		if ([objvector dimmitipo]==3) { _pol=[_List objectAtIndex:i]; break; }
	}
	if (_pol ==nil) {	NSBeep();		 return;	}
	NSImage *ImgOrigine;
	ImgOrigine = [[NSImage alloc] initWithContentsOfFile:NomefileRaster];
	NSSize _size;
	_size.width  = (float)dimx;
	_size.height = (float)dimy;
	[ImgOrigine setSize:_size];
	
	Polilinea * _polint;
	_polint = [Polilinea alloc]; [_polint InitPolilinea:YES];
    double xvt,yvt;
	double newx, newy;  double backangolo=-f_anglerot; double offx1, offy1;
	
	
	if (f_anglerot!=0) {
		for (int i=0; i<[_pol numvt]; i++) {  
			xvt = [_pol dammixPuntoInd:i];			yvt = [_pol dammiyPuntoInd:i];
			offx1=xvt-xorigine;		    offy1=yvt-yorigine;
			newx= offx1*cos(backangolo)-offy1*sin(backangolo);
			newy= offx1*sin(backangolo)+offy1*cos(backangolo);
			xvt=newx+xorigine;		        yvt=newy+yorigine;			
			[_polint addvertex  :xvt: yvt: 0];
		}
	} else { _polint=_pol;	}
	
	
	[_polint faiLimiti];
	
	NSRect pollimiti = [_polint dammilimiti];
	double xornew=pollimiti.origin.x;
	double yornew=pollimiti.origin.y;
	
		//	if (f_anglerot!=0) {
		offx1=xornew-xorigine;		    offy1=yornew-yorigine;
        if (offx1<0) {offx1=0;}
        if (offy1<0) {offy1=0;}
		newx= offx1*cos(f_anglerot)-offy1*sin(f_anglerot);
		newy= offx1*sin(f_anglerot)+offy1*cos(f_anglerot);
		xornew=newx+xorigine;		        yornew=newy+yorigine;				
		//    }

	
	pollimiti.origin.x=((pollimiti.origin.x-xorigine)/scalax);
	pollimiti.origin.y=((pollimiti.origin.y-yorigine)/scalay);
	pollimiti.size.width =pollimiti.size.width/scalax;
	pollimiti.size.height=pollimiti.size.height/scalay;
	
	if (pollimiti.origin.x<0) { pollimiti.size.width =pollimiti.size.width +pollimiti.origin.x;  pollimiti.origin.x=0; };
	if (pollimiti.origin.y<0) { pollimiti.size.height=pollimiti.size.height+pollimiti.origin.y;  pollimiti.origin.y=0; };
	
	long offoutx;
	offoutx = dimx-(pollimiti.origin.x+ pollimiti.size.width);
	if (offoutx<0) pollimiti.size.width=pollimiti.size.width+offoutx;
	
	
	long offouty;
	offouty = dimy-(pollimiti.origin.y+ pollimiti.size.height);
	if (offouty<0) pollimiti.size.height=pollimiti.size.height+offouty;
	
	NSSize locsize;
	locsize = [ImgOrigine size];
	
		//		pollimiti.size.width =  pollimiti.size.width-2;
	
	NSImage  *newImage = [[NSImage alloc] initWithSize:pollimiti.size];  
	
	
	NSBezierPath *croppingPath = [NSBezierPath bezierPath];
	NSPoint pt;
	
		// qui immettere la spezzata in coordinate pixel raster
	for (int i=0; i<[_polint numvt]; i++) {  
		pt.x=(CGFloat)[_polint dammixPuntoInd:i];
		pt.y=(CGFloat)[_polint dammiyPuntoInd:i];
			// ora ritrasformali in coordinate immagine
		pt.x=(float)((([_polint dammixPuntoInd:i]-xorigine)/scalax)-pollimiti.origin.x);
		pt.y=(float)((([_polint dammiyPuntoInd:i]-yorigine)/scalay)-pollimiti.origin.y);
 		if (i==0) [croppingPath moveToPoint:pt]; else  [croppingPath lineToPoint:pt];
	}
	[croppingPath closePath];
	
	[newImage lockFocus];
		//
		//		[[NSColor blackColor] set];
		//

			[[NSColor whiteColor] set];

		[croppingPath fill];
	
	pollimiti.origin.x = pollimiti.origin.x+1;
	pollimiti.origin.y = pollimiti.origin.y+1;
	
	[ImgOrigine drawAtPoint:NSZeroPoint      fromRect:pollimiti operation:NSCompositeSourceIn fraction:1.0];
	[newImage unlockFocus];
	
	NSSavePanel *   savePanel;
    savePanel = [NSSavePanel savePanel];
	IKSaveOptions * saveOptions;
	saveOptions = [[IKSaveOptions alloc] initWithImageProperties:NULL imageUTType: NULL];
		//	saveOptions = [[IKSaveOptions alloc] initWithImageProperties: metaData imageUTType: utType];
	[saveOptions addSaveOptionsAccessoryViewToSavePanel: savePanel];

	NSURL *url = [NSURL URLWithString: [[self nomefile] stringByDeletingLastPathComponent]];
	[savePanel setDirectoryURL:url];
	
	[savePanel setTitle:@"Salva Immagine Ritagliata"];
	
	[savePanel setNameFieldStringValue:[self nomefile]];
	[savePanel runModal];
	CGImageRef imageorigine = [newImage CGImageForProposedRect:NULL context:NULL hints:NULL];
	NSString * newUTType = [saveOptions imageUTType];
	
	NSURL *               url2 = [NSURL fileURLWithPath: [savePanel filename]];
	CGImageDestinationRef dest = CGImageDestinationCreateWithURL((CFURLRef)url2, (CFStringRef)newUTType, 1, NULL);
	if (dest)
	{
		CGImageDestinationAddImage(dest, imageorigine, (CFDictionaryRef)[saveOptions imageProperties]);
		CGImageDestinationFinalize(dest);
		CFRelease(dest);
	}
	
		// -----------------  salvataggio file collaterale
	NSString *nomefile;
	nomefile =[savePanel filename];
	nomefile = 	[nomefile stringByPaddingToLength:([nomefile length]-1) withString: @"w" startingAtIndex:0];
	nomefile = [nomefile stringByAppendingString:@"w"];
	NSString *Str;
	pollimiti = [_pol dammilimiti];
	Str = @"";                                 	Str = [Str stringByAppendingFormat:	 @"%12f",xornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",yornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalax];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalay];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",f_anglerot];
	[Str writeToFile :nomefile atomically:YES encoding:NSASCIIStringEncoding error:NULL];
	
	
}

- (void)        CropConRettangolo     :(NSMutableArray *) _List            {
    
    if (f_anglerot!=0) { [self CropConPoligono : _List  ];   return;  }
    
	Polilinea *_pol;
	_pol =nil;
	Vettoriale *objvector;
	for (int i=0; i<_List.count; i++) {  
		objvector= [_List objectAtIndex:i];
		if ([objvector dimmitipo]==3) { _pol=[_List objectAtIndex:i]; break; }
	}
	if (_pol ==nil) return;
	[_pol faiLimiti];
	CGRect RR;
	RR.origin.x    = (([_pol limx1]-xorigine)/scalax);	     RR.origin.y = (([_pol limy1]-yorigine)/scalax);
    RR.size.width  = ( [_pol limx2]-  [_pol limx1] ) /scalax;
    RR.size.height = ( [_pol limy2]-  [_pol limy1] ) /scalax;
	RR.origin.y    = (dimy -  RR.origin.y) - RR.size.height ;
	CGImageRef imma = CGImageCreateWithImageInRect (imageref, RR );
	NSSavePanel *   savePanel;
    savePanel = [NSSavePanel savePanel];
	IKSaveOptions * saveOptions;
	saveOptions = [[IKSaveOptions alloc] initWithImageProperties:NULL imageUTType: NULL];
		//	saveOptions = [[IKSaveOptions alloc] initWithImageProperties: metaData imageUTType: utType];
	[saveOptions addSaveOptionsAccessoryViewToSavePanel: savePanel];
	[savePanel setTitle:@"Salva Immagine Ritagliata"];

	NSURL *url = [NSURL URLWithString: [[self nomefile] stringByDeletingLastPathComponent]];
	[savePanel setDirectoryURL:url];

	
	[savePanel setNameFieldStringValue:[self nomefile]];
	[savePanel runModal];
		//	CGImageRef imageorigine = [newImage CGImageForProposedRect:NULL context:NULL hints:NULL];
	NSString * newUTType = [saveOptions imageUTType];
	NSURL *               url2 = [NSURL fileURLWithPath: [savePanel filename]];
	CGImageDestinationRef dest = CGImageDestinationCreateWithURL((CFURLRef)url2, (CFStringRef)newUTType, 1, NULL);
	if (dest)
	{
		CGImageDestinationAddImage(dest, imma, (CFDictionaryRef)[saveOptions imageProperties]);
		CGImageDestinationFinalize(dest);
		CFRelease(dest);
	}
		// -----------------  salvataggio file collaterale
	NSString *nomefile;
	nomefile =[savePanel filename];
	nomefile = 	[nomefile stringByPaddingToLength:([nomefile length]-1) withString: @"w" startingAtIndex:0];
	nomefile = [nomefile stringByAppendingString:@"w"];
	NSString *Str;
	double xornew=[_pol limx1];
	double yornew=[_pol limy1];
		// attenzione al fatto che il taglio possa essere esterno	
	RR.origin.x    = (([_pol limx1]-xorigine)/scalax);	     RR.origin.y = (([_pol limy1]-yorigine)/scalax);
	Str = @"";                                 	Str = [Str stringByAppendingFormat:	 @"%12f",xornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",yornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalax];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalay];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",f_anglerot];
	[Str writeToFile :nomefile atomically:YES encoding:NSASCIIStringEncoding error:NULL];
}


- (void)        MaskConPoligono       :(NSMutableArray *) _List 
									  :(double) _xorig: (double) _yorig
									  :(double) _scalx :(double) _scaly    {
	Polilinea *_pol;
	_pol =nil;
	Vettoriale *objvector;
	for (int i=0; i<_List.count; i++) {  
		objvector= [_List objectAtIndex:i];
		if ([objvector dimmitipo]==3) { _pol=[_List objectAtIndex:i]; break; }
	}
	if (_pol ==nil) return;
	
	NSImage *ImgOrigine;
	ImgOrigine = [[NSImage alloc] initWithContentsOfFile:NomefileRaster];
	NSSize _size;
	_size.width  = (float)dimx;
	_size.height = (float)dimy;
	[ImgOrigine setSize:_size];
	NSRect aRect;
	aRect.origin.x=0;	aRect.origin.y=0;
	aRect.size=_size;
	NSImage  *newImage = [[NSImage alloc] initWithSize:_size];  
	NSBezierPath *croppingPath = [NSBezierPath bezierPathWithRect:aRect];
	NSPoint pt;
	
	Polilinea * _polint;
	_polint = [Polilinea alloc]; [_polint InitPolilinea:YES];
    double xvt,yvt;
	double newx, newy;  double backangolo=-f_anglerot; double offx1, offy1;
	if (f_anglerot!=0) {
		for (int i=0; i<[_pol numvt]; i++) {  
			xvt = [_pol dammixPuntoInd:i];			yvt = [_pol dammiyPuntoInd:i];
			offx1=xvt-xorigine;		    offy1=yvt-yorigine;
			newx= offx1*cos(backangolo)-offy1*sin(backangolo);
			newy= offx1*sin(backangolo)+offy1*cos(backangolo);
			xvt=newx+xorigine;		        yvt=newy+yorigine;			
			[_polint addvertex  :xvt: yvt: 0];
		}
	} else { _polint=_pol;	}
	
	
	
	// qui immettere la spezzata in coordinate pixel raster
	for (int i=0; i<[_polint numvt]; i++) {  
		pt.x=(CGFloat)[_polint dammixPuntoInd:i];
		pt.y=(CGFloat)[_polint dammiyPuntoInd:i];
		// ora ritrasformali in coordinate immagine
		pt.x=(float)(([_polint dammixPuntoInd:i]-xorigine)/scalax);
		pt.y=(float)(([_polint dammiyPuntoInd:i]-yorigine)/scalay);
 		if (i==0) [croppingPath moveToPoint:pt]; else  [croppingPath lineToPoint:pt];
	}
	[croppingPath closePath];
	[newImage lockFocus];
	[[NSColor blackColor] set];
	[croppingPath fill];
	[ImgOrigine drawAtPoint:NSZeroPoint      fromRect:aRect    operation:NSCompositeSourceIn fraction:1.0];
	[newImage unlockFocus];
	NSSavePanel *savePanel;
    savePanel = [NSSavePanel savePanel];
	IKSaveOptions * saveOptions;
	saveOptions = [[IKSaveOptions alloc] initWithImageProperties:NULL imageUTType: NULL];
	[saveOptions addSaveOptionsAccessoryViewToSavePanel: savePanel];
	[savePanel setTitle:@"Salva Immagine Mascherata"];

	NSURL *url = [NSURL URLWithString: [[self nomefile] stringByDeletingLastPathComponent]];
	[savePanel setDirectoryURL:url];

	
	[savePanel setNameFieldStringValue:[self nomefile]];
	[savePanel runModal];
	CGImageRef imageorigine = [newImage CGImageForProposedRect:NULL context:NULL hints:NULL];
	NSString    *newUTType  = [saveOptions imageUTType];
	NSURL       *url2       = [NSURL fileURLWithPath: [savePanel filename]];
	
		
	CGImageDestinationRef dest = CGImageDestinationCreateWithURL((CFURLRef)url2, (CFStringRef)newUTType, 1, NULL);
	if (dest)
	{
		CGImageDestinationAddImage(dest, imageorigine, (CFDictionaryRef)[saveOptions imageProperties]);
		CGImageDestinationFinalize(dest);
		CFRelease(dest);
	}
	
	// -----------------  salvataggio file collaterale
	NSString *nomefile;
	nomefile =[savePanel filename];
	nomefile = 	[nomefile stringByPaddingToLength:([nomefile length]-1) withString: @"w" startingAtIndex:0];
	nomefile = [nomefile stringByAppendingString:@"w"];
	NSString *Str;
	Str = @"";                                 	Str = [Str stringByAppendingFormat:	 @"%12f",xorigine];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",yorigine];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalax];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalay];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",f_anglerot];
	[Str writeToFile :nomefile atomically:YES encoding:NSASCIIStringEncoding error:NULL];
	
}

- (void)        trovaottopar2 : (double) x1 : (double)y1 : (double)x2: (double)y2: (double)x3 :(double)y3 :(double)x4 :(double)y4 
				        	  : (double) e1 : (double)n1 : (double)e2: (double)n2 :(double)e3 :(double)n3 :(double)e4 :(double)n4   {

	double alfa,beta,gamma,alfa1,beta1,gamma1 ;
    double parte1,parte2 ;
    double Delta,DeltaSU ;
    double _aaa,__aaaa   ;

	
    parte1 = ((y3-y1)*(x2-x1) - (y2-y1)*(x3-x1));   
    parte2 = ((y4-y1)*(x2-x1) - (y2-y1)*(x4-x1));

    _aaa   =   ( (( (e1*x1)-(e4*x4))*(x2-x1)-((e1*x1)-(e2*x2))*(x4-x1)) * parte1);
    __aaaa =   ( (( (e1*x1)-(e3*x3))*(x2-x1)-((e1*x1)-(e2*x2))*(x3-x1)) * parte2);
    alfa   = _aaa - __aaaa;

    beta   =   ( ((e1*y1-e4*y4)*(x2-x1)-(e1*y1-e2*y2)*(x4-x1)) * parte1)
             - ( ((e1*y1-e3*y3)*(x2-x1)-(e1*y1-e2*y2)*(x3-x1)) * parte2);
    gamma  =   ( ((e4-e1)*(x2-x1)-(e2-e1)*(x4-x1)) * parte1) - ( ((e3-e1)*(x2-x1)-(e2-e1)*(x3-x1)) * parte2);
    alfa1  =   ( ((n1*x1-n4*x4)*(x2-x1)-(n1*x1-n2*x2)*(x4-x1)) * parte1) - ( ((n1*x1-n3*x3)*(x2-x1)-(n1*x1-n2*x2)*(x3-x1)) * parte2);

    beta1  =   ( ((n1*y1-n4*y4)*(x2-x1)-(n1*y1-n2*y2)*(x4-x1)) * parte1) - ( ((n1*y1-n3*y3)*(x2-x1)-(n1*y1-n2*y2)*(x3-x1)) * parte2);
    gamma1 =   ( ((n4-n1)*(x2-x1)-(n2-n1)*(x4-x1)) * parte1)  - ( ((n3-n1)*(x2-x1)-(n2-n1)*(x3-x1)) * parte2);
	
    Delta  =   alfa*beta1-beta*alfa1;
    coef[6]=   ( (gamma*beta1-beta*gamma1) / Delta );
    coef[7]=   ( (alfa*gamma1-gamma*alfa1) / Delta );
	

    alfa  =    n1*(1+x1*coef[6]+y1*coef[7]);
    beta  =    n2*(1+x2*coef[6]+y2*coef[7]);
    gamma =    n3*(1+x3*coef[6]+y3*coef[7]);

    Delta = x1*(y2-y3)-y1*(x2-x3)+((x2*y3)-(y2*x3));

    DeltaSU = (alfa*(y2-y3))-(y1*(beta-gamma))+((beta*y3)-(y2*gamma));     
	coef[3] = DeltaSU/Delta;
    DeltaSU = (x1*(beta-gamma))-(alfa*(x2-x3))+((x2*gamma)-(beta*x3));     
	coef[4] = DeltaSU/Delta;
    DeltaSU = (x1*(y2*gamma-beta*y3))-(y1*(x2*gamma-beta*x3))+(alfa*(x2*y3-y2*x3));     
	coef[5] = DeltaSU/Delta;

    alfa    = e1*(1+(x1*coef[6])+(y1*coef[7]));
    beta    = e2*(1+(x2*coef[6])+(y2*coef[7]));
    gamma   = e3*(1+(x3*coef[6])+(y3*coef[7]));

    DeltaSU = (alfa*(y2-y3))-(y1*(beta-gamma))+((beta*y3)-(y2*gamma));     
	coef[0] = DeltaSU/Delta;
    DeltaSU = (x1*(beta-gamma))-(alfa*(x2-x3))+((x2*gamma)-(beta*x3));     
	coef[1] = DeltaSU/Delta;
    DeltaSU = (x1*((y2*gamma)-(beta*y3)))-(y1*((x2*gamma)-(beta*x3)))+(alfa*((x2*y3)-(y2*x3)));     
	coef[2] = DeltaSU/Delta;

}

- (void)        Calibra8pt    : (double)_x1: (double)_y1: (double)_x2: (double)_y2: (double)_x3: (double)_y3: (double)_x4: (double)_y4 
                              : (double)_x5: (double)_y5: (double)_x6: (double)_y6: (double)_x7: (double)_y7: (double)_x8: (double)_y8 
                              : (NSLevelIndicator   *) LevelIndicatore {
	double xvt,yvt;
	double newx, newy;  double backangolo=-f_anglerot; double offx1, offy1;
	if (f_anglerot!=0) {
		xvt = _x1;			yvt = _y1;
		offx1=xvt-xorigine;		    offy1=yvt-yorigine;
		newx= offx1*cos(backangolo)-offy1*sin(backangolo);
		newy= offx1*sin(backangolo)+offy1*cos(backangolo);
		_x1=newx+xorigine;		        _y1=newy+yorigine;	
		xvt = _x2;			yvt = _y2;
		offx1=xvt-xorigine;		    offy1=yvt-yorigine;
		newx= offx1*cos(backangolo)-offy1*sin(backangolo);
		newy= offx1*sin(backangolo)+offy1*cos(backangolo);
		_x2=newx+xorigine;		        _y2=newy+yorigine;			
		xvt = _x3;			yvt = _y3;
		offx1=xvt-xorigine;		    offy1=yvt-yorigine;
		newx= offx1*cos(backangolo)-offy1*sin(backangolo);
		newy= offx1*sin(backangolo)+offy1*cos(backangolo);
		_x3=newx+xorigine;		        _y3=newy+yorigine;			
		xvt = _x4;			yvt = _y4;
		offx1=xvt-xorigine;		    offy1=yvt-yorigine;
		newx= offx1*cos(backangolo)-offy1*sin(backangolo);
		newy= offx1*sin(backangolo)+offy1*cos(backangolo);
		_x4=newx+xorigine;		        _y4=newy+yorigine;			
	} 
	
		////   correzione per alti numeri
/*
 double xxmin, yymin;
	xxmin= _x1;	if (_x2<xxmin) xxmin=_x2;	if (_x3<xxmin) xxmin=_x3;	if (_x4<xxmin) xxmin=_x4;
	if (_x5<xxmin) xxmin=_x5;	if (_x6<xxmin) xxmin=_x6;	if (_x7<xxmin) xxmin=_x7;	if (_x8<xxmin) xxmin=_x8;
	yymin= _y1;	if (_y2<xxmin) xxmin=_y2;	if (_y3<xxmin) xxmin=_y3;	if (_y4<xxmin) xxmin=_y4;
	if (_y5<xxmin) xxmin=_y5;	if (_y6<xxmin) xxmin=_y6;	if (_y7<xxmin) xxmin=_y7;	if (_y8<xxmin) xxmin=_y8;

	_x1 = _x1-xxmin;	_x2 = _x2-xxmin;	_x3 = _x3-xxmin;	_x4 = _x4-xxmin;
	_x5 = _x5-xxmin;	_x6 = _x6-xxmin;	_x7 = _x7-xxmin;	_x8 = _x8-xxmin;

	_y1 = _y1-yymin;	_y2 = _y2-yymin;	_y3 = _y3-yymin;	_y4 = _y4-yymin;
	_y5 = _y5-yymin;	_y6 = _y6-yymin;	_y7 = _y7-yymin;	_y8 = _y8-yymin;
	
	xorigine = xorigine-xxmin;
	yorigine = yorigine-yymin;
*/
		////
	
	
	
	
	[self trovaottopar2 :_x1:_y1:_x2:_y2:_x3:_y3:_x4:_y4:   _x5:_y5:_x6:_y6:_x7:_y7:_x8 :_y8];


	double x1o = xorigine;     
	double y1o = yorigine;
    double x2o = xorigine + dimx*scalax;
	double y2o = yorigine + dimy*scalay;
	double x1n = ((coef[0]*x1o+coef[1]*y1o+coef[2]) / (coef[6]*x1o+coef[7]*y1o+1 )) ;
    double y1n = ((coef[3]*x1o+coef[4]*y1o+coef[5]) / (coef[6]*x1o+coef[7]*y1o+1 )) ;
    double x2n = ((coef[0]*x2o+coef[1]*y1o+coef[2]) / (coef[6]*x2o+coef[7]*y1o+1 )) ;
    double y2n = ((coef[3]*x2o+coef[4]*y1o+coef[5]) / (coef[6]*x2o+coef[7]*y1o+1 )) ;
    double x3n = ((coef[0]*x2o+coef[1]*y2o+coef[2]) / (coef[6]*x2o+coef[7]*y2o+1 )) ;
    double y3n = ((coef[3]*x2o+coef[4]*y2o+coef[5]) / (coef[6]*x2o+coef[7]*y2o+1 )) ;
	double x4n = ((coef[0]*x1o+coef[1]*y2o+coef[2]) / (coef[6]*x1o+coef[7]*y2o+1 )) ;
	double y4n = ((coef[3]*x1o+coef[4]*y2o+coef[5]) / (coef[6]*x1o+coef[7]*y2o+1 )) ;
	
//-----------	
	
 	
	double xmn  = x1n;
	if (x2n<xmn) xmn = x2n;  
	if (x3n<xmn) xmn = x3n;  
	if (x4n<xmn) xmn = x4n;
    double ymn  = y1n;
	if (y2n<ymn) ymn = y2n;  
	if (y3n<ymn) ymn = y3n;  
	if (y4n<ymn) ymn = y4n;
    double xman = x1n;
	if (x2n>xman) xman = x2n;  
	if (x3n>xman) xman = x3n;  
	if (x4n>xman) xman = x4n;
	double yman=y1n;
	if (y2n>yman) yman = y2n;
	if (y3n>yman) yman = y3n;
	if (y4n>yman) yman = y4n;
	
    double scalaXN = (xman-xmn)/dimx;
    double scalaYN = (yman-ymn)/dimy;
	
    int XX = dimx;
    int YY = dimy;
	
	
	
	
	NSBezierPath *croppingPath = [NSBezierPath bezierPath];
	NSPoint aPt;
	aPt.x=(x1n-xmn)/scalaXN;	aPt.y=(y1n-ymn)/scalaYN; 	[croppingPath moveToPoint:aPt];
	aPt.x=(x2n-xmn)/scalaXN;	aPt.y=(y2n-ymn)/scalaYN; 	[croppingPath lineToPoint:aPt];
	aPt.x=(x3n-xmn)/scalaXN;	aPt.y=(y3n-ymn)/scalaYN; 	[croppingPath lineToPoint:aPt];
	aPt.x=(x4n-xmn)/scalaXN;	aPt.y=(y4n-ymn)/scalaYN; 	[croppingPath lineToPoint:aPt];
	[croppingPath closePath];


	
	
    double k1a = (coef[0]-coef[2]*coef[6]);
    double k2a = (coef[5]*coef[6]-coef[3]);
    double k3a = (coef[3]*coef[2]-coef[5]*coef[0]);
	
    double k4a = (coef[1]*coef[6]-coef[0]*coef[7]);
    double k5a = (coef[3]*coef[7]-coef[4]*coef[6]);
    double k6a = (coef[4]*coef[0]-coef[3]*coef[1]);
	
	
	
	NSImage *ImgOrigine;
	ImgOrigine = [[NSImage alloc] initWithContentsOfFile:NomefileRaster];
	NSSize _size;
	_size.width  = (float)dimx;
	_size.height = (float)dimy;
	[ImgOrigine setSize:_size];
	
	NSRect aRect;
	aRect.origin.x=0;	aRect.origin.y=0;
	aRect.size=_size;
	
	NSImage  *newImage = [[NSImage alloc] initWithSize:_size];  
		// correzione per grandi numeri
		//	xorigine = xorigine+xxmin;
		//	yorigine = yorigine+yymin;
		////
	
	
	[newImage lockFocus];
	//  * le due righe 
	[[NSColor blackColor] set];
	[croppingPath fill];
    //  * le due righe 
	
	
	double yrealpos;    	double xrealpos;
	double ybackRealpos;	double xbackRealpos;
	int xpos;    	    int ypos;
 
    NSPoint _spt;
	NSRect bRect;
	bRect.origin.x=0;	bRect.origin.y=0;
	bRect.size.width=1; bRect.size.height=1;

	for (int ky=1; ky<=YY; ky++) {
		
		int newind = (int)( (ky*200)/YY);
		if (newind > [LevelIndicatore intValue]) {	[LevelIndicatore setIntValue: newind ];	[LevelIndicatore display];	}
			//   NSLog(@"%d",ky);
	 yrealpos = yman-ky*scalaYN;
		
	 for (int kx=1; kx<=XX; kx++) {
			xrealpos = xmn+kx*scalaXN;
		    ybackRealpos = (double) (yrealpos*k1a+xrealpos*k2a+k3a)/(yrealpos*k4a+xrealpos*k5a+k6a);
 	        xbackRealpos = (double) (ybackRealpos*(coef[4]-yrealpos*coef[7]) +(coef[5]-yrealpos) ) /	(yrealpos*coef[6]-coef[3]);
	        xpos = (int)( (xbackRealpos-xorigine)/scalax);
	        ypos = (int)( (ybackRealpos-yorigine)/scalay);
		 _spt.x=kx; _spt.y=YY-ky;
		 bRect.origin.x=xpos;		bRect.origin.y=ypos;
		 if ( ((xpos<0) | (xpos>=dimx))	|	((ypos<0) | (ypos>=dimy))   )	{ 	}	 else    { 
			 [ImgOrigine drawAtPoint:_spt      fromRect:bRect    operation:NSCompositeSourceIn fraction:1.0];	
			}
		};
	}
	
	[newImage unlockFocus];
	
	
	
	NSSavePanel *   savePanel;
    savePanel = [NSSavePanel savePanel];
	IKSaveOptions * saveOptions;
	saveOptions = [[IKSaveOptions alloc] initWithImageProperties:NULL imageUTType: NULL];
	[saveOptions addSaveOptionsAccessoryViewToSavePanel: savePanel];
	[savePanel setTitle:@"Salva Immagine Calibrata 8 pt"];
	
	NSURL *url = [NSURL URLWithString: [[self nomefile] stringByDeletingLastPathComponent]];
	[savePanel setDirectoryURL:url];
	
	[savePanel setNameFieldStringValue:[self nomefile]];
	[savePanel runModal];
	CGImageRef imageorigine = [newImage CGImageForProposedRect:NULL context:NULL hints:NULL];
	NSString * newUTType = [saveOptions imageUTType];
	NSURL *               url2 = [NSURL fileURLWithPath: [savePanel filename]];
	CGImageDestinationRef dest = CGImageDestinationCreateWithURL((CFURLRef)url2, (CFStringRef)newUTType, 1, NULL);
	if (dest)
	{
		CGImageDestinationAddImage(dest, imageorigine, (CFDictionaryRef)[saveOptions imageProperties]);
		CGImageDestinationFinalize(dest);
		CFRelease(dest);
	}
	
	
	
	// -----------------  salvataggio file collaterale
	NSString *nomefile;
	nomefile =[savePanel filename];
	nomefile = 	[nomefile stringByPaddingToLength:([nomefile length]-1) withString: @"w" startingAtIndex:0];
	// Results in "ab"
	nomefile = [nomefile stringByAppendingString:@"w"];
	
	double xornew=xmn;
	double yornew=ymn;
	NSString *Str;
	double _angolo=0.0;
	Str = @"";                                 	Str = [Str stringByAppendingFormat:	 @"%12f",xornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",yornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalaXN];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalaYN];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",_angolo];
	[Str writeToFile :nomefile atomically:YES encoding:NSASCIIStringEncoding error:NULL];
 
}

- (void)        rotoscala     :(double)i_x1coord :(double) i_y1coord :(double)i_x2coord :(double) i_y2coord 
				              :(double)i_x3coord :(double) i_y3coord :(double)i_x4coord :(double) i_y4coord                         {
	// se ruotato riaggiornare i punti sulla immagine x1,y1 e x2,y2
	
	if (f_anglerot!=0) {
	double offx1, offy1, offx2, offy2;
		offx1=i_x1coord-xorigine;		offy1=i_y1coord-yorigine;
		offx2=i_x2coord-xorigine;		offy2=i_y2coord-yorigine;
        double newx, newy;  double backangolo=-f_anglerot;
	    newx= offx1*cos(backangolo)-offy1*sin(backangolo);
		newy= offx1*sin(backangolo)+offy1*cos(backangolo);
        i_x1coord=newx+xorigine;		i_y1coord=newy+yorigine;
	    newx= offx2*cos(backangolo)-offy2*sin(backangolo);
		newy= offx2*sin(backangolo)+offy2*cos(backangolo);
        i_x2coord=newx+xorigine;		i_y2coord=newy+yorigine;
	}
	
	
	double dxold = i_x2coord-i_x1coord;  
	double dyold = i_y2coord-i_y1coord;
	double alfaold ;
	if (dxold==0) { if (dyold>0) alfaold = M_PI/2; else  alfaold = - M_PI/2; } else alfaold = atan2(dyold,dxold);
		//	if (dxold<0) alfaold=M_PI-alfaold;
	double dxnew = i_x4coord-i_x3coord;  
	double dynew = i_y4coord-i_y3coord;
	double alfanew;
    if (dxnew==0) { if (dynew>0) alfanew = M_PI/2; else  alfanew = - M_PI/2; } else alfanew = atan2(dynew,dxnew);	
		//	if (dxnew<0) alfanew=alfanew+M_PI;
	double alfare = alfanew-alfaold;
	f_anglerot=alfare;
	double LLOld = hypot(dxold , dyold);
	double LLNew = hypot(dxnew , dynew);
	double para  = LLNew/LLOld;		
	double scala_raster_x1_new=scalax*para;
	double scala_raster_y1_new=scalay*para;
	double ofdx,ofdy;

	ofdx = (i_x1coord-xorigine)*scala_raster_x1_new;
	ofdy = (i_y1coord-yorigine)*scala_raster_y1_new;
	
	ofdx = (i_x1coord-xorigine)*para;
	ofdy = (i_y1coord-yorigine)*para;

	
		// qui e' il dubbio
	
	xorigine = (i_x3coord-ofdx*cos(alfare))+ofdy*sin(alfare);
	yorigine = (i_y3coord-ofdy*cos(alfare))-ofdx*sin(alfare);
	scalax = scala_raster_x1_new;
	scalay = scala_raster_y1_new;
	
	
	[self updateLimiti];
	
	if ([info rasterautosave])	[self SalvaInfoRaster];
	

}


- (void)        RuotaconCentro : (double) xc : (double) yc : (double) rot  {
	rotocentra (xc , yc , rot , f_anglerot , &xorigine , &yorigine );   
    f_anglerot = rot;
	if ([info rasterautosave])	[self SalvaInfoRaster];
}

- (void)        ScalaconCentro : (double) xc : (double) yc : (int) modo : (double) scal {
		//	NSLog(@"C %d %2.2f "  , modo,scal);

	
	scalacentra (xc , yc , scal , modo, scalax ,scalay , &xorigine , &yorigine );   
	switch (modo) {
		case 0:	scalax = scal;	break;
		case 1:	scalax = scal;	scalay = scal; break;
		case 2:	scalay = scal;	break;
		default:		break;
	}
	if ([info rasterautosave])	[self SalvaInfoRaster];
}



- (void)        resetimmagine                                              {
	scalax=1.0;
	scalay=1.0;
	xorigine = [info  xorigineVista];
	yorigine = [info  yorigineVista];
	f_anglerot=0.0;
	[self updateLimiti ];
}


- (void)       FissaOrigine      : (double) xc : (double) yc               {
	xorigine = xc;
	yorigine = yc;
	[self updateLimiti ];
}

- (void)       setscala          : (double) xs : (double) ys               {
	scalax=xs;
	scalay=ys;
}



- (void)        SalvaInfoRaster                                            {
	NSString *nomefile;
	nomefile =NomefileRaster;
	nomefile = 	[nomefile stringByPaddingToLength:([nomefile length]-1) withString: @"w" startingAtIndex:0];
	// Results in "ab"
	nomefile = [nomefile stringByAppendingString:@"w"];
	NSString *Str;
	Str = @"";
	Str = [Str stringByAppendingFormat:	 @"%12f",xorigine];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",yorigine];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalax];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalay];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",f_anglerot];
	[Str writeToFile :nomefile atomically:YES encoding:NSASCIIStringEncoding error:NULL];
} 

- (void)        BiancoTrasparente                                          {
}



- (void)        CambiaColore : (NSColor *) colore{
	[coloredelBlack release];
	coloredelBlack  = colore;
	[coloredelBlack retain];

	NSSize _size;
	_size.width  = (float)dimx;
	_size.height = (float)dimy;
	NSImage  *newImage = [[NSImage alloc] initWithSize:_size];  
	[newImage lockFocus];
	[colore set];
	NSBezierPath *croppingPath = [NSBezierPath bezierPath];
	NSPoint aPt;
	aPt.x=0;	aPt.y=0; 	[croppingPath moveToPoint:aPt];
	aPt.x=dimx;	aPt.y=0; 	[croppingPath lineToPoint:aPt];
	aPt.x=dimx;	aPt.y=dimy;	[croppingPath lineToPoint:aPt];
	aPt.x=0;	aPt.y=dimy;	[croppingPath lineToPoint:aPt];
	aPt.x=0;	aPt.y=0; 	[croppingPath lineToPoint:aPt];
	[croppingPath closePath];
	[croppingPath fill];
	NSPoint _spt;
	NSImage *ImgOrigine;
	ImgOrigine = [[NSImage alloc] initWithContentsOfFile:NomefileRaster];
	NSRect bRect;
	bRect.origin.x=0;	bRect.origin.y=0;
	bRect.size.width  = dimx;
	bRect.size.height = dimy;
	_spt.x=0;
	_spt.y=0;
	[ImgOrigine drawInRect:bRect      fromRect:NSZeroRect    operation:NSCompositePlusLighter fraction:1.0];	
		//	[ImgOrigine drawInRect:bRect      fromRect:NSZeroRect    operation:NSCompositePlusDarker fraction:1.0];		 		 

    [newImage unlockFocus];
	
	CFRelease(imageref);
	CFRelease(ImgOrigine);
	
	imageref  = [newImage CGImageForProposedRect:NULL context:NULL hints:NULL];
	
	
}


- (bool)        NoBianco                                                   {
	return b_masheracolore;
}


@end
