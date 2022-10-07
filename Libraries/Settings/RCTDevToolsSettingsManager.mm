/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <React/RCTDevToolsSettingsManager.h>

#import <FBReactNativeSpec/FBReactNativeSpec.h>
#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcherProtocol.h>
#import <React/RCTUtils.h>

#import "RCTDevToolsSettingsPlugins.h"

@interface RCTDevToolsSettingsManager() <NativeDevToolsSettingsManagerSpec>
@end

@implementation RCTDevToolsSettingsManager
{
  NSUserDefaults *_defaults;
}

RCT_EXPORT_MODULE(DevToolsSettingsManager)

- (instancetype)init
{
  return [self initWithUserDefaults:[NSUserDefaults standardUserDefaults]];
}

- (instancetype)initWithUserDefaults:(NSUserDefaults *)defaults
{
  if ((self = [super init])) {
    _defaults = defaults;
  }
  return self;
}

RCT_EXPORT_METHOD(setConsolePatchSettings:(NSString *)newConsolePatchSettings)
{
  [self->_defaults setObject:newConsolePatchSettings forKey:@"ReactDevTools::ConsolePatchSettings"];
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getConsolePatchSettings)
{
  return [self->_defaults stringForKey:@"ReactDevTools::ConsolePatchSettings"];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeDevToolsSettingsManagerSpecJSI>(params);
}

@end

Class RCTDevToolsSettingsManagerCls(void)
{
  return RCTDevToolsSettingsManager.class;
}
