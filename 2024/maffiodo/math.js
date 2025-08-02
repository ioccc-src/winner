var Math = {};

Math.E = 2.718281828459045;
Math.e = Math.E;

Math.LN2 = 0.6931471805599453;
Math.LN10 = 2.302585092994046;

Math.LOG2E = 1.4426950408889634;
Math.LOG10E = 0.4342944819032518;

Math.phi = 1.618033988749895;

Math.PI = 3.141592653589793;
Math.pi = Math.PI;

Math.SQRT1_2 = 0.7071067811865476;
Math.SQRT2 = 1.4142135623730951;

Math.tau = 6.283185307179586;

Math.sign = function () {
  var x = arguments[0];
  //print("dbgsign?" + x + '\n');
  if (x < 0) {
    print("case0\n");
    return -1;
  }
  return 1;
};

Math.abs = function () {
  var x = arguments[0];
  if (x < 0)
    return -x;
  return x;
};

if (test) {
  print("pi = " + Math.pi + '\n');
  print("sign(-32) = " + Math.sign(-32) + '\n');
  print("abs(-32) = " + Math.abs(-32) + '\n');
}
