package com.pichillilorenzo.flutter_appavailability;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.PackageInfo;
import android.content.pm.ApplicationInfo;
import android.os.Build;
import android.annotation.TargetApi;

/** AppAvailability */
public class AppAvailability implements MethodCallHandler {

  private final Activity activity;
  private final Registrar registrar;

  public AppAvailability(Registrar registrar, Activity activity) {
    this.registrar = registrar;
    this.activity = activity;
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.pichillilorenzo/flutter_appavailability");
    channel.setMethodCallHandler(new AppAvailability(registrar, registrar.activity()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String uriSchema;
    switch (call.method) {
      case "checkAvailability":
        uriSchema = call.argument("uri").toString();
        this.checkAvailability( uriSchema, result );
        break;
      case "getInstalledApps":
        result.success(getInstalledApps());
        break;
      case "isAppEnabled":
        uriSchema = call.argument("uri").toString();
        this.isAppEnabled( uriSchema, result );
        break;
      case "launchApp":
        uriSchema = call.argument("uri").toString();
        this.launchApp(uriSchema , result);
        break;
      default:
        result.notImplemented();
    }
  }

  private void checkAvailability(String uri, Result result) {
    PackageInfo info = getAppPackageInfo(uri);

    if(info != null) {
      result.success(this.convertPackageInfoToJson(info));
      return;
    }
    result.error("", "App not found " + uri, null);
  }

  private List<Map<String, Object>> getInstalledApps() {
    PackageManager packageManager = registrar.context().getPackageManager();
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
    Context ctx = activity.getApplicationContext();
    final PackageManager pm = ctx.getPackageManager();

    try {
      return pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES);
    }
    catch(PackageManager.NameNotFoundException e) {

    }

    return null;
  }

  private Map<String, Object> convertPackageInfoToJson(PackageInfo info) {
    Map<String, Object> map = new HashMap<>();
    map.put("app_name", info.applicationInfo.loadLabel(registrar.context().getPackageManager()).toString());
    map.put("package_name", info.packageName);
    map.put("version_code", String.valueOf(info.versionCode));
    map.put("version_name", info.versionName);
    return map;
  }

  private void isAppEnabled(String packageName, Result result) {
    boolean appStatus = false;
    try {
      ApplicationInfo ai = registrar.context().getPackageManager().getApplicationInfo(packageName, 0);
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

    if(info != null) {
      Intent launchIntent = registrar.context().getPackageManager().getLaunchIntentForPackage(packageName);
      if (launchIntent != null) {
        launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        registrar.context().startActivity(launchIntent);
        result.success(null);
        return;
      }
    }

    result.error("", "App not found " + packageName, null);
  }
}
