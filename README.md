# GGRest

[![CI Status](http://img.shields.io/travis/greengrowapps/GGRest.svg?style=flat)](https://travis-ci.org/greengrowapps/GGRest)
[![codecov.io](https://codecov.io/github/greengrowapps/GGRest/coverage.svg?branch=master)](https://codecov.io/github/greengrowapps/GGRest?branch=master)
[![Version](https://img.shields.io/cocoapods/v/GGRest.svg?style=flat)](http://cocoapods.org/pods/GGRest)
[![License](https://img.shields.io/cocoapods/l/GGRest.svg?style=flat)](http://cocoapods.org/pods/GGRest)
[![Platform](https://img.shields.io/cocoapods/p/GGRest.svg?style=flat)](http://cocoapods.org/pods/GGRest)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Example

This example gets the content of the url using basic http auth and deserializes the content as an object:

```objective-c.

    GGWs *ws=[[GGWs alloc] init];
    ws.url=@"https://api.github.com/repos/greengrowapps/GGRest/commits";
    ws.method=GET;
    ws.authentication=[[GGHttpBasicAuth alloc] initWithUsername:@"YOUR_GITHUB_USER" andPassword:@"YOUR_GITHUB_PASSWD"];
    
    ws.onOkArray=^(NSArray *commitsList ,GGGitCommit *nill ){
        for(GGGitCommit *c in commitsList){
          NSLog(@"Commit: %@",c);
        }
    };
    
    ws.onError=^(GGHttpResponse *response,NSError *error){
         NSLog(@"Unknown error");
    };
    
    [ws onResponse:404 objectCallBack:^(GGHttpResponse *res){
        NSLog(@"Repo not found");
    }];
    
    [ws onResponse:401 objectCallBack:^(GGHttpResponse *res){
        NSLog(@"Invalid credentials");
    }];

    
    [ws execute];
```

## Installation

GGRest is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GGRest"
```

## License

GGRest is available under the  Apache License Version 2.0. See the LICENSE file for more info.
