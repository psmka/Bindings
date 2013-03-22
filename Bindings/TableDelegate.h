//
//  TableDelegate.h
//  Bindings
//
//  Created by Magnus Karlsson on 2013-03-05.
//  Copyright (c) 2013 Magnus Karlsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableDelegate : NSViewController

@property (nonatomic,strong)    IBOutlet NSTableView        *tableView;
@property (nonatomic,weak)      IBOutlet NSButton           *doStuffButton;

- (IBAction)doStuff:(NSButton *)sender;
- (IBAction)ChangeItem:(id)sender;
- (IBAction)showOrder:(NSButton *)sender;

@end
