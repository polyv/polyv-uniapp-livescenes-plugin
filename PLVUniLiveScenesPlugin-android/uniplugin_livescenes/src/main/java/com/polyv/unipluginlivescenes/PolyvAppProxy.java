package com.polyv.unipluginlivescenes;

import android.app.Application;

import com.easefun.polyv.livecommon.module.config.PLVLiveSDKConfig;

import io.dcloud.weex.AppHookProxy;

public class PolyvAppProxy implements AppHookProxy {
    String TAG = "PolyvAppProxy";

    @Override
    public void onCreate(Application application) {
        PLVLiveSDKConfig.init(
                new PLVLiveSDKConfig.Parameter(application)
                        .isOpenDebugLog(true)
                        .isEnableHttpDns(false)
        );
    }
}
