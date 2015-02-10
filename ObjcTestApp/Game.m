//
//  Game.m
//  ObjcTestApp
//
//  Created by masaki tatematsu on 2015/02/09.
//  Copyright (c) 2015年 Masaki Tatematsu. All rights reserved.
//

#import "Game.h"

@interface Game ()

struct Throw {
    int count;
    struct Throw *next;
};

struct Frame {
    struct Throw *throw;
    struct Frame *next;
};

@property struct Frame *_frame;

@end

@implementation Game

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._frame = NULL;
    }
    return self;
}

+ (id)game {
    return [[super alloc] init];
}

- (void)count:(int)count {
    struct Throw *current_throw = [[self class] createThow:count];
    
    if (self._frame == NULL) { // 最初の1投目のみ実行
        self._frame = [[self class] createFrame:current_throw];
    } else {
        int frame_count = 1;
        struct Frame *p = self._frame;
        while (p->next != NULL) {
            p = p->next; // 1番最後に投げたフレームまで移動
            frame_count++;
        }
        
        if (p->throw == NULL) { // まだ投げていない
            p->throw = current_throw;
        } else { // 1投以上投げている。
            if (p->throw->next == NULL) { // 1投だけ投げている
                if (p->throw->count == 10) { // 1投前にストライクを出している
                    p->next = [[self class] createFrame:current_throw];
                } else { // 2投目
                    p->throw->next = current_throw;
                }
            } else { // 2投投げている。
                if (frame_count < 10) { // 1〜9フレーム目
                    p->next = [[self class] createFrame:current_throw];
                } else { // 10フレーム目
                    p->throw->next->next = current_throw;
                }
            }
        }
    }
}

- (int)score {
    int result = 0;
    struct Frame *p = self._frame;
    while (p != NULL) {
        result += [[self class] frameScore:p];
        p = p->next;
    }
    return result;
}

# pragma mark - util

+ (struct Throw*)createThow:(int)count {
    struct Throw *throw = malloc(sizeof(struct Throw));
    throw->count = count;
    throw->next = NULL;
    return throw;
}

+ (struct Frame*)createFrame:(struct Throw*)throw {
    struct Frame *frame = malloc(sizeof(struct Frame));
    frame->throw = throw;
    frame->next = NULL;
    return frame;
}

/**
 * 1フレーム分のスコアを計算する。
 * @param struct Frame* フレーム
 * @return int スコア
 */
+ (int)frameScore:(struct Frame*)frame {
    int result = 0;
    struct Throw *p = frame->throw;
    while (p != NULL) {
        result += p->count;
        p = p->next;
    }
    
    // ボーナス加算
    struct Frame *nextFrame = frame->next;
    if (frame->throw->count == 10) { // ストライクの場合
        // 次の2投分を加算(ボーナス)
        if (nextFrame->throw->count == 10) { // ダブルまたはターキーの場合
            result += nextFrame->throw->count;
            result += nextFrame->next->throw->count;
        } else {
            result += [[self class] frameScore:nextFrame];
        }
    } else if (result == 10) { // スペアの場合
        // 次の1投分を加算(ボーナス)
        result += nextFrame->throw->count;
    }
    
    return result;
}

@end
