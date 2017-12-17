//
//  ComandiToolBar.m
//  MacOrMap
//
//  Created by Carlo Macor on 24/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "ComandiToolBar.h"


@implementation ComandiToolBar

@synthesize  b_snapfine;
@synthesize  b_snapvicino;
@synthesize  b_snaporto;
@synthesize  b_snaportoseg;
@synthesize  b_snapgriglia;


	// snap
- (IBAction) Snappers                      : (id)sender  {
	switch ([sender selectedSegment]) {
		case 0: [self Snapper_end:self];     break;
		case 1: [self Snapper_vic:self];     break;
		case 2: [self Snapper_orto:self];    break;
		case 3: [self Snapper_ortoseg:self]; break;
		case 4: [self Snapper_Griglia:self]; break;
		case 5: [self Snapper_remove:self];  break;
	}
}

- (IBAction) Snapper_end                   : (id)sender  {
	b_snapfine=!b_snapfine; [self UpdateStatobottonisnap];
};

- (IBAction) Snapper_vic                   : (id)sender  {
	b_snapvicino=!b_snapvicino; [self UpdateStatobottonisnap];
};

- (IBAction) Snapper_orto                  : (id)sender  {
	b_snaporto=!b_snaporto; [self UpdateStatobottonisnap];
};

- (IBAction) Snapper_ortoseg               : (id)sender  {
	b_snaportoseg=!b_snaportoseg; [self UpdateStatobottonisnap];
};

- (IBAction) Snapper_Griglia               : (id)sender  {
	b_snapgriglia=!b_snapgriglia; [self UpdateStatobottonisnap];
};


- (IBAction) Snapper_remove                : (id)sender  {
	b_snapfine      = NO;
	b_snapvicino    = NO;
	b_snaporto      = NO;
	b_snaportoseg   = NO;
	b_snapgriglia   = NO;
	[self UpdateStatobottonisnap];
};

- (void)     UpdateStatobottonisnap                      {
	[[varbase ESSnap] setSelected:b_snapfine       forSegment:0];
	[[varbase ESSnap] setSelected:b_snapvicino     forSegment:1];
	[[varbase ESSnap] setSelected:b_snaporto       forSegment:2];
	[[varbase ESSnap] setSelected:b_snaportoseg    forSegment:3];
	[[varbase ESSnap] setSelected:b_snapgriglia    forSegment:4];
	[[varbase ESSnap] setSelected:NO               forSegment:5];
};


- (IBAction) CambiaProiezione               : (id) sender                                           {
	varbase.TipoProiezione=[sender selectedSegment];
		//	if ((TipoProiezione==0) | (TipoProiezione==2)) [[varbase ESFuso] setHidden:NO]; else [[varbase ESFuso] setHidden:YES];
	[[varbase interface] cambiataproiezione:varbase.TipoProiezione];
}


@end
