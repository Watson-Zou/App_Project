//
//  MFSportSpeaker.m
//  MFSport
//
//  Created by 彭作青 on 2016/11/16.
//  Copyright © 2016年 彭作青. All rights reserved.
//

#import "MFSportSpeaker.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@implementation MFSportSpeaker {
    /// 运动类型字符串
    NSString *_typeStr;
    /// 上次播报的距离
    double _lastReportDistance;
    /// 播报的间距
    double _unitDistance;
    AVPlayer *_player;
    NSDictionary *_voiceDict;
}

- (instancetype)init {
    if (self = [super init]) {
        _unitDistance = 0.5;
        _lastReportDistance = 0;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"voice.json" withExtension:nil subdirectory:@"voice.bundle"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        _voiceDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        _player = [AVPlayer new];
    }
    return self;
}

- (void)startSportType:(MFSportType)type {
    NSString *text = @"开始";
    switch (type) {
        case MFSportTypeWalk:
            text = [text stringByAppendingString:@"走路"];
            _typeStr = @"走路";
            break;
        case MFSportTypeRun:
            text = [text stringByAppendingString:@"跑步"];
            _typeStr = @"跑步";
            break;
        case MFSportTypeBike:
            text = [text stringByAppendingString:@"骑行"];
            _typeStr = @"骑行";
            break;
    }
    [self playVoiceWithText:text];
}

- (void)sportStateChanged:(MFSportState)state {
    NSString *text;
    switch (state) {
        case MFSportStateContinue:
            text = @"运动已恢复";
            break;
        case MFSportStatePause:
            text = @"运动已暂停";
            break;
        case MFSportStateEnd:
            text = @"放松一下吧";
            break;
    }
    [self playVoiceWithText:text];
}

- (void)reportWithDistance:(double)distance time:(NSTimeInterval)time speed:(double)avgSpeed {
    
    if (distance < _lastReportDistance + _unitDistance) {
        return;
    }
    
    _lastReportDistance = (NSInteger)(distance / _unitDistance) * _unitDistance;
    
    NSString *text = [NSString stringWithFormat:@"你已经 %@ 距离 %0.2f 公里 时间 %0.2f 速度 %0.2f 公里 每小时", _typeStr, distance, time, avgSpeed];
    [self playVoiceWithText:text];
}

- (void)playVoiceWithText:(NSString *)text {
    NSLog(@"%@", text);
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:_voiceDict[text] withExtension:nil subdirectory:@"voice.bundle"];
    if (url == nil) {
        NSLog(@"没有找到文件");
        return;
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:item];
    [_player play];
    
//    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
//    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
//    utterance.voice = voice;
//    [_speechSynthesizer speakUtterance:utterance];
}

@end
