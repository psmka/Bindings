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

@property (nonatomic,strong) IBOutlet NSWindow              *window;
@property (nonatomic,strong) IBOutlet NSPanel               *panel;


@end


@implementation TableDelegate 

@synthesize items = _items;
@synthesize arrayController = _arrayController;
@synthesize tableView = _tableView;
@synthesize itemIndex = _itemIndex;
@synthesize window = _window;
@synthesize panel = _panel;

-(void) awakeFromNib{
    NSLog(@"TableDelegate - awakeFromNib");
    self.itemIndex = 1;
    [self.arrayController setContent:self.items];
//    [self addObserver:self forKeyPath:@"items" options:0 context:@"myContext"];
    id validate = [NSNumber numberWithInt:self.itemIndex];
    NSError* errorValue;
    [self validateValue:&validate forKey:@"itemIndex" error: &errorValue];
    [self setValue:@3 forKey:@"itemIndex"];
    [self setValue:nil forKey:@"itemIndex"];
//    [self setValue:[[Item alloc] initWithName:@"tore" andPrice:56] forKey:@"items"];
//    [self.tableView setAllowsColumnSelection:YES];
    [self.arrayController setSortDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO], nil]];
}

-(void) setItemIndex:(int)itemIndex{
    _itemIndex = itemIndex;
}

-(BOOL) validateItemIndex:(id*) ioValue error:(NSError**) outError {
    NSLog(@"(BOOL) validateItemIndex:(id *)ioValue error:(NSError * __autoreleasing *)outError");
    *ioValue = @23;
    return NO;
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
}

- (void)replaceItemsAtIndexes:(id)indexes
                    withItems:(id)items {
    NSLog(@"(void)replaceItemsAtIndexes:(CPIndexSet)indexes withItems:(CPArray)items ");
    [self.items replaceObjectsAtIndexes:indexes withObjects:items];
}


#pragma mark TableView DataSource
- (void)tableView:(NSTableView*)aTableView sortDescriptorsDidChange:(NSArray*)oldDescriptors
{
	NSLog(@"TabelView - sortDescriptorsDidChange");
    NSArray* newDescriptors = [aTableView sortDescriptors];
    [self.items sortUsingDescriptors:newDescriptors];
    [self.tableView reloadData];
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
    NSMutableArray* proxy = [self mutableArrayValueForKey:@"items"];
    Item* item = [proxy objectAtIndex:0];
    item.name = @"egon";
    item.price = 99;
    [proxy replaceObjectAtIndex:0 withObject:item];
    NSLog(@"Current state of items %@",self.items);
}

- (IBAction)ChangeItem:(id)sender {
    NSMutableArray* proxy = [self mutableArrayValueForKey:@"items"];
    NSUInteger noItems = [proxy count];
    [proxy insertObject:[[Item alloc] initWithName:@"tore" andPrice:56] atIndex:0];
    NSArray* objects = [proxy objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];
    NSLog(@"Current state of items %@ count: %li",self.items,(unsigned long)noItems);
}

- (IBAction)showOrder:(NSButton *)sender {
    NSMutableArray* kvc = [self mutableArrayValueForKey:@"items"];
    NSLog(@"-(@action) showOrder:(id) sender ");
    NSLog(@"-(@action) showOrder:(id) kvc array - %@",kvc);
    NSLog(@"-(@action) showOrder:(id) items - %@",self.items);
    NSLog(@"-(@action) showOrder:(id) Arraycontroller - %@",[self.arrayController arrangedObjects]);

}
@end
