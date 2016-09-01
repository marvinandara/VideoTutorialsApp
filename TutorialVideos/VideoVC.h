//
//  VideoVC.h
//  TutorialVideos
//
//  Created by Marvin Andara on 8/25/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Video;

@interface VideoVC : UIViewController <UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) Video *video;

@end
