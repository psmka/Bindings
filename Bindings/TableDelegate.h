//
//  TableDelegate.h
//  Bindings
//
//  Created by Magnus Karlsson on 2013-03-05.
//  Copyright (c) 2013 Magnus Karlsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableDelegate : NSController

@property (nonatomic,strong)          NSMutableArray      *items;
@property (nonatomic,strong) IBOutlet NSTableView         *tableView;
@property (nonatomic,strong) IBOutlet NSArrayController   *arrayController;

@property (weak) IBOutlet NSButton *doStuffButton;

@end
