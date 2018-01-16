//
//  MPKiipRouter.h
//  mopub-ios-sdk-swc
//
//  Created by Ilya Dyakonov on 1/15/18.
//

#import <Foundation/Foundation.h>

@protocol MPKiipRouterDelegate;
@class KPPoptart;

@interface MPKiipRouter : NSObject

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
