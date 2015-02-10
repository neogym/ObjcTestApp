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
        self._frame = [[self class] createFrame];
    }
    return self;
}

+ (id)game {
    return [[super alloc] init];
}

- (void)count:(int)count {
    
    int frame_count = 1;
    struct Frame *frame_p = self._frame;
    while (frame_p->next != NULL) {
        frame_p = frame_p->next; // 1番最後に投げたフレームまで移動
        frame_count++;
    }
    
    struct Throw *current_throw = [[self class] createThow:count];
    if (frame_p->throw == NULL) { // まだ投げていない
        frame_p->throw = current_throw;
    } else { // 1投以上投げている。
        if (frame_p->throw->next == NULL) { // 1投だけ投げている
            if (frame_count < 10) {
                if (frame_p->throw->count == 10) { // 1投前にストライクを出している
                    frame_p->next = [[self class] createFrame:current_throw];
                } else { // 2投目
                    frame_p->throw->next = current_throw;
                }
            } else {
                frame_p->throw->next = current_throw;
            }
        } else { // 2投投げている。
            if (frame_count < 10) { // 1〜9フレーム目
                frame_p->next = [[self class] createFrame:current_throw];
            } else { // 10フレーム目
                frame_p->throw->next->next = current_throw;
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

+ (struct Frame*)createFrame {
    struct Frame *frame = malloc(sizeof(struct Frame));
    frame->throw = NULL;
    frame->next = NULL;
    return frame;
}
    
+ (struct Frame*)createFrame:(struct Throw*)throw {
    struct Frame *frame = [[self class] createFrame];
    frame->throw = throw;
    return frame;
}

/**
 * 1フレーム分のスコアを計算する。
 * @param struct Frame* フレーム
 * @return int スコア
 */
+ (int)frameScore:(struct Frame*)frame {
    int result = 0;
    struct Throw *throw_p = frame->throw;
    while (throw_p != NULL) {
        result += throw_p->count;
        throw_p = throw_p->next;
    }
    
    // ストライクまたはスペアの判定
    int bonus_count;
    struct Throw *t_p = frame->throw;
    if (frame->throw->count == 10) {
        // ストライクの場合、2投分ボーナス
        bonus_count = 2;
        t_p = t_p->next;
    } else if (frame->throw->count + frame->throw->next->count == 10) {
        // スペアの場合、1投分ボーナス
        bonus_count = 1;
        t_p = t_p->next->next;
    } else {
        bonus_count = 0;
        t_p = NULL;
    }
    
    // ボーナス得点の加算
    struct Frame *f_p = frame;
    while (bonus_count != 0 && f_p != NULL) {
        if (t_p == NULL) {
            f_p = f_p->next;
            if (f_p != NULL) {
                t_p = f_p->throw;
            }
        } else {
            result += t_p->count;
            bonus_count--;
            t_p = t_p->next;
        }
    }
    
    return result;
}

@end
