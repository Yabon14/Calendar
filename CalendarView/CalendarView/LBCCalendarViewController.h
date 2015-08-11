//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>

@class LBCCalendarObject;

@interface LBCCalendarViewController : UIViewController
@property (nonatomic, strong) LBCCalendarObject *calendarObject;

@property (nonatomic, strong) IBOutlet UIView *calView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;
@property (weak, nonatomic) IBOutlet UIView *calBGView;
@end
