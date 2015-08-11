//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>

@class LBCCalendarObject;

@interface LBCCalendarMonthView : UIView
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) LBCCalendarObject *calendarObject;
@property (nonatomic, assign) CGFloat size;

- (id) initWithCalendarObject:(LBCCalendarObject *)calendarObject andFrame:(CGRect)frame;
- (void) refreshView;

@end

