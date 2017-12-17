//
//  ComandiToolBar.h
//  MacOrMap
//
//  Created by Carlo Macor on 24/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Varbase.h"


@interface ComandiToolBar : NSObject {
	IBOutlet Varbase                *  varbase;
		// gli snap
	bool       b_snapfine;	 bool       b_snapvicino;	bool       b_snaporto;	bool       b_snaportoseg; bool       b_snapgriglia;

}

@property(nonatomic) bool	b_snapfine;
@property(nonatomic) bool	b_snapvicino;
@property(nonatomic) bool	b_snaporto;
@property(nonatomic) bool	b_snaportoseg;
@property(nonatomic) bool	b_snapgriglia;



	// snap
- (IBAction) Snappers                       : (id)sender;
- (IBAction) Snapper_end                    : (id)sender;
- (IBAction) Snapper_vic                    : (id)sender;
- (IBAction) Snapper_orto                   : (id)sender;
- (IBAction) Snapper_ortoseg                : (id)sender;
- (IBAction) Snapper_Griglia                : (id)sender;
- (IBAction) Snapper_remove                 : (id)sender;
- (void)     UpdateStatobottonisnap;


- (IBAction) CambiaProiezione               : (id)sender;

@end
