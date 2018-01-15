//
//  MPKiipRouter.h
//  mopub-ios-sdk-swc
//
//  Created by Ilya Dyakonov on 1/15/18.
//

#import <Foundation/Foundation.h>
#import <KiipSDK/KiipSDK.h>

@protocol MPKiipRouterDelegate;

@interface MPKiipRouter : NSObject <KiipDelegate, KPPoptartDelegate>

+(instancetype) sharedInstance;

-(void) initializeSDK:(NSDictionary *) parameters;

-(void) showPoptart:(KPPoptart *) poptart
       withDelegate:(id<MPKiipRouterDelegate>) delegate;

-(void) invalidateDelegate:(id<MPKiipRouterDelegate>) delegate;

@end

@protocol MPKiipRouterDelegate <NSObject>

-(void) willPresentPoptart:(KPPoptart *) poptart;
-(void) didDismissPoptart:(KPPoptart *)poptart;

-(void) kiipAdShouldRewardUser;

@end
