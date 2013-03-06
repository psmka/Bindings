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

-(Item*) setName:(NSString*) aName andPrice:(float) aPrice {
    self.price = aPrice;
    self.name = [NSString stringWithString:aName];
    return self;
}

@end
