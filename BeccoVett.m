//
//  BeccoVett.m
//  MacOrMap
//
//  Created by Carlo Macor on 13/08/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "BeccoVett.h"


@implementation BeccoVett

@synthesize  azioneback;
@synthesize  indicevtback;
@synthesize  xbacco;
@synthesize  ybacco;


- (void) init   :(int) azb :(int) indb :(double) xer :(double) yer  {
	  azioneback   = azb  ; 
	  indicevtback = indb ;
	  xbacco       = xer  ;
	  ybacco       = yer  ;
}

- (void) logga {
	
	NSLog(@"backvt  %d %d %1.2f %1.2f",azioneback,indicevtback,xbacco,ybacco  );
	
}


@end
