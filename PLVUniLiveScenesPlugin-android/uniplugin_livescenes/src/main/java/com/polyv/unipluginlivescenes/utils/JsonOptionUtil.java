package com.polyv.unipluginlivescenes.utils;

import androidx.annotation.NonNull;
import com.alibaba.fastjson.JSONObject;

/**
 * uniapp开发中
 * 代码中用到的JSONObject、JSONArray 要使用com.alibaba.fastjson.JSONArray;com.alibaba.fastjson.JSONObject;
 * 不要使用org.json.JSONObject;org.json.JSONArray 否则造成参数无法正常传递使用等问题。
 */
public class JsonOptionUtil {


    public static int getInt(@NonNull JSONObject data, String key, int defaultValue){
        Integer result = data.getInteger(key);
        if(result == null){
            return defaultValue;
        }
        return result;
    }

    public static long getLong(@NonNull JSONObject data, String key, long defaultValue){
        Long result = data.getLong(key);
        if(result == null){
            return defaultValue;
        }
        return result;
    }

    public static boolean getBoolean(@NonNull JSONObject data, String key, boolean defaultValue){
        Boolean result = data.getBoolean(key);
        if(result == null){
            return defaultValue;
        }
        return result;
    }

    public static float getFloat(@NonNull JSONObject data, String key, float defaultValue){
        Float result = data.getFloat(key);
        if(result == null){
            return defaultValue;
        }
        return result;
    }

    public static double getDouble(@NonNull JSONObject data, String key, double defaultValue){
        Double result = data.getDouble(key);
        if(result == null){
            return defaultValue;
        }
        return result;
    }

    public static String getString(@NonNull JSONObject data, String key, String defaultValue){
        String result = data.getString(key);
        if(result == null){
            return defaultValue;
        }
        return result;
    }

}
