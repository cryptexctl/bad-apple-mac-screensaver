//
//  Bad_AppleView.m
//  Bad Apple
//
//  Created by Lain on 23.01.2025.
//

#import "Bad_AppleView.h"
#import <ScreenSaver/ScreenSaver.h>
#import <AVFoundation/AVFoundation.h>

@interface Bad_AppleView ()
@property (strong) AVPlayer *player;
@property (strong) AVPlayerLayer *playerLayer;
@end

@implementation Bad_AppleView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1.0 / 30.0];
        
        // Enable CoreAnimation
        [self setWantsLayer:YES];
        
        // Searching for BadApple.mp4
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *videoURL = [bundle URLForResource:@"BadApple" withExtension:@"mp4"];
        
        if (videoURL) {
            self.player = [AVPlayer playerWithURL:videoURL];
            
            self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
            self.playerLayer.frame = self.bounds;
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            
            [self.layer addSublayer:self.playerLayer];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(playerItemDidReachEnd:)
                                                         name:AVPlayerItemDidPlayToEndTimeNotification
                                                       object:self.player.currentItem];
            

            [self.player play];
        }
    }
    return self;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}



@end
