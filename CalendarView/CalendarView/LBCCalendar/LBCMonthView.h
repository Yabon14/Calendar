//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>

@class LBCCalendarObject;

@interface LBCMonthView : UIView
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) LBCCalendarObject *calendarObject;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGFloat xPosition;
@property (nonatomic, assign) CGFloat yPosition;

- (id) initWithCalendarObject:(LBCCalendarObject *)calendarObject andFrame:(CGRect)frame;
- (void) refreshView;

@end

