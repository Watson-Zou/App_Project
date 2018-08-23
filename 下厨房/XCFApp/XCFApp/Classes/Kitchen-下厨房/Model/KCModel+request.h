//
//  KCModel+request.h
//  XCFApp
//
//  Created by rkxt_ios on 15/12/8.
//  Copyright © 2015年 ST. All rights reserved.
//

#import "KCModel.h"

@interface KCModel (request)
+ (void)requestWithCompletionBlock:(CompletionBlock)successBlock
                      failureBlock:(FailureBlock)failureBlock;
@end
