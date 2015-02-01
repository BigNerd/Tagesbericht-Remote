//
//  Tagesbericht.h
//  Tagesbericht
//
//  Created by Matthias Burbach on 10.05.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Leistung;

@interface Tagesbericht : NSManagedObject

@property (strong, nonatomic) NSString * auftraggeber;
@property (strong, nonatomic) NSString * baustelle;
@property (strong, nonatomic) NSDate * datum;
@property (strong, nonatomic) NSDate * zuletztGeaendert;
@property (strong, nonatomic) NSDate * zuletztGesendet;
@property (strong, nonatomic) NSString * notizen;
@property (strong, nonatomic) NSData * unterschrift;
@property (strong, nonatomic) NSOrderedSet *leistungen;
@property (strong, nonatomic) NSOrderedSet *maschinen;
@property (strong, nonatomic) NSOrderedSet *material;

- (int)leistungsstunden;
- (int)leistungsminuten;

- (int)maschinenstunden;
- (int)maschinenminuten;

@end

@interface Tagesbericht (CoreDataGeneratedAccessors)

- (void)insertObject:(Leistung *)value inLeistungenAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLeistungenAtIndex:(NSUInteger)idx;
- (void)insertLeistungen:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLeistungenAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLeistungenAtIndex:(NSUInteger)idx withObject:(Leistung *)value;
- (void)replaceLeistungenAtIndexes:(NSIndexSet *)indexes withLeistungen:(NSArray *)values;
- (void)addLeistungenObject:(Leistung *)value;
- (void)removeLeistungenObject:(Leistung *)value;
- (void)addLeistungen:(NSOrderedSet *)values;
- (void)removeLeistungen:(NSOrderedSet *)values;

- (void)insertObject:(Leistung *)value inMaschinenAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMaschinenAtIndex:(NSUInteger)idx;
- (void)insertMaschinen:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMaschinenAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMaschinenAtIndex:(NSUInteger)idx withObject:(Leistung *)value;
- (void)replaceMaschinenAtIndexes:(NSIndexSet *)indexes withMaschinen:(NSArray *)values;
- (void)addMaschinenObject:(Leistung *)value;
- (void)removeMaschinenObject:(Leistung *)value;
- (void)addMaschinen:(NSOrderedSet *)values;
- (void)removeMaschinen:(NSOrderedSet *)values;

- (void)insertObject:(Leistung *)value inMaterialAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMaterialAtIndex:(NSUInteger)idx;
- (void)insertMaterial:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMaterialAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMaterialAtIndex:(NSUInteger)idx withObject:(Leistung *)value;
- (void)replaceMaterialAtIndexes:(NSIndexSet *)indexes withMaterial:(NSArray *)values;
- (void)addMaterialObject:(Leistung *)value;
- (void)removeMaterialObject:(Leistung *)value;
- (void)addMaterial:(NSOrderedSet *)values;
- (void)removeMaterial:(NSOrderedSet *)values;

@end
