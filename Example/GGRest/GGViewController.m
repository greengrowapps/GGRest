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
#import "GGGitCommit.h"
#import "GGCommitsViewController.h"

@interface GGViewController (){
    NSArray *commits;
}
@property (weak, nonatomic) IBOutlet UITextField *edUsername;
@property (weak, nonatomic) IBOutlet UITextField *edPassword;
@property (weak, nonatomic) IBOutlet UITextField *edRepo;
@property (weak, nonatomic) IBOutlet UIButton *bRead;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation GGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.activityIndicator.hidden=true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hideLoading];
    
}
- (IBAction)readClick:(id)sender {

    [self showLoading];
    
    GGWs *ws=[[GGWs alloc] init];
    ws.url=[NSString stringWithFormat:@"https://api.github.com/repos/%@/commits",self.edRepo.text];
    ws.method=GET;
    ws.authentication=[[GGHttpBasicAuth alloc] initWithUsername:self.edUsername.text andPassword:self.edPassword.text];
    
    ws.onOkArray=^(NSArray *commitsList ,GGGitCommit *nill ){
        commits=commitsList;
        [self performSegueWithIdentifier:@"showCommits" sender:self];
    };
    
    ws.onError=^(GGHttpResponse *response,NSError *error){
        [self hideLoading];
        [self showError:@"Unknown error"];
    };
    
    [ws onResponse:404 objectCallBack:^(GGHttpResponse *res){
        [self hideLoading];
        [self showError:@"Repo not found"];
    }];
    
    [ws onResponse:401 objectCallBack:^(GGHttpResponse *res){
        [self hideLoading];
        [self showError:@"invalid credentials"];
    }];

    
    [ws execute];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GGCommitsViewController *dest=segue.destinationViewController;
    dest.commits=commits;
}

-(void) showLoading{
    self.bRead.hidden=true;
    self.activityIndicator.hidden=false;
    [self.activityIndicator startAnimating];
}
-(void) hideLoading{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden=true;
    self.bRead.hidden=false;
}

-(void) showError:(NSString*) errorText{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                     message:errorText
                                                    delegate:nil
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles: nil];
    [alert show];
}




@end
