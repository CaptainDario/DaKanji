package com.pichillilorenzo.flutter_appavailability;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * AppAvailability
 */
public class AppAvailability implements FlutterPlugin, MethodCallHandler {

    private Context applicationContext;
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "com.pichillilorenzo/flutter_appavailability");
        channel.setMethodCallHandler(this);
        applicationContext = binding.getApplicationContext();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }


    @Override
    public void onMethodCall(MethodCall call, Result result) {
        String uriSchema;
        switch (call.method) {
            case "checkAvailability":
                uriSchema = call.argument("uri").toString();
                this.checkAvailability(uriSchema, result);
                break;
            case "getInstalledApps":
                result.success(getInstalledApps());
                break;
            case "isAppEnabled":
                uriSchema = call.argument("uri").toString();
                this.isAppEnabled(uriSchema, result);
                break;
            case "launchApp":
                uriSchema = call.argument("uri").toString();
                this.launchApp(uriSchema, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void checkAvailability(String uri, Result result) {
        PackageInfo info = getAppPackageInfo(uri);

        if (info != null) {
            result.success(this.convertPackageInfoToJson(info));
            return;
        }
        result.error("", "App not found " + uri, null);
    }

    private List<Map<String, Object>> getInstalledApps() {
        PackageManager packageManager = applicationContext.getPackageManager();
        List<PackageInfo> apps = packageManager.getInstalledPackages(0);
        List<Map<String, Object>> installedApps = new ArrayList<>(apps.size());
        int systemAppMask = ApplicationInfo.FLAG_SYSTEM | ApplicationInfo.FLAG_UPDATED_SYSTEM_APP;

        for (PackageInfo pInfo : apps) {
            if ((pInfo.applicationInfo.flags & systemAppMask) != 0) {
                continue;
            }

            Map<String, Object> map = this.convertPackageInfoToJson(pInfo);
            installedApps.add(map);
        }

        return installedApps;
    }

    private PackageInfo getAppPackageInfo(String uri) {
        final PackageManager pm = applicationContext.getPackageManager();

        try {
            return pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES);
        } catch (PackageManager.NameNotFoundException e) {

        }

        return null;
    }

    private Map<String, Object> convertPackageInfoToJson(PackageInfo info) {
        Map<String, Object> map = new HashMap<>();
        map.put("app_name", info.applicationInfo.loadLabel(applicationContext.getPackageManager()).toString());
        map.put("package_name", info.packageName);
        map.put("version_code", String.valueOf(info.versionCode));
        map.put("version_name", info.versionName);
        return map;
    }

    private void isAppEnabled(String packageName, Result result) {
        boolean appStatus = false;
        try {
            ApplicationInfo ai = applicationContext.getPackageManager().getApplicationInfo(packageName, 0);
            if (ai != null) {
                appStatus = ai.enabled;
            }
        } catch (PackageManager.NameNotFoundException e) {
            result.error("", e.getMessage() + " " + packageName, e);
            return;
        }
        result.success(appStatus);
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    private void launchApp(String packageName, Result result) {
        PackageInfo info = getAppPackageInfo(packageName);

        if (info != null) {
            Intent launchIntent = applicationContext.getPackageManager().getLaunchIntentForPackage(packageName);
            if (launchIntent != null) {
                launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                applicationContext.startActivity(launchIntent);
                result.success(null);
                return;
            }
        }

        result.error("", "App not found " + packageName, null);
    }
}
