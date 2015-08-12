//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarViewControllerConstraint.h"
#import "LBCCalendarView.h"
#import "LBCCalendarObject.h"

@implementation LBCCalendarViewControllerConstraint

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    self.calendarView = [[[NSBundle mainBundle] loadNibNamed:@"LBCCalendarView" owner:nil options:nil] objectAtIndex:0];
//    [self.calView addSubview:self.calendarView];
    
//    LBCCalendarObject *co = [[LBCCalendarObject alloc] init];
//    [co buildCalendarViewInView:self.calView];
    
    
//    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)];
//    [self.view addGestureRecognizer:tg];

//    [self.calendarView addHeightConstraint];
//    self.calView.clipsToBounds = YES;
}


- (void)action{

//    self.calendarView.calendarHeight.constant += 10;
    
//    self.calendarView.footerHeight.constant += 10;
    
//    CGRect frame = self.calendarView.frame;
//    frame.size.height += 10;
//    self.calendarView.frame = frame;
    
    self.calViewHeight.constant = [self.calendarView getNewFrameHeight];
    
    
//    self.calViewWidth.constant += 10;
    
//    CGRect frame2 = self.calView.frame;
//    frame2.size.height += 10;
//    self.calView.frame = frame2;
    
    [self displayFromOfSubviewInView:self.view];
}


- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

//    UIView *v = [[UIView alloc] initWithFrame:self.calView.frame];
//    [self.view addSubview:v];
//    v.alpha = 0.5f;
//    v.backgroundColor = [UIColor redColor];
    
    LBCCalendarObject *co = [[LBCCalendarObject alloc] init];
    [co buildCalendarViewInView:self.calView];
    
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
    
    [co addSelectionArray:@[selec, selec2, selec3]];


    [self displayFromOfSubviewInView:self.view];
}


- (void) displayFromOfSubviewInView:(UIView *)view{
    for (UIView * v in view.subviews) {
        NSLog(@"Tag: %lu   and frame: %@ ", (long)v.tag, NSStringFromCGRect(v.frame));
        [self displayFromOfSubviewInView:v];
    }
}




@end

