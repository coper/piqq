//
//  AppDelegate.h
//  patientv1.0
//
//  Created by liyongli on 15-7-1.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Singleton.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//自定义
//单利类
@property (strong, nonatomic) Singleton *singleton;





- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

