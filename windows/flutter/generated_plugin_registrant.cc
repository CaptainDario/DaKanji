//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>
#include <url_launcher_windows/url_launcher_plugin.h>
#include <window_size/window_size_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ObjectboxFlutterLibsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ObjectboxFlutterLibsPlugin"));
  UrlLauncherPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherPlugin"));
  WindowSizePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowSizePlugin"));
}
