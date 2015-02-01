//
//  TbAppDelegate.m
//  Tagesbericht
//
//  Created by Matthias Burbach on 21.04.13.
//  Copyright (c) 2013 Matthias Burbach. All rights reserved.
//

#import "TbAppDelegate.h"
#import "NSManagedObjectModel+KCOrderedAccessorFix.h"

@interface TbAppDelegate ()

@property (strong, nonatomic) NSPersistentStoreCoordinator *dataStore;
@property (strong, nonatomic) NSManagedObjectModel *dataModel;
@property (strong, nonatomic) NSManagedObjectContext *dataContext;

- (NSPersistentStoreCoordinator*)dataStoreForModel:(NSManagedObjectModel*)model filename:(NSString*)filename;

@end

@implementation TbAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self configureCoreData];
    [self loadTagesberichte];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self saveTagesberichte];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveTagesberichte];
}

- (NSString*)docsDir
{
    NSArray *paths =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (NSPersistentStoreCoordinator*)dataStoreForModel:(NSManagedObjectModel*)model filename:(NSString*)filename
{
    NSURL* storeLocation =
        [NSURL fileURLWithPath:[[self docsDir] stringByAppendingPathComponent:filename]];
    
    NSPersistentStoreCoordinator* store =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSDictionary *options =
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES],
            NSMigratePersistentStoresAutomaticallyOption,
            [NSNumber numberWithBool:YES],
            NSInferMappingModelAutomaticallyOption, nil];
    
    NSError* error;
    if (![store
          addPersistentStoreWithType:NSSQLiteStoreType
          configuration:nil
          URL:storeLocation
          options:options
          error:&error])
    {
        NSLog(@"Error initalizing Data Store: %@",
              [error localizedDescription]);
        return nil;
    }
    return store;
}

-(void)configureCoreData
{
    self.dataModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    [self.dataModel kc_generateOrderedSetAccessors];
    self.dataStore = [self dataStoreForModel:self.dataModel filename:@"Tagesbericht.sqlite"];
    self.dataContext = [[NSManagedObjectContext alloc] init];
    [self.dataContext setPersistentStoreCoordinator:self.dataStore];
}

-(void)loadTagesberichte
{
    NSEntityDescription *entityDescription =
        [NSEntityDescription entityForName:@"Tagesbericht" inManagedObjectContext:self.dataContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    /*
    NSNumber *minimumSalary = ...;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(lastName LIKE[c] 'Worsley') AND (salary > %@)", minimumSalary];
    [request setPredicate:predicate];
    */
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"datum" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [self.dataContext executeFetchRequest:request error:&error];
    if (!array) {
        NSLog(@"Error loading Tagesberichte:%@", error);
    } else {
        NSLog(@"Loaded Tagesberichte.");
        self.tagesberichte = [NSMutableArray arrayWithArray:array];
    }
}

-(void)saveTagesberichte
{
    NSError *error;
    if (![self.dataContext save:&error]) {
        NSLog(@"Error saving Tagesberichte:%@", error);
    } else {
        NSLog(@"Saved Tagesberichte.");
    }
}

- (Tagesbericht *)createTagesbericht
{
    Tagesbericht *tagesbericht =
        [NSEntityDescription
            insertNewObjectForEntityForName:@"Tagesbericht"
            inManagedObjectContext:self.dataContext];
    return tagesbericht;
}

- (void)deleteTagesbericht:(Tagesbericht *)tagesbericht
{
    [[self dataContext] deleteObject:tagesbericht];
}

- (Leistung *)createLeistung
{
    Leistung *leistung =
        [NSEntityDescription
            insertNewObjectForEntityForName:@"Leistung"
            inManagedObjectContext:self.dataContext];
    return leistung;
}

- (void)deleteLeistung:(Leistung *)leistung
{
    [[self dataContext] deleteObject:leistung];
}

- (NSArray *)alleNamen
{
    NSMutableOrderedSet *result = [[NSMutableOrderedSet alloc] init];
    for (Tagesbericht* tagesbericht in self.tagesberichte) {
        for (Leistung* leistung in tagesbericht.leistungen) {
            if (leistung.name) {
                [result addObject:leistung.name];
            }
        }
    }
    return [result array];
}

- (NSArray *)alleBeschreibungenForLeistungsart:(enum Leistungsart)leistungsart
{
    NSMutableOrderedSet *result = [[NSMutableOrderedSet alloc] init];
    for (Tagesbericht* tagesbericht in self.tagesberichte) {
        NSOrderedSet *leistungen;
        if (leistungsart == Lst_Leistung) {
            leistungen = tagesbericht.leistungen;
        } else if (leistungsart == Lst_Maschine) {
            leistungen = tagesbericht.maschinen;
        } else { // leistungsart == Lst_Material
            leistungen = tagesbericht.material;
        }
        for (Leistung* leistung in leistungen) {
            if (leistung.beschreibung) {
                [result addObject:leistung.beschreibung];
            }
        }
    }
    return [result array];
}

@end
