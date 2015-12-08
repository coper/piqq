//
//  AskUnExecptionHandler.h
//  patientv1.0
//
//  Created by liyongli on 15/7/15.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AskUnExecptionHandler : NSObject{
      BOOL dismissed;
}

@end

void AskHandleException(NSException *exception);
void AskSignalHandler(int signal);


void AskInstallUncaughtExceptionHandler(void);
