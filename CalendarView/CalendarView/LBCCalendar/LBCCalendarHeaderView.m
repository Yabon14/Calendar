//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarHeaderView.h"
#import "LBCCalendarObject.h"


@implementation LBCCalendarHeaderView

- (void) refreshWithCalendarObject:(LBCCalendarObject *)calendarObject{

    self.monthLabel.backgroundColor = [UIColor clearColor];
    self.monthLabel.text = [calendarObject getCurrentMonthYearName];
        
    self.leftButton.tag = LEFT_ARROW_TAG;
    self.rightButton.tag = RIGHT_ARROW_TAG;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.leftButton addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:calendarObject action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop

    
    NSArray *dayArray = @[@"Sa", @"Di", @"Lu", @"Ma", @"Me", @"Je", @"Ve"];
    NSArray *dayLabelArray = @[self.dayLabel1, self.dayLabel2, self.dayLabel3, self.dayLabel4, self.dayLabel5, self.dayLabel6, self.dayLabel7];

    CGFloat fontSize = 9999;
    for (UILabel *dayLabel in dayLabelArray) {
        [dayLabel setAdjustsFontSizeToFitWidth:YES];
        fontSize = fontSize > dayLabel.font.pointSize ? dayLabel.font.pointSize : fontSize;
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.text = [dayArray objectAtIndex:[dayLabelArray indexOfObject:dayLabel]];
        dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    for (UILabel *dayLabel in dayLabelArray) {
        dayLabel.font = [UIFont systemFontOfSize:fontSize];
    }
        
    self.backgroundColor = [UIColor clearColor];
}


@end


