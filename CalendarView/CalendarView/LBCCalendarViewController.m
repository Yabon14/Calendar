//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarViewController.h"
#import "LBCCalendarView.h"

@implementation LBCCalendarViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

    self.calObject = [[LBCCalendarObject alloc] init];
    
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
    
    [dateComponents setDay:80];
    NSDate *startDate4 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:90];
    NSDate *endDate4 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    [dateComponents setDay:-20];
    NSDate *startDate5 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    [dateComponents setDay:-5];
    NSDate *endDate5 = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    
    LBCSelection *selec = [[LBCSelection alloc] initWithStartDate:startDate andEndDate:endDate andPrice:200];
    LBCSelection *selec2 = [[LBCSelection alloc] initWithStartDate:startDate2 andEndDate:endDate2 andPrice:300];
    LBCSelection *selec3 = [[LBCSelection alloc] initWithStartDate:startDate3 andEndDate:endDate3 andPrice:350];
    LBCSelection *selec4 = [[LBCSelection alloc] initWithStartDate:startDate4 andEndDate:endDate4 andPrice:100];
    LBCSelection *selec5 = [[LBCSelection alloc] initWithStartDate:startDate5 andEndDate:endDate5 andPrice:390];
    
    [self.calObject buildCalendarViewInView:self.calView withDelegate:self andSelectionArray:@[selec, selec2, selec3, selec4, selec5]];

    
    [self displayFromOfSubviewInView:self.view];
}


- (IBAction)selector:(id)sender{
    NSLog(@"selector");
}


- (void) displayFromOfSubviewInView:(UIView *)view{
    for (UIView * v in view.subviews) {
        NSLog(@"Tag: %lu   and frame: %@ ", (long)v.tag, NSStringFromCGRect(v.frame));
        [self displayFromOfSubviewInView:v];
    }
}


- (void)calendarFrameHasChangedOfFrame:(CGRect)frame{
    NSLog(@"frame: %@", NSStringFromCGRect(frame));
}

@end

