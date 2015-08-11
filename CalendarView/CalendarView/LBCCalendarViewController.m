//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarViewController.h"
#import "LBCCalendarObject.h"
#import "LBCMonthView.h"


@implementation LBCCalendarViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.calBGView.backgroundColor = [UIColor yellowColor];
    self.calendarObject = [[LBCCalendarObject alloc] init];
//    UIView *calView = [self.calendarObject buildCalendarViewInFrame:self.view.frame];
//    [self.view addSubview:calView];
    
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
    
//    NSLog(@"%@", NSStringFromCGRect(self.calView.frame));
//    if (self.view.frame.size.width < self.view.frame.size.height){
//        self.topSpace.constant = self.view.frame.size.height * 0.5f - self.view.frame.size.width * 0.5f;
//    }
//    else{
//        self.topSpace.constant = 0.f;
//    }
//    [self.calView setNeedsUpdateConstraints];
//    NSLog(@"%@", NSStringFromCGRect(self.calView.frame));
}


- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"self.calBGView.frame: %@", NSStringFromCGRect(self.calBGView.frame));
    [self.calendarObject buildCalendarViewInView:self.view];
    
    NSLog(@"self.calBGView.frame: %@", NSStringFromCGRect(self.calendarObject.monthView.frame));
    

//    if (self.view.frame.size.width < self.view.frame.size.height){
//        self.topSpace.constant = self.view.frame.size.height * 0.5f - self.view.frame.size.width * 0.5f;
//    }
//    else{
//        self.topSpace.constant = 0.f;
//    }
//    [self.view setNeedsUpdateConstraints];
}


- (void) addSelection:(id)sender{
    
//    self.topSpace.constant = 124.f;
//    [self.calView setNeedsUpdateConstraints];
    
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    [dateComponents setDay:24];
//    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
//    [dateComponents setDay:31];
//    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
//    
//   
//    [self.calendarObject addSelectionFromDate:startDate toDate:endDate];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
//    self.calBGView.center = CGPointMake(self.calBGView.center.x, self.calBGView.center.y + 10);
    
//    [self.calendarObject updateCalendarView:self.calBGView];
    
//    [self.calendarObject updateCalendarFrame:CGRectMake(0, 0, size.width, size.height)];

    
//    if (size.width < size.height){
//        self.topSpace.constant = size.height * 0.5f - size.width * 0.5f;
//    }
//    else{
//        self.topSpace.constant = 0.f;
//    }
//    [self.view setNeedsUpdateConstraints];
//    
//    NSLog(@"self.calView.frame: %@", NSStringFromCGRect(self.calView.frame));
//    NSLog(@"self.view.frame: %@", NSStringFromCGRect(self.view.frame));
//    NSLog(@"size: %@", NSStringFromCGSize(size));
//    NSLog(@"self.topSpace.constant: %f", self.topSpace.constant);

}

@end

