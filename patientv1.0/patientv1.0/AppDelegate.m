//
//  AppDelegate.m
//  patientv1.0
//
//  Created by liyongli on 15-7-1.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "AppDelegate.h"
#import "classes/baseUi/BaseNavigationController.h"
#import "classes/main/login/SignInViewController.h"

#import "AskUnExecptionHandler.h"



#import "LibuiFun.h"

#import "Student.h"
#import "Teacher.h"





#define ksaveLocal(key,value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define kgetLocalData(key) [[NSUserDefaults standardUserDefaults] objectForKey:key];

@interface AppDelegate ()
{
    BaseNavigationController * _nav;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    [self initApp];
    
        
    SignInViewController *loginVC = [[SignInViewController alloc]init];
    _nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = _nav;

    
    int flagInt;
    flagInt = 0;
    
    if (flagInt == 0)
    {

    }
    else
    {
       
        
    }
   
    return YES;
}


-(void)initApp
{
    //处理异常
    AskInstallUncaughtExceptionHandler();
    //初始化单利类
    self.singleton = [Singleton GetInstance];
    
    
    NSObject *valueObj;
    [self.singleton.localDB createDataTable];
    [self.singleton.localDB setItem:@"firstStart0" valueObj:@"第一数据"];
    valueObj = [self.singleton.localDB getItem:@"firstStart0"];
    NSLog(@"  第一数据  查询的结果 %@", valueObj);

    
    
    [self.singleton.localDB setItem:@"firstStart0" valueObj:@"第二"];
//    [self.singleton.localDB setItem:@"firstStart2" valueObj:@"Yesdfsfs"];
//    [self.singleton.localDB setItem:@"firstStart3" valueObj:@"Yesdfsdfs"];
//    [self.singleton.localDB setItem:@"firstStart4" valueObj:@"Yesdfs"];
//    [self.singleton.localDB setItem:@"firstStart5" valueObj:@"dsfsdfsd"];

      valueObj = [self.singleton.localDB getItem:@"firstStart0"];
//    NSObject *valueObj = [self.singleton.localDB getAllData];
   
      NSLog(@" 第二查询的结果 %@", valueObj);
    
    
    // 获取沙盒主目录路径
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"homeDir %@", homeDir);

    // Documents
    NSString *filePath =  [self filePath:@"tempFileName.jpg"];
    NSLog(@"filePath %@", filePath);
    //tmp
    NSString* tempPath = NSTemporaryDirectory();
    NSLog(@"tempPath %@", tempPath);
    
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSLog(@"cachesDir %@", cachesDir);
    
    
    
    
    NSString* fileName = [self filePath:@"properties.plist"];
    NSLog(@"fileName  %@", fileName);
    NSMutableArray* data = [[NSMutableArray alloc]init];
    [data addObject:@"1001"];
    [data addObject:@"李永利"];
    [data addObject:@"计算机"];
    [data writeToFile:fileName atomically:YES];
    
    ksaveLocal(@"classData", data);
//    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
    
    NSMutableArray* tempData = kgetLocalData(@"classData");
    NSLog(@"classData   %@ ", tempData);

    
    //归档
    Student *student        = [[Student alloc] init];
    student.name            = @"李永利";
    student.studentNumber   = @"442991186";
    student.sex             = @"男";
    
    //这是一个存放全班同学的数组
    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:50];
    //将student类型变为NSData类型
    NSData *studentData = [NSKeyedArchiver archivedDataWithRootObject:student];
    //存放数据的数组将data加入进去
    [dataArray addObject:studentData];
    [dataArray addObject:studentData];
    
    //通过 NSUserDefaults  存储到本地
    NSData *oneStudentData = [NSKeyedArchiver archivedDataWithRootObject:student];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //存储一个学生
    [user setObject:oneStudentData forKey:@"oneStudent"];
     //存储多个学生
//    [user setObject:dataArray forKey:@"allStudent"];
    
    //读取一个学生的数据
    NSData *getData = [user objectForKey:@"oneStudent"];
    Student *getStudent = [NSKeyedUnarchiver unarchiveObjectWithData:getData];
    NSLog(@"getStudent.name %@", getStudent.name);
    NSLog(@"studentNumber %@", getStudent.studentNumber);

    

    //sqlite什么类型都可以存储， 不用转换成NSData
//    Teacher *teacher = [[Teacher alloc] init];
//    teacher.name            = @"刘三";
//    teacher.studentNumber   = @"10002";
//    teacher.sex             = @"男";    
    [self.singleton.localDB setItem:@"oneTeacher" valueObj:student];
    valueObj = [self.singleton.localDB getItem:@"oneTeacher"];
    Student *sqlGetStudent = (Student *)valueObj;
    NSLog(@" SQLite sqlGetStudent.name          查询的结果 %@", sqlGetStudent.name );
    NSLog(@" SQLite sqlGetStudent.studentNumber 查询的结果 %@", sqlGetStudent.studentNumber);
    NSLog(@" SQLite sqlGetStudent.sex           查询的结果 %@", sqlGetStudent.sex );
  
}


- (NSString*)filePath:(NSString*)fileName
{
    NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* filePath = [myDocPath stringByAppendingPathComponent:fileName];
    return filePath;
}







- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ask.patientv1_0" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"patientv1_0" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"patientv1_0.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
