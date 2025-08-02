var eval = function () {
  var f = arguments[0];
  return f();
};

if (test) {
  print(eval("1+2") + '\n');
  print(eval("(function () { return 10 + 2; })()") + '\n');

  var obj = {};
  var src = "{\n";
  var i = 0;
  while (i < 10) {
    src += "  obj[" + i + "] = 'temp-string-" + i + "';\n";
    i += 1;
  }
  src += '}';
  print("dynamic generated src:\n" + src + "\n");
  eval(src);
  print("eval results:\n");
  print('obj-length = ' + obj.length + '\n');
  print('obj.0 = ' + obj[0] + '\n');
  print('obj.4 = ' + obj[4] + '\n');
  print('obj.9 = ' + obj[9] + '\n');
  print(obj['9'] + '\n');
}
