//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarViewController.h"
#import "LBCCalendarObject.h"



@implementation LBCCalendarViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.calendarObject = [[LBCCalendarObject alloc] init];
    UIView *calView = [self.calendarObject buildCalendarViewInFrame:self.view.frame];
    [self.view addSubview:calView];
    
    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addSelection:)];
    [self.view addGestureRecognizer:tg];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:10];
    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:30];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    
    LBCSelection *selec = [[LBCSelection alloc] initWithStartDate:startDate andEndDate:endDate];
    
    [self.calendarObject addSelectionArray:@[selec]];
    //    [self.calendarObject addSelectionFromDate:startDate toDate:endDate];
}


- (void) addSelection:(id)sender{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:24];
    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:30];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    
    LBCSelection *selec = [[LBCSelection alloc] initWithStartDate:startDate andEndDate:endDate];
    
    [self.calendarObject addSelectionArray:@[selec]];
    //    [self.calendarObject addSelectionFromDate:startDate toDate:endDate];
}

@end

