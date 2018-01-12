//
//  KPKiipRewardedVideoCustomEvent.m
//  mopub-ios-sdk-swc
//
//  Created by Ilya Dyakonov on 12/27/17.
//

#import "KPKiipRewardedVideoCustomEvent.h"
#import "KPKiipInstanceMediationSettings.h"

#import <KiipSDK/KiipSDK.h>

@interface KPKiipRewardedVideoCustomEvent () <KiipDelegate, KPPoptartDelegate>

@property (nonatomic, strong) KPPoptart *poptart;

@end

@implementation KPKiipRewardedVideoCustomEvent

- (void)initializeSdkWithParameters:(NSDictionary *)parameters {
    [self initializeSDK:parameters];
}

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info {
    [self initializeSDK:info];
    
    KPKiipInstanceMediationSettings *mediationSettings = [self.delegate instanceMediationSettingsForClass:[KPKiipInstanceMediationSettings class]];
    if (mediationSettings != nil) {
        [[Kiip sharedInstance] setUserId:mediationSettings.userIdentifier];
    }
    
    if ([info objectForKey:@"testMode"]) {
        [[Kiip sharedInstance] setTestMode:[[info objectForKey:@"testMode"] boolValue]];
    }
    
    if ([info objectForKey:@"momentId"]) {
        [[Kiip sharedInstance] saveMoment:[info objectForKey:@"momentId"] withCompletionHandler:^(KPPoptart *poptart, NSError *error) {
            if (error) {
                [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
            } else if (poptart != nil) {
                self.poptart = poptart;
                [self.poptart setDelegate:self];
                [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
            } else {
                [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:nil];
            }
        }];
    }
}

-(void) initializeSDK:(NSDictionary *) parameters {
    if ([Kiip sharedInstance] == nil && parameters != nil) {
        if ([parameters objectForKey:@"appKey"] && [parameters objectForKey:@"appSecret"]) {
            [Kiip initWithAppKey:[parameters objectForKey:@"appKey"] andSecret:[parameters objectForKey:@"appSecret"]];
            [[Kiip sharedInstance] setDelegate:self];
        }
    }
}

- (BOOL)hasAdAvailable {
    return self.poptart != nil;
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    if (self.poptart != nil) {
        [self.poptart show];
    }
}

#pragma mark - KPPoptartDelegate methods

-(void)willPresentPoptart:(KPPoptart *)poptart {
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
}

-(void)didDismissPoptart:(KPPoptart *)poptart {
    [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
}

#pragma mark - KiipDelegate methods

- (void) kiip:(Kiip *)kiip
didReceiveContent:(NSString *)content
     quantity:(int)quantity
transactionId:(NSString *)transactionId
    signature:(NSString *)signature {
    self.poptart = nil;
    [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self
                                                        reward:[[MPRewardedVideoReward alloc] initWithCurrencyAmount:@(kMPRewardedVideoRewardCurrencyAmountUnspecified)]];
}

@end
