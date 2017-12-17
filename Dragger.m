//
//  Dragger.m
//  MacOrMap
//
//  Created by Carlo Macor on 21/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "Dragger.h"


@implementation Dragger

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}
/*
- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}
*/
 
- (void) mouseDown:(NSEvent *)theEvent                   {
	
	[theEvent retain];
	[mouseDownEvent release];
	mouseDownEvent = theEvent;
	NSBeep();	
}

- (NSDragOperation) draggingSourceOperationMaskForLocal:(BOOL)flag {
	
	return NSDragOperationCopy;
}

@end
