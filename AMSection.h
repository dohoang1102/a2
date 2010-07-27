//
//  AMSection.h
//  a2
//
//  Created by ampatspell on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AMSection : NSObject {
  NSMutableArray *models;
}

- (NSUInteger)countOfModels;
- (id)objectInModelsAtIndex:(NSUInteger)index;
- (NSArray *)modelsAtIndexes:(NSIndexSet *)indexes;
- (void)insertObject:(id)object inModelsAtIndex:(NSUInteger)index;
- (void)removeObjectFromModelsAtIndex:(NSUInteger)index;
- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withModels:(NSArray *)objects;
- (void)insertModels:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
- (void)removeModelsAtIndexes:(NSIndexSet *)indexes;

@end

@interface AMSection (AMSectionAbstract)
- (NSString *)localizedName;
- (NSString *)persistentName;
@end
