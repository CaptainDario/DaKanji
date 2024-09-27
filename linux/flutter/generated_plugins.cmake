#
# Generated file, do not edit.
#

list(APPEND FLUTTER_PLUGIN_LIST
  clipboard_watcher
  dynamic_color
  fvp
  gtk
  irondash_engine_context
  isar_flutter_libs
  mecab_dart
  printing
  rive_common
  screen_retriever
  sentry_flutter
  sqlite3_flutter_libs
  super_native_extensions
  url_launcher_linux
  window_manager
)

list(APPEND FLUTTER_FFI_PLUGIN_LIST
  tflite_flutter
)

set(PLUGIN_BUNDLED_LIBRARIES)

foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/linux plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${plugin}_plugin>)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${plugin}_bundled_libraries})
endforeach(plugin)

foreach(ffi_plugin ${FLUTTER_FFI_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${ffi_plugin}/linux plugins/${ffi_plugin})
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${ffi_plugin}_bundled_libraries})
endforeach(ffi_plugin)
