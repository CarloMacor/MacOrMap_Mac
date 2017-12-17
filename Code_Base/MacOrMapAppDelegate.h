//
//  GIS2010AppDelegate.h
//  GIS2010
//
//  Created by Carlo Macor on 22/02/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "Progetto.h"
#import "BarileCtr.h"
#import "BarileDlg.h"
#import "Interface.h"
#import "Varbase.h"
#import "AzDialogs.h"
#import "AzExtra.h"
#import "AzRaster.h"
#import "AzVector.h"
#import "AzInterface.h"
#import "ComandiDlg.h"

	///usr/sbin/systemsetup


@interface MacOrMapAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSWindow    *  window;
	IBOutlet Progetto    *  progetto;
	IBOutlet BarileCtr   *  barilectr;
	IBOutlet BarileDlg   *  bariledlg;
	IBOutlet Interface   *  interface;
	IBOutlet Varbase     *  varbase;
	IBOutlet InfoObj     *  info;
	IBOutlet AzDialogs   *  azdialogs;
	IBOutlet AzExtra     *  azextra;
	IBOutlet AzRaster    *  azraster;
	IBOutlet AzVector    *  azvector;
	IBOutlet AzInterface *  azinterface;
	IBOutlet ComandiDlg  *  comandiDlg;

}



@property (assign) IBOutlet NSWindow *window;



-(bool) ChiusuraHardware;



@end
