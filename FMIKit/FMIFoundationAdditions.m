//
//  FMFoundationAdditions.m
//
//  Created by Florian Mielke on 30.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIFoundationAdditions.h"

NSString *NSStringFromIvarInObj(id ivar, id obj) {
    unsigned int numIvars = 0;
    NSString *key = nil;

    Ivar *ivars = class_copyIvarList([obj class], &numIvars);

    for (unsigned int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];

        if ((object_getIvar(obj, thisIvar) == ivar)) {
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
    }

    free(ivars);

    return key;
}