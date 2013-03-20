//
//  Item.m
//  Bindings
//
//  Created by Magnus Karlsson on 2013-03-05.
//  Copyright (c) 2013 Magnus Karlsson. All rights reserved.
//

#import "Item.h"


@implementation Item

@synthesize price = _price;
@synthesize name = _name;

-(id) init {
    if(self = [super init]){
        self.price = 12;
        self.name = @"torkel";
	}
	return self;
}

-(id) initWithName:(NSString *)aName andPrice:(float)aPrice {
    self = [self init];
    self.price = aPrice;
    self.name = [NSString stringWithString:aName];
    return self;
}

-(NSString*) description{
    return [NSString stringWithFormat:@"Item name:price  - %@:%f",self.name,self.price];
}

-(BOOL) validatePrice:(id*) ioValue error:(NSError**) outError {
    NSLog(@"(BOOL) validateItemIndex:(id *)ioValue error:(NSError * __autoreleasing *)outError");
    *ioValue = @23;
    return YES;
}

-(BOOL) validateName:(id*) ioValue error:(NSError**) outError {
    NSLog(@"(BOOL) validateItemIndex:(id *)ioValue error:(NSError * __autoreleasing *)outError");
    *ioValue = @"Validate";
    return NO;
}


@end
