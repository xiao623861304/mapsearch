#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SwpNetworking.h"
#import "SwpNetworkingTools.h"
#import "SwpNetworkingVariableType.h"

FOUNDATION_EXPORT double SwpNetworkingVersionNumber;
FOUNDATION_EXPORT const unsigned char SwpNetworkingVersionString[];

