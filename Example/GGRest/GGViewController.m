//
//  GGViewController.m
//  GGRest
//
//  Created by Adri on 01/08/2016.
//  Copyright (c) 2016 Adri. All rights reserved.
//

#import "GGViewController.h"
#import <GGRest/GGSecureWebService.h>

@interface GGViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editUrl;
@property (weak, nonatomic) IBOutlet UITextView *tvResponse;

@end

@implementation GGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bExecuteClick:(id)sender {
    self.tvResponse.text=@"";
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        GGJsonResponse *res=[GGSecureWebService doGet:self.editUrl.text];
        
        [self writeLine:[NSString stringWithFormat:@"Respne code:%d",res.responseCode]];
        [self writeLine:@"Content:"];
        [self writeLine:res.content];
        
    });
}

-(void) writeLine:(NSString*) line{
    dispatch_sync( dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        self.tvResponse.text=[NSString stringWithFormat:@"%@ \n %@",self.tvResponse.text,line];
    });
}

@end
