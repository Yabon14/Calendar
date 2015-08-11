//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>

@class LBCCalendarView;

@interface LBCCalendarViewControllerConstraint : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calViewHeight;
@property (nonatomic, strong) IBOutlet UIView *calView;
@property (nonatomic, strong) LBCCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calViewWidth;
@end
