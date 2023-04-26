


enum InferenceBackend {
  CPU,
  CPU_1, CPU_2, CPU_3, CPU_4, CPU_5, CPU_6, CPU_7, CPU_8,
  CPU_9, CPU_10, CPU_11, CPU_12, CPU_13, CPU_14, CPU_15, CPU_16,
  CPU_17, CPU_18, CPU_19, CPU_20, CPU_21, CPU_22, CPU_23, CPU_24,
  CPU_25, CPU_26, CPU_27, CPU_28, CPU_29, CPU_30, CPU_31, CPU_32,
  GPU,
  NNApi,
  CoreML2,
  CoreML3,
  Metal,
  XNNPack,
  XNNPack_1, XNNPack_2, XNNPack_3, XNNPack_4, XNNPack_5, XNNPack_6, XNNPack_7, XNNPack_8,
  XNNPack_9, XNNPack_10, XNNPack_11, XNNPack_12, XNNPack_13, XNNPack_14, XNNPack_15, XNNPack_16,
  XNNPack_17, XNNPack_18, XNNPack_19, XNNPack_20, XNNPack_21, XNNPack_22, XNNPack_23, XNNPack_24,
  XNNPack_25, XNNPack_26, XNNPack_27, XNNPack_28, XNNPack_29, XNNPack_30, XNNPack_31, XNNPack_32,
}

/// Returns an CPU inference backend from a string.
InferenceBackend getCPUFromString(String backend){
  return InferenceBackend.values.firstWhere((b) => b.name == backend);
}

/// Returns an XNNPack inference backend from a string.
InferenceBackend getXNNPackFromString(String backend){
  return InferenceBackend.values.firstWhere((b) => b.name == backend);
}