


enum InferenceBackend {
  cpu,
  cpu_1, cpu_2, cpu_3, cpu_4, cpu_5, cpu_6, cpu_7, cpu_8,
  cpu_9, cpu_10, cpu_11, cpu_12, cpu_13, cpu_14, cpu_15, cpu_16,
  cpu_17, cpu_18, cpu_19, cpu_20, cpu_21, cpu_22, cpu_23, cpu_24,
  cpu_25, cpu_26, cpu_27, cpu_28, cpu_29, cpu_30, cpu_31, cpu_32,
  gpu,
  nnapi,
  coreMl_2,
  coreMl_3,
  metal,
  xnnPack,
  xnnPack_1, xnnPack_2, xnnPack_3, xnnPack_4, xnnPack_5, xnnPack_6, xnnPack_7, xnnPack_8,
  xnnPack_9, xnnPack_10, xnnPack_11, xnnPack_12, xnnPack_13, xnnPack_14, xnnPack_15, xnnPack_16,
  xnnPack_17, xnnPack_18, xnnPack_19, xnnPack_20, xnnPack_21, xnnPack_22, xnnPack_23, xnnPack_24,
  xnnPack_25, xnnPack_26, xnnPack_27, xnnPack_28, xnnPack_29, xnnPack_30, xnnPack_31, xnnPack_32,
}

/// Returns an cpu inference backend from a string.
InferenceBackend getCPUFromString(String backend){
  return InferenceBackend.values.firstWhere((b) => b.name == backend);
}

/// Returns an xnnPack inference backend from a string.
InferenceBackend getXNNPackFromString(String backend){
  return InferenceBackend.values.firstWhere((b) => b.name == backend);
}