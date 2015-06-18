# GGID iOS Sample Application
implement GGID login to your iOS application

Dependencies
============
You need CocoaPods to use this app. Run

    pod install
  
to install dependencies.

Opening In XCode
================
After running pod install above, Cocoa Pod will create _GGID Sample.xcworkspace_ file. This is the file you should open instead 
of the _GGID Sample.xcodeproj_

Configuring
===========
There are a couple things you need to configure before running this app:
* AppDelegate.m
** configure client id, client secret, auth URL, token URL, redirect URL to match your application (registered in GGID) settings
* BrowserViewController.m
** configure the _redirectURI_ variable to match your app redirect URI in webViewDidFinishLoad:
