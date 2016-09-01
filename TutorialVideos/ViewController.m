//
//  ViewController.m
//  TutorialVideos
//
//  Created by Marvin Andara on 8/24/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import "ViewController.h"
#import "HTTPService.h"
#import "Video.h"
#import "VideoCell.h"
#import "VideoVC.h"
#import "TutorialVideos-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (nonatomic, strong) AboutUsVC * aboutusVC;

@property (nonatomic, strong) NSArray *videoList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.videoList = [[NSArray alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getData];
    
}


-(void) getData {
    
    [[HTTPService instance]getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
        if(dataArray) {
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *d in dataArray) {
                
                Video *vid = [[Video alloc]init];
                vid.videoTitle = [d objectForKey:@"title"];
                vid.videoDescription = [d objectForKey:@"description"];
                vid.videoIframe = [d objectForKey:@"iframe"];
                vid.thumbnailUrl = [d objectForKey:@"thumbnail"];
                vid.videoId = [d objectForKey:@"id"];
                
                [arr addObject:vid];
                
            }
            
            self.videoList = arr;
            NSLog(@"%@", self.videoList.debugDescription);
            [self updateTableData];
            
        }
        else if (errMessage){
            
            //Display alert to user
            
        }
    }];
    
}

-(void) updateTableData {
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        [self.tableView reloadData];
        
    });
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    VideoCell *vidCell = (VideoCell*)cell;
    [vidCell updateUI:video];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqual: @"videoVC"]) {
        
        VideoVC *vc = (VideoVC*)segue.destinationViewController;
        
        Video *video = (Video*)sender;
        
        vc.video = video;
        
    }
    
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"videoVC" sender:video];
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCell *cell = (VideoCell*)[tableView dequeueReusableCellWithIdentifier:@"main"];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        
        cell = [[VideoCell alloc]init];
        
    }
    
    return cell;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.videoList.count;
    
}

- (IBAction)aboutButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"AboutUsVC" sender:self];
    
}

@end



