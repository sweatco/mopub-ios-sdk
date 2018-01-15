//
//  KPKiipRewardedVideoCustomEvent.m
//  mopub-ios-sdk-swc
//
//  Created by Ilya Dyakonov on 12/27/17.
//

#import "KPKiipRewardedVideoCustomEvent.h"
#import "KPKiipInstanceMediationSettings.h"
#import "MPKiipRouter.h"

#import <KiipSDK/KiipSDK.h>

@interface KPKiipRewardedVideoCustomEvent ()  <MPKiipRouterDelegate>

@property (nonatomic, strong) KPPoptart *poptart;

@end

@implementation KPKiipRewardedVideoCustomEvent

- (void)initializeSdkWithParameters:(NSDictionary *)parameters {
    [[MPKiipRouter sharedInstance] initializeSDK:parameters];
}

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info {
    [[MPKiipRouter sharedInstance] initializeSDK:info];
    
    KPKiipInstanceMediationSettings *mediationSettings = [self.delegate instanceMediationSettingsForClass:[KPKiipInstanceMediationSettings class]];
    if (mediationSettings != nil) {
        [[Kiip sharedInstance] setUserId:mediationSettings.userIdentifier];
    }
    
    if ([info objectForKey:@"testMode"]) {
        [[Kiip sharedInstance] setTestMode:[[info objectForKey:@"testMode"] boolValue]];
    }
    
    if ([info objectForKey:@"momentId"]) {
        [[Kiip sharedInstance] saveMoment:[info objectForKey:@"momentId"]
                                    value:1.0
                    withCompletionHandler:^(KPPoptart *poptart, NSError *error) {
            if (error) {
                [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
            } else if (poptart != nil) {
                self.poptart = poptart;
                [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
            } else {
                [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:nil];
            }
        }];
    }
}

- (BOOL)hasAdAvailable {
    return self.poptart != nil;
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    if (self.poptart != nil) {
        [[MPKiipRouter sharedInstance] showPoptart:self.poptart
                                      withDelegate:self];
    }
}

- (void)handleCustomEventInvalidated {
    [[MPKiipRouter sharedInstance] invalidateDelegate:self];
}

#pragma mark - MPKiipRouterDelegate methods

-(void) willPresentPoptart:(KPPoptart *) poptart {
    if (self.poptart == poptart) {
        [self.delegate rewardedVideoWillAppearForCustomEvent:self];
        [self.delegate rewardedVideoDidAppearForCustomEvent:self];
    }
}

-(void) didDismissPoptart:(KPPoptart *)poptart {
    if (self.poptart == poptart) {
        [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
        [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
        self.poptart = nil;
    }
}

-(void) kiipAdShouldRewardUser {
    [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self
                                                        reward:[[MPRewardedVideoReward alloc] initWithCurrencyAmount:@(kMPRewardedVideoRewardCurrencyAmountUnspecified)]];
}

@end
