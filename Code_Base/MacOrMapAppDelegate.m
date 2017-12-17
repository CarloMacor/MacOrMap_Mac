//
//  GIS2010AppDelegate.m
//  GIS2010
//
//  Created by Carlo Macor on 22/02/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "MacOrMapAppDelegate.h"


#define ZOOM_IN_FACTOR  1.414214
#define ZOOM_OUT_FACTOR 0.7071068


@implementation MacOrMapAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[window performZoom:self];

	[window setAcceptsMouseMovedEvents: YES];
		//	[window setBackgroundColor: [NSColor darkGrayColor]];
			[window setBackgroundColor: [NSColor blackColor]];

    
    
	[interface  InitInterface];
    [info       initInfo];
	[varbase    InitVarbase  ]; // Interface   bariledlg
	[progetto   InitProgetto ]; // InfoObj     Varbase  
	
    
    [azextra    InitAzExtra  ]; // varbase     progetto  info  interface
	[azdialogs  InitAzDialogs]; // varbase     progetto  info  interface AZExtra
	[azraster   InitAzRaster ]; //  varbase  : progetto :info :interface AZDialogs
	[azvector   InitAzVector ]; //: varbase  : progetto :info :interface ];// AZDialogs
								//	IBOutlet ComandiDlg  *  comandidlg;
	
    
    [azinterface InitAzInterface ]; //: varbase  : progetto :info :interface ];// AZDialogs

    [comandiDlg initComandiDlg]; // : varbase  : progetto :info :interface 

        //	if (![progetto ChiusuraSoftwareSuNome]) [window close];
        // if ([self ChiusuraHardware]) [window close];
		//  // [progetto ChiusuraSoftware:self];
	
	
		//	[NetworkClock sharedNetworkClock]; 
		//	NSDate *date = [[NetworkClock sharedNetworkClock] networkTime];
		//systemsetup
		//	"$(dd if=/dev/random bs=1 count=1 2> /dev/null)";

		//		 NSString testatime1=	"$(systemsetup getusingnetworktime)";

		//	NSLog(@"-.- %d",testatime1);

		//	systemsetup -setusingnetworktime:off;
		//		bool testatime2=	"$(systemsetup getusingnetworktime)";
/*"$(systemsetup -settime 16:20:00)";
   "systemsetup gettime";

	NSLog(@"-o- %d",testatime2);
*/	
	
		//# Test our ord subroutine
		//    echo "Testing ord subroutine"
		//    int ORDOFA=$(ord "a");
		//# That better be 97.
		//    if [ "$ORDOFA" != "97" ] ; then
		//	echo "Shell ord subroutine broken.  Try fast mode."
	
		//	RAWVAL1="$(ntpdate if=/dev/random bs=1 count=1 2> /dev/null)"	;
}



- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
	return YES;
}



- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
	return YES;
	
}

-(bool) ChiusuraHardware {
	bool resulta=YES ;

	io_service_t    platformExpert;
	platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault,IOServiceMatching("IOPlatformExpertDevice"));
	if (platformExpert) {
		CFTypeRef serialNumberAsCFString =
		IORegistryEntryCreateCFProperty(platformExpert,	CFSTR(kIOPlatformSerialNumberKey), kCFAllocatorDefault, 0);
		
		NSString * mionumberseriale = [NSString stringWithFormat:@"%@",serialNumberAsCFString];
		
		if ([mionumberseriale isEqualToString:@"YM9300NT0TF" ]) resulta=NO;  // il Mio primo imac 20"
		

		
		IOObjectRelease(platformExpert);
	}
	
	
		//	systemsetup

	
	return resulta;
}




@end
