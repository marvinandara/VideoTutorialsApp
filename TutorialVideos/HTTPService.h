//
//  HTTPService.h
//  TutorialVideos
//
//  Created by Marvin Andara on 8/24/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSArray *__nullable dataArray, NSString * __nullable errMessage);

@interface HTTPService : NSObject

+ (id) instance;

-(void) getTutorials:(nullable onComplete)completionHandler;

-(void) postCommentWithId: (NSNumber* __nullable)commentId Comment: (NSString * __nullable)usercomment;

-(void) getComments: (nullable onComplete)completionHandler;

@end
