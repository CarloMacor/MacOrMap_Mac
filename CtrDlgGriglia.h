//
//  CtrDlgGriglia.h
//  MacOrMap
//
//  Created by Carlo Macor on 31/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CtrDlgGriglia : NSViewController {
	IBOutlet NSButton           *  Gr_B1;
	IBOutlet NSButton           *  Gr_B2;
	IBOutlet NSButton           *  Gr_B3;
	IBOutlet NSButton           *  Gr_B4;
	IBOutlet NSButton           *  Gr_B5;
	IBOutlet NSButton           *  Gr_B6;
	IBOutlet NSSegmentedControl *  Gr_S1;
	IBOutlet NSSegmentedControl *  Gr_S2;
	IBOutlet NSSegmentedControl *  Gr_S3;
	IBOutlet NSSegmentedControl *  Gr_S4;
	IBOutlet NSSegmentedControl *  Gr_S5;
	IBOutlet NSSegmentedControl *  Gr_S6;
	IBOutlet NSColorWell        *  Gr_Col1;
	IBOutlet NSColorWell        *  Gr_Col2;
	IBOutlet NSColorWell        *  Gr_Col3;
	IBOutlet NSColorWell        *  Gr_Col4;
	IBOutlet NSColorWell        *  Gr_Col5;
	IBOutlet NSColorWell        *  Gr_Col6;
	IBOutlet NSComboBox         *  Gr_Spes1;
	IBOutlet NSComboBox         *  Gr_Spes2;
	IBOutlet NSComboBox         *  Gr_Spes3;
	IBOutlet NSComboBox         *  Gr_Spes4;
	IBOutlet NSComboBox         *  Gr_Spes5;
	IBOutlet NSComboBox         *  Gr_Spes6;
	IBOutlet NSComboBox         *  Gr_Trat1;
	IBOutlet NSComboBox         *  Gr_Trat2;
	IBOutlet NSComboBox         *  Gr_Trat3;
	IBOutlet NSComboBox         *  Gr_Trat4;
	IBOutlet NSComboBox         *  Gr_Trat5;
	IBOutlet NSComboBox         *  Gr_Trat6;
}


- (void) initgriglia;
	// griglia
- (NSButton           *)  Gr_B1;
- (NSButton           *)  Gr_B2;
- (NSButton           *)  Gr_B3;
- (NSButton           *)  Gr_B4;
- (NSButton           *)  Gr_B5;
- (NSButton           *)  Gr_B6;
- (NSSegmentedControl *)  Gr_S1;
- (NSSegmentedControl *)  Gr_S2;
- (NSSegmentedControl *)  Gr_S3;
- (NSSegmentedControl *)  Gr_S4;
- (NSSegmentedControl *)  Gr_S5;
- (NSSegmentedControl *)  Gr_S6;
- (NSColorWell        *)  Gr_Col1;
- (NSColorWell        *)  Gr_Col2;
- (NSColorWell        *)  Gr_Col3;
- (NSColorWell        *)  Gr_Col4;
- (NSColorWell        *)  Gr_Col5;
- (NSColorWell        *)  Gr_Col6;
- (NSComboBox         *)  Gr_Spes1;
- (NSComboBox         *)  Gr_Spes2;
- (NSComboBox         *)  Gr_Spes3;
- (NSComboBox         *)  Gr_Spes4;
- (NSComboBox         *)  Gr_Spes5;
- (NSComboBox         *)  Gr_Spes6;
- (NSComboBox         *)  Gr_Trat1;
- (NSComboBox         *)  Gr_Trat2;
- (NSComboBox         *)  Gr_Trat3;
- (NSComboBox         *)  Gr_Trat4;
- (NSComboBox         *)  Gr_Trat5;
- (NSComboBox         *)  Gr_Trat6;



@end
