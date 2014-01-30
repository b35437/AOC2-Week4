//
//  AddEventViewController.h
//  demoApp
//
//  Created by nathan byarley on 1/21/14.
//  Copyright (c) 2014 nathan byarley. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddEventDelegate <NSObject>

@required
- (void)passEvent:(NSString *)savedEventString;

@end

@interface AddEventViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIButton *closeKeyboard;
    IBOutlet UITextField *eventName;
    
    id<AddEventDelegate> myDelegate;
    
    NSString *dateTimeString;
    NSString *savedEventString;
    
    
    
}

-(IBAction)saveSwipe:(UISwipeGestureRecognizer *)sender;
-(IBAction)onClickCloseKeyboard:(id)sender;
-(IBAction)onClickCancel:(id)sender;
-(IBAction)onChangeDate:(UIDatePicker *)sender;


@property (strong, nonatomic) IBOutlet UIDatePicker *eventDateTime;

@property(strong) id<AddEventDelegate> myDelegate;
@end
