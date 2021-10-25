package com.polyv.unipluginlivescenes;

import android.text.TextUtils;

import com.alibaba.fastjson.JSONObject;
import com.easefun.polyv.livecommon.module.config.PLVLiveChannelConfigFiller;
import com.easefun.polyv.livecommon.module.modules.marquee.PLVMarqueeCommonController;
import com.polyv.unipluginlivescenes.utils.JsonOptionUtil;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;
import com.taobao.weex.common.WXModule;

public class PolyvConfigModule extends WXModule {

    @JSMethod(uiThread = true)
    public void setConfig(JSONObject options, final JSCallback callback) {

        if (options == null) {
            if (callback != null) {
                JSONObject err = new JSONObject();
                err.put("isSuccess", false);
                err.put("errMsg", "传入参数不能为空");
                callback.invoke(err);
            }
            return;
        }
        //设置config
        String appId = JsonOptionUtil.getString(options, "appId", "");
        String secret = JsonOptionUtil.getString(options, "appSecret", "");
        String userId = JsonOptionUtil.getString(options, "userId", "");

        if (TextUtils.isEmpty(appId)) {
            if (callback != null) {
                JSONObject err = new JSONObject();
                err.put("isSuccess", false);
                err.put("errMsg", "appId 不能为空");
                callback.invoke(err);
            }
            return;
        }

        if (TextUtils.isEmpty(secret)) {
            if (callback != null) {
                JSONObject err = new JSONObject();
                err.put("isSuccess", false);
                err.put("errMsg", "appSecret 不能为空");
                callback.invoke(err);
            }
            return;
        }

        if (TextUtils.isEmpty(userId)) {
            if (callback != null) {
                JSONObject err = new JSONObject();
                err.put("isSuccess", false);
                err.put("errMsg", "userId 不能为空");
                callback.invoke(err);
            }
            return;
        }
        PLVLiveChannelConfigFiller.setupAccount(userId, appId, secret);

        if (callback != null) {
            JSONObject err = new JSONObject();
            err.put("isSuccess", true);
            err.put("errMsg", "配置成功");
            callback.invoke(err);
        }
    }

    @JSMethod(uiThread = true)
    public void setViewerInfo(JSONObject options, final JSCallback callback) {
        if (options == null) {
            if (callback != null) {
                JSONObject err = new JSONObject();
                err.put("isSuccess", false);
                err.put("errMsg", "传入参数不能为空");
                callback.invoke(err);
            }
            return;
        }

        //设置直播间用户信息
        String viewerId = JsonOptionUtil.getString(options, "viewerId", "");
        String viewerName = JsonOptionUtil.getString(options, "viewerName", "");
        String viewerAvatar = JsonOptionUtil.getString(options, "viewerAvatar", "");
        PLVLiveChannelConfigFiller.setupUser(viewerId, viewerName, viewerAvatar);

        if (callback != null) {
            JSONObject err = new JSONObject();
            err.put("isSuccess", true);
            err.put("errMsg", "配置成功");
            callback.invoke(err);
        }
    }

    @JSMethod(uiThread = true)
    public void setMarqueeConfig(JSONObject options, final JSCallback callback) {
        if (options == null) {
            if (callback != null) {
                JSONObject err = new JSONObject();
                err.put("isSuccess", false);
                err.put("errMsg", "传入参数不能为空");
                callback.invoke(err);
            }
            return;
        }

        //设置跑马灯code
        String code = JsonOptionUtil.getString(options, "code", "");
        PLVMarqueeCommonController.getInstance().setCode(code);

        if (callback != null) {
            JSONObject err = new JSONObject();
            err.put("isSuccess", true);
            err.put("errMsg", "配置成功");
            callback.invoke(err);
        }
    }
}
