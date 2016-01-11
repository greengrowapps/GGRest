//
//  GGViewController.m
//  GGRest
//
//  Created by Adri on 01/08/2016.
//  Copyright (c) 2016 Adri. All rights reserved.
//

#import "GGViewController.h"
#import <GGRest/GGWs.h>
#import "GGJsonHelper.h"

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
    
    GGWs *ws=[[GGWs alloc] init];
    ws.url=self.editUrl.text;
    ws.method=POST;
    
//    ws.onOk=^(NSString *s){
//        [self writeLine:s];
//    };
    
    ws.onOk=^(NSString *object){
        NSLog(@"object is: %@",object);
    };
    
    ws.onError=^(GGHttpResponse *fullResponse,NSError *error){
        [self.tvResponse setTextColor:[UIColor redColor]];
        [self writeLine:[fullResponse getContentString] ];
    };
    
    [ws execute];
}

-(void) writeLine:(NSString*) line{
   // dispatch_sync( dispatch_get_main_queue(), ^{
        self.tvResponse.text=[NSString stringWithFormat:@"%@ \n %@",self.tvResponse.text,line];
   // });
}

@end
