//
//  LBCCalendarViewController.m
//  
//
//  Created by Yann BONAFONS on 06/08/2015.
//
//

#import "LBCCalendarObject.h"
#import "LBCDayView.h"
#import "LBCCalendarMonthView.h"
#import "LBCCalendarHeaderView.h"
#import "LBCCalendarView.h"
#import "LBCCalendarFooterView.h"

@implementation LBCSelection

- (id) initWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate andPrice:(NSInteger)price{
    self = [super init];
    if (self){
        self.startDate = startDate;
        self.endDate = endDate;
        self.price = price;
    }
    return self;
}

@end



@interface LBCCalendarObject()
@property (nonatomic, strong) LBCCalendarView *calendarView;

@property (nonatomic, strong) NSDate *dateMin;
@property (nonatomic, strong) NSDate *dateMax;
@property (nonatomic, assign) BOOL canGoToPreviousMonth;
@property (nonatomic, assign) BOOL canGoToNextMonth;

@property (nonatomic, strong) NSArray * selectionArray;
@property (nonatomic, strong) NSArray * selectionCurrentMonthArray;

@property (nonatomic, weak) id <CalendarDelegate> delegate;
@end

@implementation LBCCalendarObject

- (id) init{
    self = [super init];
    if (self){
        self.currentMonth = 0;
        self.dateMin = nil;
        self.startDate = [NSDate date];
        self.dateMax = nil;
        
        self.canGoToPreviousMonth = YES;
        self.canGoToNextMonth = YES;
    }
    return self;
}


-(void) dealloc{
}


- (BOOL) addSelectionFromDate:(NSDate *)startDate toDate:(NSDate *)endDate{
    
    BOOL selectionInCurrentMonth = NO;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:startDate];
    startDate = [calendar dateFromComponents:components];
    
    components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:endDate];
    endDate = [calendar dateFromComponents:components];
    

    for (LBCDayView *dayView in self.calendarView.monthView.dayArray) {
        
        if (dayView.dayState != dayStateUnactive &&
            (([[dayView dateForDayView] compare:startDate] == NSOrderedDescending && [[dayView dateForDayView] compare:endDate] == NSOrderedAscending)
            || [[dayView dateForDayView] compare:startDate] == NSOrderedSame
            || [[dayView dateForDayView] compare:endDate] == NSOrderedSame))
        {
            selectionInCurrentMonth = YES;
            BOOL leftCurve = NO;
            BOOL rightCurve = NO;
            
            if (dayView.dateComponents.weekday == weekDayFriday) {
                rightCurve = YES;
            }
            else if (dayView.dateComponents.weekday == weekDaySaturday) {
                leftCurve = YES;
            }
            if (dayView.dateComponents.day == 1) {
                leftCurve = YES;
            }
            if ([dayView isLastDayInMonth]) {
                rightCurve = YES;
            }
            if ([[dayView dateForDayView] compare:startDate] == NSOrderedSame){
                leftCurve = YES;
            }
            if ([[dayView dateForDayView] compare:endDate] == NSOrderedSame){
                rightCurve = YES;
            }
            
            if (leftCurve && !rightCurve){
                dayView.dayState = dayStateFirstSelected;
            }
            else if (!leftCurve && rightCurve){
                dayView.dayState = dayStateLastSelected;
            }
            else if (leftCurve && rightCurve){
                dayView.dayState = dayStateBothSelected;
            }
            else{
                dayView.dayState = dayStateSelected;
            }
        }
    }
    
    return selectionInCurrentMonth;
}


- (void) configureCalendar{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:self.currentMonth];
    NSDate *dateForCurrentMonth = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
    NSRange rng = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateForCurrentMonth];
    self.maxDayOfCurrentMonth = rng.length;
    
    [dateComponents setMonth:self.currentMonth - 1];
    NSDate *dateForPreviousMonth = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
    rng = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateForPreviousMonth];
    self.maxDayOfLastMonth = rng.length;
    
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateForCurrentMonth];
    [components setDay:1];
    
    NSDate *firstDayToShow = [calendar dateFromComponents:components];
    NSDateComponents *newComponents = [calendar components: NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:firstDayToShow];
    while (newComponents.weekday != weekDaySaturday) {
        NSDateComponents *comps = [NSDateComponents new];
        comps.day   = -1;
        firstDayToShow = [calendar dateByAddingComponents:comps toDate:firstDayToShow options:0];
        newComponents = [[NSCalendar currentCalendar] components: NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:firstDayToShow];
    }
    self.firstDayOfLastMonth = newComponents.day;
    self.firstDayOfLastMonth = self.firstDayOfLastMonth == 1 ? self.maxDayOfLastMonth + 1 : self.firstDayOfLastMonth;
}



- (NSString *)getCurrentMonthYearName{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:self.currentMonth];
    NSDate *dateForCurrentMonth = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self.startDate options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM YYYY"];
    NSString *stringFromDate = [formatter stringFromDate:dateForCurrentMonth];
    return [stringFromDate capitalizedString];
}




- (void) buildCalendarViewInView:(UIView *)view withDelegate:(id)delegate andSelectionArray:(NSArray *)selectionArray{
    self.delegate = delegate;
    
    if (selectionArray){
        [self addSelectionArray:selectionArray];
    }
    [self configureCalendar];
    
    self.calendarView = [[[NSBundle mainBundle] loadNibNamed:@"LBCCalendarView" owner:nil options:nil] objectAtIndex:0];
    self.calendarView.footerView.delegate = self;
    self.calendarView.footerView.dataSource = self;
    [view addSubview:self.calendarView];

    
    [self.calendarView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.calendarView.footerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.calendarView
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1
                                                                   constant:0]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.calendarView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1
                                                                   constant:0]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.calendarView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
    
    

    [view updateConstraints];
    
    
    [self.calendarView.monthView refreshWithCalendarObject:self];
    [self.calendarView.headerView refreshWithCalendarObject:self];
    [self clampPosition];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeIsDone:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeIsDone:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.calendarView.monthView addGestureRecognizer:leftSwipe];
    [self.calendarView.monthView addGestureRecognizer:rightSwipe];
    
    
    [self performSelector:@selector(addSelectionForCurrentMonth) withObject:nil afterDelay:0.f];
}




-(void)swipeIsDone:(UISwipeGestureRecognizer *)swipe{

    UIButton *button = [[UIButton alloc] init];
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        button.tag = LEFT_ARROW_TAG;
    }
    else{
        button.tag = RIGHT_ARROW_TAG;
    }
    
    [self buttonPressed:button];
}





- (void) addSelectionArray:(NSArray *)selectionArray{
    
    self.selectionArray = selectionArray;
    
    LBCSelection *firstSelection = [self.selectionArray objectAtIndex:0];
    self.dateMin = firstSelection.startDate;
    self.dateMax = firstSelection.endDate;
    
    for (LBCSelection *selection in self.selectionArray) {
        if ([self.dateMin compare:selection.startDate] == NSOrderedDescending) {
            self.dateMin = selection.startDate;
        }
        if ([self.dateMax compare:selection.endDate] == NSOrderedAscending) {
            self.dateMax = selection.endDate;
        }
    }
    self.startDate = self.dateMin;
}






- (void) addSelectionForCurrentMonth{
    if (!self.selectionArray)
        return;
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    for (LBCSelection *selection in self.selectionArray) {
        if ([self addSelectionFromDate:selection.startDate toDate:selection.endDate]){
            [tmpArray addObject:selection];
        }
    }
    self.selectionCurrentMonthArray = [NSArray arrayWithArray:tmpArray];
    
    CGFloat newFooterHeight = [self.selectionCurrentMonthArray count] * CELL_HEIGHT;
    self.calendarView.footerView.footerHeight.constant = newFooterHeight;
    [self.calendarView.footerView reloadData];
    
    [self.calendarView updateConstraints];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarFrameHasChangedOfFrame:)]){
        CGRect newFrame = CGRectMake(0,
                                     0,
                                     self.calendarView.frame.size.width,
                                     self.calendarView.headerView.frame.size.height + self.calendarView.monthView.frame.size.height + newFooterHeight);
        [self.delegate calendarFrameHasChangedOfFrame:newFrame];
    }
}





- (IBAction) buttonPressed:(id)sender{

    UIButton *b = (UIButton *)sender;
    NSInteger monthDirection = 1;
    
    BOOL updateMonth = NO;
    
    if (b.tag == RIGHT_ARROW_TAG){
        
        if (self.canGoToNextMonth){
            self.currentMonth++;
            updateMonth = YES;
        }
    }
    else if (b.tag == LEFT_ARROW_TAG){
        
        if (self.canGoToPreviousMonth){
            self.currentMonth--;
            monthDirection = -1;
            updateMonth = YES;
        }
    }
    
    if (updateMonth){
        [self configureCalendar];
        [self clampPosition];
        [self animateAndUpdateMonthInDirection:monthDirection];
    }
}




- (void) animateAndUpdateMonthInDirection:(NSInteger)monthDirection{
    // Take snapshot of current month
    UIImageView *currentMonth = [[UIImageView alloc] initWithFrame:self.calendarView.monthView.frame];
    currentMonth.image = [self takeSnapshotFromView:self.calendarView.monthView];
    
    // update current month
    [self.calendarView.monthView refreshWithCalendarObject:self];
    [self addSelectionForCurrentMonth];
    
    // Take snapshot of updated month
    CGRect newFrame = self.calendarView.monthView.frame;
    CGFloat width = newFrame.size.width;
    newFrame.origin.x = newFrame.origin.x + width * monthDirection;
    UIImageView *nextMonth = [[UIImageView alloc] initWithFrame:newFrame];
    nextMonth.image = [self takeSnapshotFromView:self.calendarView.monthView];
    
    // Animation
    [self.calendarView addSubview:currentMonth];
    [self.calendarView addSubview:nextMonth];
    self.calendarView.monthView.hidden = YES;
    [self.calendarView setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.5f
                     animations:^{
                         
                         CGRect newCurrentMonthFrame = currentMonth.frame;
                         newCurrentMonthFrame.origin.x = newCurrentMonthFrame.origin.x - width * monthDirection;
                         currentMonth.frame = newCurrentMonthFrame;
                         
                         CGRect newNextMonthFrame = nextMonth.frame;
                         newNextMonthFrame.origin.x = newNextMonthFrame.origin.x - width * monthDirection;
                         nextMonth.frame = newNextMonthFrame;
                         
                     } completion:^(BOOL finished) {
                         [self.calendarView setUserInteractionEnabled:YES];
                         [currentMonth removeFromSuperview];
                         [nextMonth removeFromSuperview];
                         self.calendarView.monthView.hidden = NO;
                     }];
    
    
    // Update header
    self.calendarView.headerView.monthLabel.text = [self getCurrentMonthYearName];
}




- (void) clampPosition{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    [dateComponents setMonth:(self.currentMonth + 1)];
    NSDate *dateForNextMonth = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
    NSDateComponents *newComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dateForNextMonth];
    [newComponents setDay:1];
    NSDate *firstDayOfNextMonth = [calendar dateFromComponents:newComponents];
    
    if (!self.dateMax || [firstDayOfNextMonth compare:self.dateMax] != NSOrderedDescending){
        self.canGoToNextMonth = YES;
    }
    else{
        self.canGoToNextMonth = NO;
    }
    self.calendarView.headerView.rightButton.hidden = !self.canGoToNextMonth;


    if (!self.dateMin || self.currentMonth > 0){
        self.canGoToPreviousMonth = YES;
    }
    else{
        self.canGoToPreviousMonth = NO;
    }
    self.calendarView.headerView.leftButton.hidden = !self.canGoToPreviousMonth;
}




- (UIImage *)takeSnapshotFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger maxRow = [self.selectionCurrentMonthArray count];
    return maxRow;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    
    if (!cell){
        cell.userInteractionEnabled = YES;
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = F7;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    LBCSelection *selection = [self.selectionCurrentMonthArray objectAtIndex:indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSString *startDate = [formatter stringFromDate:selection.startDate];
    NSString *endDate = [formatter stringFromDate:selection.endDate];


    NSString *priceString = [NSString stringWithFormat:NSLocalizedString(@"%lu€", @"%lu€"), selection.price];
    NSString *completeString = [NSString stringWithFormat:NSLocalizedString(@"Du %@ au %@ : %@", @"Du %@ au %@ : %@"), startDate, endDate, priceString];
    NSRange priceRange = [completeString rangeOfString:priceString];
    
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:completeString];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor orangeColor]
                             range:priceRange];

    cell.textLabel.attributedText = attributedString;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

@end






