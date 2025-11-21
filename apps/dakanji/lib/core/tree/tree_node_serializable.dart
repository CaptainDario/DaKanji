


/// All tree nodes must implement this interface to be serializable.
abstract class TreeNodeSerializable {
  Map<String, dynamic> toJson();
}