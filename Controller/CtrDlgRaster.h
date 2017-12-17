//
//  CtrDlgRaster.h
//  MacOrMap
//
//  Created by Carlo Macor on 10/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DisegnoR.h"


@interface CtrDlgRaster : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView             *Tavola;
	NSMutableArray                   *CopiaListaRaster;
    NSImage                          *lightOn;
    NSImage                          *lightOff;
	int                              IndRastCorrente;
	
}


- (void)     passaRaster  : (NSMutableArray *)  RasterList;

- (void)     updaterighe  : (int) indcorrente;                           

- (void)     cambiaselezionato : (int) passo ;

- (Raster   *) rasterinoInd : (int) ind;
- (DisegnoR *) rasterDisInd : (int) ind;

- (int)      IndSelezionato;



@end
