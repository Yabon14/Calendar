//
//  LBCCalendarViewController.h
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import <UIKit/UIKit.h>
#import "LBCCalendarObject.h"


@interface LBCCalendarViewController : UIViewController <CalendarDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calViewHeight;
@property (nonatomic, strong) IBOutlet UIView *calView;
@property (nonatomic, strong) LBCCalendarObject *calObject;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calViewWidth;

@end
