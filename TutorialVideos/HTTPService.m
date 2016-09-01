//
//  HTTPService.m
//  TutorialVideos
//
//  Created by Marvin Andara on 8/24/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import "HTTPService.h"
#define URL_BASE "http://localhost:6069"
#define URL_TUTORIALS "/tutorials"
#define URL_COMMENTS "/comments"
#define URL_LOCATIONS "/locations"

@implementation HTTPService

+ (id) instance {
    
    static HTTPService *sharedInstance = nil;
    
    @synchronized (self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc]init];
    }
    
    return sharedInstance;
    
}

-(void) getComments: (nullable onComplete)completionHandler {
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_COMMENTS]];
    NSURLSession * session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            //error for parsing the data
            NSError *err;
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            
            if (err == nil) {
                
                completionHandler(json, nil);
                
            }
            else {
                
                completionHandler(nil, @"Data is corrupt. Please try again");
                
            }
            
        }else {
            
            NSLog(@"Network Error: %@", error.debugDescription);
            completionHandler(nil, @"Problem connecting to the server");
            
        }
        
    }]resume];
    
}

-(void) getTutorials:(nullable onComplete)completionHandler {
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_TUTORIALS]];
    NSURLSession * session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            //error for parsing the data
            NSError *err;
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            
            if (err == nil) {
                
                completionHandler(json, nil);
                
            }
            else {
                
                completionHandler(nil, @"Data is corrupt. Please try again");
                
            }
            
        }else {
            
            NSLog(@"Network Error: %@", error.debugDescription);
            completionHandler(nil, @"Problem connecting to the server");
            
        }
        
    }]resume];
    
}

-(void) postCommentWithId:(NSNumber *)commentId Comment:(NSString *)usercomment {
    
    if (commentId && usercomment) {
        
        
        NSDictionary *comment = @{@"id": commentId, @"commentBody": usercomment};
        
        NSError *error;
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_COMMENTS]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
        
        NSData *postData = [NSJSONSerialization dataWithJSONObject:comment options:0 error:&error];
        
        [request setHTTPBody:postData];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!error) {
                
                NSLog(@"Successfully posted");
                
            }
            else {
                
                NSLog(@"Error %@", error.debugDescription);
                
            }
            
          NSLog(@"Error %@", response);
            
        }];
        
        [postDataTask resume];
        
    }
}



@end
