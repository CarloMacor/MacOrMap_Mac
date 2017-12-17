//
//  InterfaceDlg.h
//  MacOrMap
//
//  Created by Carlo Macor on 25/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>


@interface InterfaceDlg : NSObject {
	IBOutlet NSTextField   *  Infoquanti;
	IBOutlet NSTextField   *  InfoquantiSup;
	IBOutlet NSTextField   *  Infotipo;
	IBOutlet NSTextField   *  Infolungo;
	IBOutlet NSTextField   *  Infosup;
	IBOutlet NSTextField   *  InfosupLeg;
	IBOutlet NSTextField   *  InfoDisLeg;
	IBOutlet NSTextField   *  InfopiaLeg;
	IBOutlet NSTextField   *  Infonvt;
	IBOutlet NSTextField   *  Infopia;
	IBOutlet NSTextField   *  Infodis;

		// dialog Appunti
	IBOutlet NSScrollView  *  AppuntiViewTxt;
	IBOutlet NSTextView    *  AppuntiTxt;

}

- (NSTextField   *)  Infoquanti;
- (NSTextField   *)  InfoquantiSup;
- (NSTextField   *)  Infotipo;
- (NSTextField   *)  Infolungo;
- (NSTextField   *)  Infosup;
- (NSTextField   *)  InfosupLeg;
- (NSTextField   *)  InfoDisLeg;
- (NSTextField   *)  InfopiaLeg;
- (NSTextField   *)  Infonvt;
- (NSTextField   *)  Infopia;
- (NSTextField   *)  Infodis;
- (NSScrollView  *)  AppuntiViewTxt;
- (NSTextView    *)  AppuntiTxt;


@end
