//
//  GGCommitTableViewCell.m
//  GGRest
//
//  Created by piro on 18/1/16.
//  Copyright © 2016 Adri. All rights reserved.
//

#import "GGCommitTableViewCell.h"

@interface GGCommitTableViewCell(){
    
}
@property (weak, nonatomic) IBOutlet UILabel *edUser;
@property (weak, nonatomic) IBOutlet UILabel *edComment;
@property (weak, nonatomic) IBOutlet UILabel *edDate;

@end

@implementation GGCommitTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCommit:(GGGitCommit*) commit{
    self.edUser.text=commit.commiter.username;
    self.edComment.text=commit.commitItem.comment;
    self.edDate.text=commit.commitItem.author.date.description;
}

@end
