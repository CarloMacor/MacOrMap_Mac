//
//  BeccoVett.h
//  MacOrMap
//
//  Created by Carlo Macor on 13/08/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BeccoVett : NSObject {
		int    azioneback; 
		int    indicevtback;
		double xbacco;
		double ybacco;
}



@property(nonatomic) int	azioneback;
@property(nonatomic) int	indicevtback;
@property(nonatomic) double	xbacco;
@property(nonatomic) double	ybacco;


- (void) init   :(int) azb :(int) indb :(double) xer :(double) yer ;
	

- (void) logga;


@end
