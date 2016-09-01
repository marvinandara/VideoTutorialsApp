//
//  VideoVC.m
//  TutorialVideos
//
//  Created by Marvin Andara on 8/25/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

#import "VideoVC.h"
#import "Video.h"
#import "Comment.h"
#import "CommentCell.h"
#import "HTTPService.h"

@interface VideoVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSNumber *Id;
@property (nonatomic, strong) NSArray *commentList;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentTextView.delegate = self;
    self.webView.delegate = self;
    self.descTextView.editable = false;
    self.commentList = [[NSArray alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.titleLbl.text = self.video.videoTitle;
    self.descTextView.text = self.video.videoDescription;
    self.Id = self.video.videoId;
    self.commentButton.hidden = true;
    [self.webView loadHTMLString:self.video.videoIframe baseURL:nil];
    [self getData];
    
    UITapGestureRecognizer *hideKeyboard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissTheKeyboard:)];
    
    [self.view addGestureRecognizer:hideKeyboard];
    
}

-(void) dissmissTheKeyboard: (UITapGestureRecognizer *)recognizer {
    
    [self.view endEditing:YES];
    
}

-(void) getData {
    
    [[HTTPService instance]getComments:^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
        if(dataArray) {
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *d in dataArray) {
                
                Comment *comment = [[Comment alloc]init];
                
                if ([d objectForKey:@"id"] == _Id) {
                   
                    comment.comment = [d objectForKey:@"commentBody"];
                    comment.commentId = [d objectForKey:@"id"];
                    [arr addObject:comment];
                    
                }
                
            }
            
            self.commentList = arr;
            NSLog(@"%@",self.commentList.debugDescription);
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

-(void) textViewDidBeginEditing:(UITextView *)textView {
    
    _commentTextView.text = @"";
    _commentButton.hidden = false;
    
}

-(void) textViewDidEndEditing:(UITextView *)textView {
    
    self.commentButton.hidden = true;
    self.commentTextView.text = @"Whats on your mind?...";
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {

    NSString *css = @".container {position: relative; width: 100%; height: 0; padding-bottom: 56.25%} .video { position: absolute; top: 0; left: 0; width: 100%; height: 100%;}";

    NSString* js = [NSString stringWithFormat:
                    @"var styleNode = document.createElement('style');\n"
                    "styleNode.type = \"text/css\";\n"
                    "var styleText = document.createTextNode('%@');\n"
                    "styleNode.appendChild(styleText);\n"
                    "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
    NSLog(@"js:\n%@",js);
    [self.webView stringByEvaluatingJavaScriptFromString:js];
    
}

- (IBAction)donePressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)postPressed:(id)sender {
    
    if (![_commentTextView.text isEqual: @""]) {
        
      [[HTTPService instance]postCommentWithId:self.Id Comment:self.commentTextView.text];
        
        [self getData];
        [self.commentTextView endEditing:YES];
       
    }
    else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"EMPTY FIELDS" message:@"Field must be filled out" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:Ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Comment *comment = [self.commentList objectAtIndex:indexPath.row];
    CommentCell *commentCell = (CommentCell*)cell;
    [commentCell updateUI:comment];
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    if (!cell) {
        
        cell = [[CommentCell alloc]init];
        
    }
    
    return cell;
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.commentList.count;
    
}



@end







