package com.polyv.unipluginlivescenes;

import android.app.Activity;
import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSONObject;
import com.easefun.polyv.livecloudclass.scenes.PLVLCCloudClassActivity;
import com.easefun.polyv.livecommon.module.config.PLVLiveChannelConfig;
import com.easefun.polyv.livecommon.module.config.PLVLiveChannelConfigFiller;
import com.easefun.polyv.livecommon.module.config.PLVLiveScene;
import com.easefun.polyv.livecommon.module.utils.result.PLVLaunchResult;
import com.easefun.polyv.liveecommerce.scenes.PLVECLiveEcommerceActivity;
import com.easefun.polyv.livescenes.feature.login.PolyvLiveLoginResult;
import com.easefun.polyv.livescenes.feature.login.PolyvPlaybackLoginResult;
import com.plv.foundationsdk.component.di.PLVDependManager;
import com.plv.foundationsdk.component.livedata.Event;
import com.plv.foundationsdk.log.PLVCommonLog;
import com.plv.foundationsdk.utils.PLVSugarUtil;
import com.plv.foundationsdk.utils.PLVUtils;
import com.plv.livescenes.config.PLVLiveChannelType;
import com.plv.livescenes.feature.login.IPLVSceneLoginManager;
import com.plv.livescenes.feature.login.PLVLiveLoginResult;
import com.plv.livescenes.feature.login.PLVPlaybackLoginResult;
import com.plv.livescenes.feature.login.PLVSceneLoginManager;
import com.plv.livescenes.playback.video.PLVPlaybackListType;
import com.plv.thirdpart.blankj.utilcode.util.ToastUtils;
import com.plv.livescenes.playback.video.PLVPlaybackListType;
import com.polyv.unipluginlivescenes.utils.JsonOptionUtil;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;
import com.taobao.weex.common.WXModule;

public class PolyvLiveScenesModule extends WXModule {

    private String TAG = "PolyvLiveScenesModule";

    //manager
    private final IPLVSceneLoginManager loginManager = new PLVSceneLoginManager();

    // <editor-fold defaultstate="collapsed" desc="多场景登录 sdk 接口">

    @JSMethod(uiThread = true)
    public void loginLiveRoom(int sceneType, JSONObject options, final JSCallback callback) {
        final PLVLiveScene curScene = getSceneType(sceneType);
        PLVLiveChannelConfig configFiller = PLVLiveChannelConfigFiller.generateNewChannelConfig();
        String appId = configFiller.getAccount().getAppId();
        String appSecret = configFiller.getAccount().getAppSecret();
        String userId = configFiller.getAccount().getUserId();
        final String viewerId = configFiller.getUser().getViewerId();
        final String nickName = configFiller.getUser().getViewerName();
        final String viewerAvatar = configFiller.getUser().getViewerAvatar();
        if (options == null) {
            objectCallback(false, "传入参数不能为空", callback);
            return;
        }

        final String channelId =  JsonOptionUtil.getString(options, "channelId", "").trim();
        if (TextUtils.isEmpty(channelId)) {
            objectCallback(false, "channelId 不能为空", callback);
            return;
        }

        final String liveParam4 =  JsonOptionUtil.getString(options, "liveParam4", "");
        final String liveParam5 =  JsonOptionUtil.getString(options, "liveParam5", "");
        loginManager.loginLiveNew(appId, appSecret, userId, channelId, new IPLVSceneLoginManager.OnLoginListener<PLVLiveLoginResult>() {
            @Override
            public void onLoginSuccess(PLVLiveLoginResult plvLiveLoginResult) {
                PLVLiveChannelType channelType = plvLiveLoginResult.getChannelTypeNew();
                switch (curScene) {
                    //进入云课堂场景
                    case CLOUDCLASS:
                        if (PLVLiveScene.isCloudClassSceneSupportType(channelType)) {
                            PLVLaunchResult launchResult = PLVLCCloudClassActivity.launchLive((Activity) mWXSDKInstance.getContext(), channelId, channelType, viewerId, nickName, viewerAvatar, liveParam4, liveParam5);
                            if (launchResult.isSuccess()) {
                                objectCallback(true, "登录成功", callback);
                            } else {
                                objectCallback(false, launchResult.getErrorMessage(), callback);
                            }
                        } else {
//                            String exceptionMsg = ((Activity) mWXSDKInstance.getContext())
//                                    .getString(R.string.plv_scene_login_toast_cloudclass_no_support_type);
                            objectCallback(false, "云课堂场景仅支持三分屏和纯视频频道类型", callback);
                        }
                        break;
                    //进入直播带货场景
                    case ECOMMERCE:
                        if (PLVLiveScene.isLiveEcommerceSceneSupportType(channelType)) {
                            PLVLaunchResult launchResult = PLVECLiveEcommerceActivity.launchLive((Activity) mWXSDKInstance.getContext(), channelId, viewerId, nickName, viewerAvatar, liveParam4, liveParam5);
                            if (launchResult.isSuccess()) {
                                objectCallback(true, "登录成功", callback);
                            } else {
                                objectCallback(false, launchResult.getErrorMessage(), callback);
                            }
                        } else {
                            objectCallback(false, "直播带货场景仅支持纯视频频道类型", callback);
                        }
                        break;
                    default:
                        objectCallback(false, "仅支持云课堂和带货直播场景", callback);
                        break;
                }
            }

            @Override
            public void onLoginFailed(String s, Throwable throwable) {
                objectCallback(false, throwable.getMessage(), callback);
            }
        });


    }

    @JSMethod(uiThread = true)
    public void loginPlaybackRoom(int sceneType, JSONObject options, final JSCallback callback) {
        final PLVLiveScene curScene = getSceneType(sceneType);
        PLVLiveChannelConfig configFiller = PLVLiveChannelConfigFiller.generateNewChannelConfig();
        String appId = configFiller.getAccount().getAppId();
        String appSecret = configFiller.getAccount().getAppSecret();
        String userId = configFiller.getAccount().getUserId();
        final String viewerId = configFiller.getUser().getViewerId();
        final String nickName = configFiller.getUser().getViewerName();
        final String viewerAvatar = configFiller.getUser().getViewerAvatar();
        if (options == null) {
            objectCallback(false, "传入参数不能为空", callback);
            return;
        }

        final String channelId =  JsonOptionUtil.getString(options, "channelId", "").trim();
        if (TextUtils.isEmpty(channelId)) {
            objectCallback(false, "channelId 不能为空", callback);
            return;
        }

        final String liveParam4 =  JsonOptionUtil.getString(options, "liveParam4", "");
        final String liveParam5 =  JsonOptionUtil.getString(options, "liveParam5", "");
        final String vid =  JsonOptionUtil.getString(options, "videoId", "").trim();
        final String vodType =  JsonOptionUtil.getString(options, "vodType", "0");
        loginManager.loginPlaybackNew(appId, appSecret, userId, channelId, vid, new IPLVSceneLoginManager.OnLoginListener<PLVPlaybackLoginResult>() {
            @Override
            public void onLoginSuccess(PLVPlaybackLoginResult plvPlaybackLoginResult) {
                PLVLiveChannelType channelType = plvPlaybackLoginResult.getChannelTypeNew();
                switch (curScene) {
                    //进入云课堂场景
                    case CLOUDCLASS:
                        if (PLVLiveScene.isCloudClassSceneSupportType(channelType)) {
                            PLVLaunchResult launchResult = PLVLCCloudClassActivity.launchPlayback((Activity) mWXSDKInstance.getContext(),
                                    channelId, channelType, vid, null, viewerId, nickName, viewerAvatar, liveParam4, liveParam5,
                                    vodType.equals("0") ? PLVPlaybackListType.PLAYBACK : PLVPlaybackListType.VOD
                            );
                            if (launchResult.isSuccess()) {
                                objectCallback(true, "登录成功", callback);
                            } else {
                                objectCallback(false, launchResult.getErrorMessage(), callback);
                            }
                        } else {
                            objectCallback(false, "云课堂场景仅支持三分屏和纯视频频道类型", callback);
                        }
                        break;
                    case ECOMMERCE:
                        if (PLVLiveScene.isLiveEcommerceSceneSupportType(channelType)) {
                            PLVLaunchResult launchResult = PLVECLiveEcommerceActivity.launchPlayback((Activity) mWXSDKInstance.getContext(),
                                    channelId, vid, viewerId, nickName, viewerAvatar, liveParam4, liveParam5,
                                    vodType.equals("0") ? PLVPlaybackListType.PLAYBACK : PLVPlaybackListType.VOD);
                            if (launchResult.isSuccess()) {
                                objectCallback(true, "登录成功", callback);
                            } else {
                                objectCallback(false, launchResult.getErrorMessage(), callback);
                            }
                        } else {
                            objectCallback(false, "直播带货场景仅支持纯视频频道类型", callback);
                        }
                        break;
                    default:
                        break;
                }
            }

            @Override
            public void onLoginFailed(String s, Throwable throwable) {
                objectCallback(false, throwable.getMessage(), callback);
            }
        });
    }

    // </editor-fold >

    // <editor-fold defaultstate="collapsed" desc="内部方法">

    /***
     * callback 数据整合
     * isSuccess 成功或者失败
     * errMsg 返回的消息提示
     */
    private void objectCallback(Boolean isSuccess, String errMsg, final JSCallback callback){
        if (callback == null) return;
        JSONObject result = new JSONObject();
        result.put("isSuccess", isSuccess);
        result.put("errMsg", errMsg);
        callback.invoke(result);
    }

    /**
     * 获取多场景类型
     * @param sceneType
     * 1 - 云课堂
     * 2 - 直播带货
     * @return 默认是云课堂场景
     */
    private PLVLiveScene getSceneType(int sceneType){
        String TAG = "PolyvLiveScenesModule";
        switch (sceneType){
            case 1:
                return PLVLiveScene.CLOUDCLASS;
            case 2:
                return PLVLiveScene.ECOMMERCE;
            default:
                Log.e(TAG, "非法场景sceneType："+sceneType+", 将默认使用云课堂场景");
                return PLVLiveScene.CLOUDCLASS;
        }
    }
    // </editor-fold >
}

