//
//  Game.h
//  ObjcTestApp
//
//  Created by masaki tatematsu on 2015/02/09.
//  Copyright (c) 2015年 Masaki Tatematsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

/**
 * 初期化メソッド
 * @return Game オブジェクト
 */
+ (id)game;

/**
 * 1投で倒したピンの数を記録する。
 * @param int count 1投で倒したピンの数
 * @return void
 */
- (void)count:(int)count;

/**
 * スコアの合計を返す。
 * @return int スコアの合計
 */
- (int)score;

@end
