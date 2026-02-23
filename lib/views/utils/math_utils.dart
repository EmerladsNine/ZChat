

class MathUtils {
  static int? tryParseUint32(String source)
  {
    int? num = int.tryParse(source);
    if(num != null && num >= 0 && num <= 0xffffffff) return num;
    return null;
  }
}

