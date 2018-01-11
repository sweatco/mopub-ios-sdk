//
//  KPKiipRewardedVideoCustomEvent.h
//  mopub-ios-sdk-swc
//
//  Created by Ilya Dyakonov on 12/27/17.
//

#import <Foundation/Foundation.h>

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#else
    #import "MPMediationSettingsProtocol.h"
#endif

/*
 * `VungleInstanceMediationSettings` allows the application to provide per-instance properties
 * to configure aspects of Vungle ads. See `MPMediationSettingsProtocol` to see how mediation settings
 * are used.
 */
@interface KPKiipInstanceMediationSettings : NSObject <MPMediationSettingsProtocol>

/*
 * An NSString that's used as an identifier for a specific user, and is passed along to Vungle
 * when the rewarded video ad is played.
 */
@property (nonatomic, copy) NSString *userIdentifier;

@end
