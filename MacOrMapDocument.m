//
//  MacOrMapDocument.m
//  MacOrMap
//
//  Created by Carlo Macor on 09/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "MacOrMapDocument.h"


@implementation MacOrMapDocument

- (NSString *)windowNibName {    return @"MacOrMapDocument";  }

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError  {    return nil;}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {    return YES; }


- (void) printDocument:(id)sender {
	if (![progetto isRettangoloStampa]) {  return ;  }
	[super printDocument:sender];	
}


- (NSPrintOperation *) printOperationWithSettings : (NSDictionary * ) ps error:(NSError **)e {
	NSPrintInfo *printInfo = [self printInfo];
	NSPrintOperation *printOp = [NSPrintOperation printOperationWithView:progetto printInfo:printInfo];
	return printOp;
}



@end
