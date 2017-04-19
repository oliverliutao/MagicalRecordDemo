//
//  ViewController.m
//  TestMagicalRecord
//
//  Created by 黄辉 on 24/3/17.
//  Copyright © 2017 OLIVER. All rights reserved.
//

#import "ViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "PersonInfo+CoreDataClass.h"
#import "Company+CoreDataClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PersonInfo *info = [PersonInfo MR_findFirstByAttribute:@"myname" withValue:@"liutao" inContext:[NSManagedObjectContext MR_defaultContext]];
    
    if(info) {
        
        
        info.myweight = 999;
        
        Company *mozat = [Company MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
        mozat.companyName = @"mozat";
        mozat.whichOne = 1;
        
        Company *nationz = [Company MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
        nationz.companyName = @"nationz";
        nationz.whichOne = 1;
        
        NSMutableSet<Company*> *set = [NSMutableSet setWithObjects:mozat,nationz, nil];
        
        [info addPersonandcompany:set];
        
    }else {
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
            
            NSInteger catNumber = [[PersonInfo MR_numberOfEntities] integerValue];
            NSLog(@"MR_numberOfEntities %ld",(long)catNumber);
            
            PersonInfo *cat1 = [PersonInfo MR_createEntityInContext:localContext];
            cat1.myname = @"liutao";
            cat1.myage = 100;
            cat1.myaddress = @"singapore";
            
        } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
            
            
        }];
    }

}


- (IBAction)readData:(id)sender {
    
    
    PersonInfo *info = [PersonInfo MR_findFirstByAttribute:@"myname" withValue:@"liutao" inContext:[NSManagedObjectContext MR_defaultContext]];
//    NSLog(@"company = %@",info.personandcompany);
    
    
    //fetch
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"whichOne=1"];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    
    //设置过滤条件
    [fetchRequest setPredicate:predicate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Company"          inManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    //设置搜索哪个Entity
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"companyName"  ascending:YES];
    //设置排序准则
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    [fetchRequest setFetchLimit:1];
    
    
    
    
    NSError *error = nil;
    NSArray *arrTemp = [[NSManagedObjectContext MR_defaultContext] executeFetchRequest:fetchRequest error:&error];
    
    if([arrTemp count]>0){
        
        
        for (Company *com in arrTemp) {
            
            NSLog(@"%@",com.companyName);
        }
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
