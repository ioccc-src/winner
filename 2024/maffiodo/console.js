var console = {};
console.log = function () {
  var i = 0;
  while (i < arguments.length) {
    var arg = "" + arguments[i];
    print(arg);
    i += 1;
    if (i == arguments.length) {
      break;
    }
    print(' ');
  }
  print('\n');
};

if (test) {
  console.log(123, "ABC", {}, []);
}
