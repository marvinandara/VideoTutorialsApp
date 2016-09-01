//
//  CommentCell.h
//  TutorialVideos
//
//  Created by Marvin Andara on 8/26/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comment;

@interface CommentCell : UITableViewCell

-(void) updateUI:(nonnull Comment *)comment;

@end
