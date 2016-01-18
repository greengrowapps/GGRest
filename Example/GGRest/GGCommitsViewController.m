//
//  GGCommitsViewController.m
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGCommitsViewController.h"
#import "GGGitCommit.h"
#import "GGCommitTableViewCell.h"

@interface GGCommitsViewController () <UITableViewDataSource>


@end

@implementation GGCommitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commits.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GGGitCommit *commit=[self.commits objectAtIndex:indexPath.row];
    GGCommitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commitCell" forIndexPath:indexPath];
    [cell setCommit:commit];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
