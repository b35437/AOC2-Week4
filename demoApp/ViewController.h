//
//  ViewController.h
//  demoApp
//
//  Created by nathan byarley on 1/21/14.
//  Copyright (c) 2014 nathan byarley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventViewController.h"

@interface ViewController : UIViewController<AddEventDelegate, UIActionSheetDelegate> {
    
    // Variables
    NSUserDefaults *defaults;
    NSString *eventListing;

    
}

// IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *savedLabel;
@property (strong, nonatomic) IBOutlet UITextView *events;


// IBAction
-(IBAction)buttonPressed:(UIButton *)sender;


@end
