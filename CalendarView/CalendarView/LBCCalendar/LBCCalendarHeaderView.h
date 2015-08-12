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

@property (nonatomic, weak) IBOutlet UILabel *monthLabel;

@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;

@property (nonatomic, weak) IBOutlet UILabel *dayLabel1;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel2;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel3;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel4;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel5;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel6;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel7;


- (void) refreshWithCalendarObject:(LBCCalendarObject *)calendarObject;

@end
