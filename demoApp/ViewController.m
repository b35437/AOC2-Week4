//
//  ViewController.m
//  demoApp
//
//  Created by nathan byarley on 1/21/14.
//  Copyright (c) 2014 nathan byarley. All rights reserved.
//

#import "ViewController.h"
#import "AddEventViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)passEvent:(NSString *)savedEvent
{
    // Appends  a new event if the eventList already contains an event
    if (eventListing != nil)
    {
        eventListing = [eventListing stringByAppendingString:savedEvent];
    }
    // First event added to the list
    else
    {
        eventListing = [NSString stringWithFormat:@"%@",savedEvent];
    }
    _events.text = eventListing;
}

- (void)savedLabelAnimation
{
    //animation for the label when trying to save the events on the main view.
    [UIView animateWithDuration:0.6f delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                     animations:^{_savedLabel.frame = CGRectMake(200.0f, 70.0f, 320.0f, 44.0f);}
                     completion:^(BOOL finished){
                         if (_savedLabel.text.length == 16)
                         {
                             _savedLabel.text = @"Saved!";
                         }
                         [UIView animateWithDuration:0.6f delay:1.5f options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{_savedLabel.frame = CGRectMake(0.0f, 20.0f, 320.0f, 44.0f);}
                                          completion:^(BOOL finished){}
                          ];
                     }
     ];
}

- (void)viewDidLoad
{
    NSLog(@"%@",_events.text);
    // Cache original color of savedLabel background color and text color
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"SavedEventData"]) {
        _events.text = @"Add a New Event!";
    }
    else
    {
        // Load saved event data
        defaults = [NSUserDefaults standardUserDefaults];
        if (defaults != nil)
        {
            eventListing = [defaults objectForKey:@"SavedEventData"];
            
            //Enters saved data back to the view
            _events.text = eventListing;
        }
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//using segue allows me to use my delegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //making use of the identifier 
    if ([segue.identifier isEqualToString:@"Add Event"])
	{
        AddEventViewController *addEventView = segue.destinationViewController;
        addEventView.myDelegate = self;
	}
}


// combined the save and delete based on the tag.
- (IBAction)clearSaveBTN:(UIButton *)sender
{
    if (sender != nil)
    {
        if (sender.tag == 0)
        {
            if (_events.text.length == 16)
            {
                _savedLabel.text = @"No Events to Save";
                [self savedLabelAnimation];
            }
            else
            {
                // Run animation
                _savedLabel.text = @"Saving Events...";
                [self savedLabelAnimation];
                
                //Alloc userDefaults
                defaults = [NSUserDefaults standardUserDefaults];
                if (defaults != nil)
                {
                    [defaults setObject:eventListing forKey:@"SavedEventData"];
                    
                    // Saves the data
                    [defaults synchronize];
                }
            }
            
        }
        else if (sender.tag == 1)
        {
            //once the delete button is selected based on tag, activate the alertView.
            UIAlertView *deleteAlert = [[UIAlertView alloc]initWithTitle:@"Delete All" message:@"Are you sure you want to delete all saved events?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            
            [deleteAlert show];
        }
    }
}

//once alertView is accessed take ation based on choice selection
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        // Remove data written for SavedEventData
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SavedEventData"];
        
        _events.text = @"Add a New Event!";
    }
}


@end
