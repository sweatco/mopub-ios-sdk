//
//  KPKiipInterstitialCustomEvent.h
//  MoPubSDK
//
//  Created by Kiip Inc.,  on 10/13/15.
//  Copyright © 2015 MoPub. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#else
    #import "MPInterstitialCustomEvent.h"
    #import "MoPub.h"
#endif


@interface KPKiipInterstitialCustomEvent : MPInterstitialCustomEvent

/**
 Initializes a Kiip object with the specified values.
 
 @param appKey The Application's key.
 @param appSecret The Application's secret.
 */
+ (void)setAppKey:(NSString *)appKey andSecret:(NSString *)appSecret;

@end
