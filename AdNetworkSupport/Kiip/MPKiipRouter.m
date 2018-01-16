//
//  MPKiipRouter.m
//  mopub-ios-sdk-swc
//
//  Created by Ilya Dyakonov on 1/15/18.
//

#import "MPKiipRouter.h"

#import <KiipSDK/KiipSDK.h>

@interface MPKiipRouter () <KiipDelegate, KPPoptartDelegate>

@property (nonatomic, weak) id<MPKiipRouterDelegate> delegate;

@end

@implementation MPKiipRouter

+(instancetype) sharedInstance {
    static MPKiipRouter *sharedRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRouter = [[MPKiipRouter alloc] init];
    });
    
    return sharedRouter;
}

-(void) initializeSDK:(NSDictionary *) parameters {
    if ([Kiip sharedInstance] == nil && parameters != nil) {
        if ([parameters objectForKey:@"appKey"] && [parameters objectForKey:@"appSecret"]) {
            [Kiip initWithAppKey:[parameters objectForKey:@"appKey"] andSecret:[parameters objectForKey:@"appSecret"]];
            [[Kiip sharedInstance] setDelegate:self];
        }
    }
}

-(void) showPoptart:(KPPoptart *) poptart
       withDelegate:(id<MPKiipRouterDelegate>) delegate {
    self.delegate = delegate;
    poptart.delegate = self;
    [poptart show];
}

-(void) invalidateDelegate:(id<MPKiipRouterDelegate>) delegate {
    if (self.delegate == delegate) {
        self.delegate = nil;
    }
}

#pragma mark - KPPoptartDelegate methods

-(void)willPresentPoptart:(KPPoptart *)poptart {
    [self.delegate willPresentPoptart:poptart];
}

-(void)didDismissPoptart:(KPPoptart *)poptart {
    [self.delegate didDismissPoptart:poptart];
}

#pragma mark - KiipDelegate methods

- (void) kiip:(Kiip *)kiip
didReceiveContent:(NSString *)content
     quantity:(int)quantity
transactionId:(NSString *)transactionId
    signature:(NSString *)signature {
    [self.delegate kiipAdShouldRewardUser];
}

@end
