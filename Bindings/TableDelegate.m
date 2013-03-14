//
//  TableDelegate.m
//  Bindings
//
//  Created by Magnus Karlsson on 2013-03-05.
//  Copyright (c) 2013 Magnus Karlsson. All rights reserved.
//

#import "TableDelegate.h"
#import "Item.h"

@interface TableDelegate()
@property (nonatomic) int itemIndex;
@end


@implementation TableDelegate 

@synthesize items = _items;
//@synthesize arrayController = _arrayController;
@synthesize tableView = _tableView;
@synthesize itemIndex = _itemIndex;

-(void) awakeFromNib{
    NSLog(@"TableDelegate - awakeFromNib");
    [self setContent:self.items];
    self.itemIndex = 1;
    [self addObserver:self forKeyPath:@"arrangedObjects" options:0 context:nil];
}

-(NSMutableArray*) items {
    if(_items == nil){
        _items = [[NSMutableArray alloc] init];
    }    
    return _items;
}

- (NSUInteger)countOfItems {
    NSLog(@"(NSUInteger)countOfItems");
    return [self.items count];
}


- (id) objectInItemsAtIndex:(NSUInteger)index {
    NSLog(@"(id)objectInItemsAtIndex:(NSUInteger)index");
    Item *item = [self.items objectAtIndex:index];
    NSLog(@"item: %@:%f",item.name,item.price);
    return item;
}

- (NSArray *) itemsAtIndexes:(NSIndexSet *)indexes {
    NSLog(@"(NSArray *) itemsAtIndexes:(NSIndexSet *)indexes");
    return [self.items objectsAtIndexes:indexes];
}

- (void) insertObject:(id)anObject inItemsAtIndex:(NSUInteger)index
{
    NSLog(@"(void)insertObject:(id)anObject inItemsAtIndex:(NSUInteger)index");
    if(self.itemIndex % 5 == 0){
        NSAlert* alert = [[NSAlert alloc ] init];
        alert.messageText = @"Wrong answer, thank you for playing";
        [alert runModal];
    } else {
        [self.items insertObject:anObject atIndex:index];
        self.itemIndex += 1;
    }
}

- (void) removeObjectFromItemsAtIndex:(NSUInteger)index
{
    NSLog(@"(void)removeObjectFromItemsAtIndex:(NSUInteger)index %lu",(NSUInteger)index);
    [self.items removeObjectAtIndex:index];
}

- (void) replaceObjectInItemsAtIndex:(NSUInteger)index withObject:(id)anObject
{
    NSLog(@"(void)replaceObjectInItemsAtIndex:(NSUInteger)index withObject:(id)anObject");
    [self.items replaceObjectAtIndex:index withObject:anObject];

    NSLog(@"Current state of items %@",self.items);
}

- (void)replaceItemsAtIndexes:(id)indexes
                    withItems:(id)items {
    NSLog(@"(void)replaceItemsAtIndexes:(CPIndexSet)indexes withItems:(CPArray)items ");
    [self.items replaceObjectsAtIndexes:indexes withObjects:items];
}


#pragma mark Overrides
- (void)insertObject:(id)object atArrangedObjectIndex:(NSUInteger)index{
    NSLog(@"(void)insertObject:(id)object atArrangedObjectIndex:(NSUInteger)index");
    [super insertObject:object atArrangedObjectIndex:index];
    
}

- (void)removeObjectAtArrangedObjectIndex:(NSUInteger)index{
    NSLog(@"(void)removeObjectAtArrangedObjectIndex:(NSUInteger)index");
    [super removeObjectAtArrangedObjectIndex:index];
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
//    NSLog(@"(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context");
    if([object isKindOfClass:[Item class]] && change == nil){
        NSLog(@"keypath:%@ - object:%@ - change:%@ - context:%@",keyPath,object,change,context);
    }
    
}
#pragma mark Actions

- (IBAction)doStuff:(NSButton *)sender {
//    [self insertObject:[[Item alloc] initWithName:@"First" andPrice:14] atArrangedObjectIndex:0];
    NSLog(@"Current state of items %@",self.items);
}

- (IBAction)ChangeItem:(id)sender {
    self.itemIndex = 1;
}
@end
