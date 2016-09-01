//
//  Video.h
//  TutorialVideos
//
//  Created by Marvin Andara on 8/25/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *videoIframe;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic) NSNumber *videoId;

@end
