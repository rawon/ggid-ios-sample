//
//  BrowserViewController.m
//  GGID Sample
//
//  Created by Aditya Wirayudha on 18/06/15.
//  Copyright (c) 2015 Erasys Consulting. All rights reserved.
//

#import "BrowserViewController.h"
#import "NXOAuth2.h"

@interface BrowserViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreAccountsDidChangeNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      [self.delegate browserViewControllerDidSuccessAuthenticate:self];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreDidFailToRequestAccessNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      NSError *error = [aNotification.userInfo objectForKey:NXOAuth2AccountStoreErrorKey];
                                                      NSLog(@"Error : %@", error.localizedDescription);
                                                      
                                                      [self.delegate browserViewControllerDidSuccessAuthenticate:self];
                                                  }];
    
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"ggidService"
                                   withPreparedAuthorizationURLHandler:^(NSURL *preparedURL){
                                       [_webView loadRequest:[NSURLRequest requestWithURL:preparedURL]];
                                   }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //this is the URI where GGID will redirect the user after authentication
    //redirect URI can actually be anything as long as it is registered in your GGID application
    NSString *redirectURI = @"http://localhost/";
    if ([webView.request.URL.absoluteString rangeOfString:redirectURI options:NSCaseInsensitiveSearch].location != NSNotFound) {
        [[NXOAuth2AccountStore sharedStore] handleRedirectURL:[NSURL URLWithString:webView.request.URL.absoluteString]];
    }
}


@end
