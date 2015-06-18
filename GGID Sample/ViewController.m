//
//  ViewController.m
//  GGID Sample
//
//  Created by Aditya Wirayudha on 18/06/15.
//  Copyright (c) 2015 Erasys Consulting. All rights reserved.
//

#import "ViewController.h"
#import "NXOAuth2.h"
#import "BrowserViewController.h"

@interface ViewController () <BrowserViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@end

@implementation ViewController
- (void)browserViewControllerDidSuccessAuthenticate:(BrowserViewController *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    for (NXOAuth2Account *account in [[NXOAuth2AccountStore sharedStore] accounts]) {
        [self fetchAndDisplayAccount:account];
    }
    
    [self.logoutButton setEnabled:YES];
}

- (IBAction)logout:(UIButton *)sender {
    for (NXOAuth2Account *account in [[NXOAuth2AccountStore sharedStore] accounts]) {
        [[NXOAuth2AccountStore sharedStore]  removeAccount:account];
    }
    [self.resultTextView setText:@"result of /api/users/me/ will be displayed here if you sucessfully logged in"];
    [self.loginButton setEnabled:YES];
    [self.logoutButton setEnabled:NO];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BrowserViewController *destination = (BrowserViewController *)segue.destinationViewController;
    
    destination.delegate = self;
}

- (void) fetchAndDisplayAccount: (NXOAuth2Account *)account {
    [self.loginButton setEnabled:NO];
    [self.logoutButton setEnabled:YES];
    
    [NXOAuth2Request performMethod:@"GET"
                        onResource:[NSURL URLWithString:@"https://gg-id.net/api/users/me/"]
                   usingParameters:nil withAccount:account
               sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal) {
                   
               }
                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                       NSLog(@"status code : %ld", (long)httpResponse.statusCode);
                       NSString *stringResponse = [NSString stringWithUTF8String:[responseData bytes]];
                       NSLog(@"response : %@", stringResponse);
                       
//                       NSError *error1;
//                       NSMutableDictionary * innerJson = [NSJSONSerialization
//                                                          JSONObjectWithData:responseData options:kNilOptions error:&error1
//                                                          ];
                       self.resultTextView.text = stringResponse;
                       
                   }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NXOAuth2Account *account in [[NXOAuth2AccountStore sharedStore] accounts]) {
        [self fetchAndDisplayAccount:account];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
