//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>

@class LBCCalendarObject;

@interface LBCCalendarHeaderView : UIView
@property (nonatomic, strong) UILabel *monthLabel;
- (id)initWithFrame:(CGRect)frame andCalendarObject:(LBCCalendarObject *)calendarObject;
@end
