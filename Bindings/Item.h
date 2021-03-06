//
//  Item.h
//  Bindings
//
//  Created by Magnus Karlsson on 2013-03-05.
//  Copyright (c) 2013 Magnus Karlsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic) float            price;
@property (nonatomic,strong) NSString *name;

-(id) initWithName:(NSString*) aName andPrice:(float) aPrice;

-(NSString*) description;

@end
