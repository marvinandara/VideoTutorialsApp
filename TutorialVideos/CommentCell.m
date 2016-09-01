//
//  CommentCell.m
//  TutorialVideos
//
//  Created by Marvin Andara on 8/26/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import "CommentCell.h"
#import "Video.h"
#import "Comment.h"

@interface CommentCell()

@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UILabel *commentLbl;

@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}

-(void) updateUI:(nonnull Comment *)comment {
    
    self.commentLbl.text = comment.comment;
    
}

@end
