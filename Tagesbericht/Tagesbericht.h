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

@property (nonatomic, retain) NSString * auftraggeber;
@property (nonatomic, retain) NSString * baustelle;
@property (nonatomic, retain) NSDate * datum;
@property (nonatomic, retain) NSDate * zuletztGeaendert;
@property (nonatomic, retain) NSDate * zuletztGesendet;
@property (nonatomic, retain) NSString * notizen;
@property (nonatomic, retain) NSData * unterschrift;
@property (nonatomic, retain) NSOrderedSet *leistungen;
@property (nonatomic, retain) NSOrderedSet *maschinen;
@property (nonatomic, retain) NSOrderedSet *material;

/*
- (int)leistungsstunden;
- (int)leistungsminuten;

- (int)maschinenstunden;
- (int)maschinenminuten;
*/
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
