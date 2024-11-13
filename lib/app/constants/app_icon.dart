const _path = "asset/icons/";

class AppIcon {
  static String edit = "edit.svg".withIconPath();
  static String more = "more.svg".withIconPath();
}

extension AppIconString on String {
  String withIconPath({bool withPrefix = true, String group = ""}) {
    return "$_path$group${group.isEmpty ? "" : "/"}${withPrefix ? "ic_${group.isEmpty ? "" : "${group}_"}" : ""}$this";
  }
}
