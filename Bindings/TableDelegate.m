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
@property (nonatomic)                 int                   itemIndex;
@property (nonatomic,strong)          NSMutableArray        *items;
@property (nonatomic,strong) IBOutlet NSArrayController     *arrayController;

@end


@implementation TableDelegate 

@synthesize items = _items;
@synthesize arrayController = _arrayController;
@synthesize tableView = _tableView;
@synthesize itemIndex = _itemIndex;

-(void) awakeFromNib{
    NSLog(@"TableDelegate - awakeFromNib");
    self.itemIndex = 1;
//    [self addObserver:self forKeyPath:@"items" options:0 context:@"myContext"];
    [self setValue:@3 forKey:@"itemIndex"];
    [self setValue:nil forKey:@"itemIndex"];
//    [self setValue:[[Item alloc] initWithName:@"tore" andPrice:56] forKey:@"items"];
}

-(void) setItemIndex:(int)itemIndex{
    _itemIndex = itemIndex;
}

-(BOOL) validateItemIndex:(id *)ioValue error:(NSError *)outError {
    NSLog(@"(BOOL) validateItemIndex:(id *)ioValue error:(NSError * __autoreleasing *)outError");
    *ioValue = @"23";
    return YES;
}

- (void)setNilValueForKey:(NSString *)theKey {
    
    if ([theKey isEqualToString:@"itemIndex"]) {
        [self setValue:@0 forKey:@"itemIndex"];
    }
    else {
        [super setNilValueForKey:theKey];
    }
}

-(NSMutableArray*) items {
    if(_items == nil){
        _items = [[NSMutableArray alloc] init];
    }    
    return _items;
}


#pragma mark Indexed Accessors
//- (NSUInteger)countOf<key>;
//- (id)objectIn<key>AtIndex:(NSUInteger)index;
//- (void)insertObject:(id)obj in<key>AtIndex:(NSUInteger)index;
//- (void)removeObjectFrom<key>AtIndex:(NSUInteger)index;
//- (void)replaceObjectIn<key>AtIndex:(NSUInteger)index withObject:(id)obj;

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
    [self.items insertObject:anObject atIndex:index];
    self.itemIndex += 1;
    return;

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
    self.itemIndex -= 1;
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


#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    NSLog(@"(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context");
    if([object isKindOfClass:[Item class]] && change == nil){
        NSLog(@"keypath:%@ - object:%@ - change:%@ - context:%@",keyPath,object,change,context);
    }
    
}


#pragma mark Actions

- (IBAction)doStuff:(NSButton *)sender {
    NSLog(@"Current state of items %@",self.items);
}

- (IBAction)ChangeItem:(id)sender {
    [self.arrayController addObject:[[Item alloc] initWithName:@"tore" andPrice:56]];
    NSLog(@"Current state of items %@",self.items);
}
@end
