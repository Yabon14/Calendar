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
@property (nonatomic, strong) NSDateComponents *dateComponents;
@property (nonatomic, assign) BOOL isLastDayInMonth;
@property (nonatomic, strong) UIView *containerView;

- (void) refreshWithComponent:(NSDateComponents *)component
                  andDayState:(DayState)state
                   andDayFont:(UIFont *)dayFont;
- (NSDate *)dateForDayView;
@end
