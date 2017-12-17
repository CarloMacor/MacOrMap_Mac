//
//  LegendaView.m
//  MacOrMap
//
//  Created by Carlo Macor on 24/05/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "LegendaView.h"


@implementation LegendaView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}


- (void)        LoadImg  :(NSString *) _nomefile    {
	CGImageRelease(imageref);
	
	imgleg = [[NSImage alloc] initWithContentsOfFile:_nomefile];

	
	NSURL *      url = [NSURL fileURLWithPath: _nomefile];
	CGImageSourceRef    isr = CGImageSourceCreateWithURL( (CFURLRef)url, NULL);
	if (isr){
 	  imageref = CGImageSourceCreateImageAtIndex(isr, 0, NULL);
	  if (imageref) { dimx = CGImageGetWidth (imageref); dimy = CGImageGetHeight(imageref);	}  CFRelease(isr);
	}
	
	xorigine=0,	 yorigine=0;
	
	scalaimg=dimx/ [self frame].size.width;
	if ((dimy/[self frame].size.height) > scalaimg ) scalaimg=(dimy/[self frame].size.height);

	oldDimxFrame=[self frame].size.width;
	oldDimyFrame=[self frame].size.height;
	DimxFrIni   = oldDimxFrame;
	DimyFrIni   = oldDimyFrame;

    scalarifatta = 1;
	
	[self display]; 
}




- (void)drawRect:(NSRect)dirtyRect {
	
	if ((oldDimxFrame!=[self frame].size.width) | (oldDimyFrame!=[self frame].size.height)) {
		double scalaimgNew=DimxFrIni/ [self frame].size.width;
		if ((DimyFrIni/[self frame].size.height) < scalaimgNew ) scalaimgNew=(DimyFrIni/[self frame].size.height);
		scalaimg = scalaimg*scalaimgNew/scalarifatta;
		scalarifatta = scalaimgNew;
		oldDimxFrame=[self frame].size.width;
		oldDimyFrame=[self frame].size.height;
	}
	
	
	
/*	
	double xr1, xr2,yr1,yr2;
	xr1 = (xorigine - [info xorigineVista])/ [info scalaVista] ; // anche lo scala raster
	yr1 = (yorigine - [info yorigineVista])/ [info scalaVista] ;
	xr2 = xr1+(dimx * scalax)                       / [info scalaVista];
	yr2 = yr1+(dimy * scalay)                       / [info scalaVista];	
*/	
	
	NSRect destarect;
	NSRect sRect;
	
	destarect.origin.x=0; 	destarect.origin.y=0;
	destarect.size.width  = [self frame].size.width;
	destarect.size.height = [self frame].size.height;	
	
	if (dimx-xorigine<[self frame].size.width*scalaimg) xorigine=dimx-[self frame].size.width*scalaimg;
	if (xorigine<0) xorigine=0;

	if (yorigine<0) yorigine=0;
	if (dimy-yorigine<[self frame].size.height*scalaimg) yorigine=dimy-[self frame].size.height*scalaimg;

	

	
		//	if (xorigine<0) xorigine=0;
	
		//	NSLog(@"%1.2f %1.2f %1.2f",xorigine,dimx-xorigine,[self frame].size.width*scalaimg);
		//	if (xorigine>(dimx*scalaimg -[self frame].size.width )  ) xorigine=0;
	
	sRect.origin.x=xorigine;	        sRect.origin.y=yorigine;
	sRect.size.width  = destarect.size.width*scalaimg;	
	sRect.size.height = destarect.size.height*scalaimg;
	
	[self lockFocus];
	[[NSColor grayColor] set];	NSRectFill ( destarect  );
	
	[imgleg drawInRect:destarect fromRect:sRect operation:NSCompositeCopy fraction:1.0 ];
	[self unlockFocus];
}


- (void) otherMouseDown :(NSEvent *)theEvent     {
	NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	xclickdown = mPoint.x;	yclickdown = mPoint.y;
}


- (void )otherMouseDragged:(NSEvent *)theEvent   {
	NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	double dx = mPoint.x-xclickdown;
	double dy = mPoint.y-yclickdown;
	xclickdown = mPoint.x;	yclickdown = mPoint.y;
	xorigine -=dx*scalaimg,	 yorigine -= dy*scalaimg;
	[self display];
}

- (void) scrollWheel:(NSEvent *)theEvent         {
	NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	double oldxpos = xorigine+mPoint.x*scalaimg;
	double oldypos = yorigine+mPoint.y*scalaimg;
	double para = 1.2;
	if  ([theEvent deltaY]>0) {	scalaimg = scalaimg*para; }	 else {	scalaimg = scalaimg/para; }
	double Maxscalaimg=dimx/ [self frame].size.width;
	if ((dimy/[self frame].size.height) > Maxscalaimg ) Maxscalaimg=(dimy/[self frame].size.height);
	if (Maxscalaimg<scalaimg) scalaimg = Maxscalaimg;
	double newxpos = xorigine+mPoint.x*scalaimg;
	double newypos = yorigine+mPoint.y*scalaimg;
    double offdx = newxpos - oldxpos;
	double offdy = newypos - oldypos;
	xorigine = xorigine-offdx;
	yorigine = yorigine-offdy;
	[self display];
}




@end
