//
//  KPKiipInterstitialCustomEvent.m
//  MoPubSDK
//
//  Created by Kiip Inc., on 10/13/15.
//  Copyright © 2015 MoPub. All rights reserved.
//

#import "KPKiipInterstitialCustomEvent.h"
#import <KiipSDK/KiipSDK.h>

@interface KPKiipInterstitialCustomEvent () <KiipDelegate, KPPoptartDelegate>

@property (nonatomic, strong) KPPoptart *sPoptart;

@end

@implementation KPKiipInterstitialCustomEvent

static KPKiipInterstitialCustomEvent *sInstance = nil;

+ (KPKiipInterstitialCustomEvent *)sharedInstance
{
    @synchronized(self) {
        if (sInstance == nil) {
            sInstance = [[self alloc] init];
        }
    }
    return sInstance;
}

+ (void)setAppKey:(NSString *)appKey andSecret:(NSString *)appSecret
{
    [Kiip initWithAppKey:appKey andSecret:appSecret];
    [[Kiip sharedInstance] setDelegate:[KPKiipInterstitialCustomEvent sharedInstance]];
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    if ([Kiip sharedInstance] == nil && info != nil) {
        if ([info objectForKey:@"appKey"] && [info objectForKey:@"appSecret"]) {
            [Kiip initWithAppKey:[info objectForKey:@"appKey"] andSecret:[info objectForKey:@"appSecret"]];
            [[Kiip sharedInstance] setDelegate:self];
        }
    }
    if ([Kiip sharedInstance] && info != nil) {
        
        if ([info objectForKey:@"email"]) {
            [[Kiip sharedInstance] setEmail:[info objectForKey:@"email"]];
        }
        
        if ([info objectForKey:@"userId"]) {
            [[Kiip sharedInstance] setUserId:[info objectForKey:@"userId"]];
        }
        
        if ([info objectForKey:@"gender"]) {
            [[Kiip sharedInstance] setGender:[info objectForKey:@"gender"]];
        }
        
        if ([info objectForKey:@"birthday"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSDate *birthDate = [dateFormatter dateFromString:[info objectForKey:@"birthday"]];
            [[Kiip sharedInstance] setBirthday:birthDate];
        }
        
        if ([info objectForKey:@"testMode"]) {
            [[Kiip sharedInstance] setTestMode:[[info objectForKey:@"testMode"] boolValue]];
        }
        
        if ([info objectForKey:@"momentId"]) {
            [[Kiip sharedInstance] saveMoment:[info objectForKey:@"momentId"] withCompletionHandler:^(KPPoptart *poptart, NSError *error) {
                if (error) {
                    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
                } else if (poptart != nil) {
                    self.sPoptart = poptart;
                    [self.sPoptart setDelegate:self];
                    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
                } else {
                    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
                }
            }];
        }
    }
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    if (self.sPoptart) {
        [self.sPoptart show];
        self.sPoptart = nil;
    }
}

- (void) willPresentPoptart:(KPPoptart *)poptart
{
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void) didDismissPoptart:(KPPoptart *)poptart
{
    [self.delegate interstitialCustomEventWillDisappear:self];
    [self.delegate interstitialCustomEventDidDisappear:self];
}

@end
