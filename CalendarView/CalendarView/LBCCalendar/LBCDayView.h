//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>
#import "LBCCalendarObject.h"


@interface LBCDayView : UILabel

@property (nonatomic, assign) DayState dayState;
//@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) NSDateComponents *dateComponents;
@property (nonatomic, assign) BOOL isLastDayInMonth;

- (void) refreshWithComponent:(NSDateComponents *)component
                  andDayState:(DayState)state;
- (NSDate *)dateForDayView;
@end
