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
    [dateComponents setDay:24];
    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:31];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    [dateComponents setDay:30];
    NSDate *startDate2 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:40];
    NSDate *endDate2 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    [dateComponents setDay:45];
    NSDate *startDate3 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:48];
    NSDate *endDate3 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    
    LBCSelection *selec = [[LBCSelection alloc] initWithStartDate:startDate andEndDate:endDate];
    LBCSelection *selec2 = [[LBCSelection alloc] initWithStartDate:startDate2 andEndDate:endDate2];
    LBCSelection *selec3 = [[LBCSelection alloc] initWithStartDate:startDate3 andEndDate:endDate3];
    
    [self.calendarObject addSelectionArray:@[selec, selec2, selec3]];
}


- (void) addSelection:(id)sender{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:24];
    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:31];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
   
    [self.calendarObject addSelectionFromDate:startDate toDate:endDate];
}

@end

