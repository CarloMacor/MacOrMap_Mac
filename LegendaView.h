//
//  LegendaView.h
//  MacOrMap
//
//  Created by Carlo Macor on 24/05/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LegendaView : NSView {
	CGImageRef		imageref ;
	double          dimx,	     dimy;
	double          xorigine,	 yorigine;
	double          scalaimg;
	NSImage        *imgleg;
	double          xclickdown ,  yclickdown;
	double          oldDimxFrame,	     oldDimyFrame;
    double          scalarifatta;
	double          DimxFrIni,	     DimyFrIni;
}


- (void)       LoadImg        :(NSString *)   _nomefile;


@end
