//
//  ObjcTestAppTests.m
//  ObjcTestAppTests
//
//  Created by masaki tatematsu on 2015/02/06.
//  Copyright (c) 2015年 Masaki Tatematsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Game.h"

@interface ObjcTestAppTests : XCTestCase

@end

@implementation ObjcTestAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

/**
 * 全部ガター
 */
- (void)testAllGutter {
    Game *game = [Game game];
    for (int i = 0; i < 20; i++) {
        [game count:0];
    }
    // スコア:0点
    XCTAssertEqual(game.score, 0);
}

/**
 * 全部1本
 */
- (void)testAllOnePin {
    Game *game = [Game game];
    for (int i = 0; i < 20; i++) {
        [game count:1];
    }
    // スコア:0点
    XCTAssertEqual(game.score, 20);
}

/**
 * １投目ストライク、その後3、3、1本、残りガター
 */
- (void)testFirstBollisStrike {
    Game *game = [Game game];
    [game count:10];
    [game count:3];
    [game count:3];
    [game count:1];
    for (int i = 0; i < 15; i++) {
        [game count:0];
    }
    // スコア:23点
    XCTAssertEqual(game.score, 23);
}

/**
 * １、２投目ストライク(ダブル)、その後3、3、1本、残りガター
 */
- (void)testFirstAndSecondBollisStrike {
    Game *game = [Game game];
    [game count:10];
    [game count:10];
    [game count:3];
    [game count:3];
    [game count:1];
    for (int i = 0; i < 13; i++) {
        [game count:0];
    }
    // スコア:46点
    XCTAssertEqual(game.score, 46);
}

/**
 * １、２投目でスペア、その後3、3、1本、残りガター
 */
- (void)testFirstAndSecondBollisSpear {
    Game *game = [Game game];
    [game count:8];
    [game count:2];
    [game count:3];
    [game count:3];
    [game count:1];
    for (int i = 0; i < 15; i++) {
        [game count:0];
    }
    // スコア:20点
    XCTAssertEqual(game.score, 20);
}

/**
 * ターキー
 */
- (void)testTurkey {
    Game *game = [Game game];
    for (int i = 0; i < 3; i++) {
        [game count:10];
    }
    for (int i = 0; i < 7; i++) {
        [game count:0];
    }
    // スコア:60点
    XCTAssertEqual(game.score, 60);
}

/**
 * 3連続スペア
 */
- (void)testThreeTimesSpear {
    Game *game = [Game game];
    [game count:8];
    [game count:2];
    [game count:7];
    [game count:3];
    [game count:6];
    [game count:4];
    for (int i = 0; i < 7; i++) {
        [game count:0];
    }
    // スコア:43点
    XCTAssertEqual(game.score, 43);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
