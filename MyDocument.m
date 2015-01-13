//
//  MyDocument.m
//  GoldenScissors
//
//  Created by EventHorizon on 11/01/2015.
//  Copyright (c) 2015 EventHorizon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyDocument.h"

@implementation MyDocument
@synthesize xmlContent,zipDataContent;

// Called whenever the application reads data from the file system
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError
{
    // NSLog(@"* ---> typename: %@",typeName);
    self.xmlContent = [[NSString alloc]
                       initWithBytes:[contents bytes]
                       length:[contents length]
                       encoding:NSUTF8StringEncoding];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noteModified" object:self];
    return YES;
}

// Called whenever the application (auto)saves the content of a note
- (id)contentsForType:(NSString *)typeName error:(NSError **)outError
{
    
    return [NSData dataWithBytes:[self.xmlContent UTF8String] length:[self.xmlContent length]];
    
}

@end
