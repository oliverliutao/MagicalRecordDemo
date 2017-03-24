//
//  AppDelegate.h
//  TestMagicalRecord
//
//  Created by 黄辉 on 24/3/17.
//  Copyright © 2017 OLIVER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

