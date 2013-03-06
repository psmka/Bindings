//
//  TableDelegate.m
//  Bindings
//
//  Created by Magnus Karlsson on 2013-03-05.
//  Copyright (c) 2013 Magnus Karlsson. All rights reserved.
//

#import "TableDelegate.h"
#import "Item.h"
@implementation TableDelegate

@synthesize items = _items;
@synthesize arrayController = _arrayController;
@synthesize tableView = _tableView;

-(void) awakeFromNib{
    NSLog(@"pelle");
    _items = [NSMutableArray new];
    [self.items addObject:[[Item new] setName:@"olle" andPrice:14]];
    [self.arrayController setContent:self.items];
//    [arrayController setObjectClass: [Item class]];
//    [arrayController setAutomaticallyPreparesContent:YES];
}



@end
