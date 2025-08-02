var testCounter = 0;

var verify = function () {
  var src = '{' + arguments[0] + '}';
  print("test " + testCounter + ": " + src + " ");
  testCounter += 1;
  var expected = arguments[1];
  var res = eval(src);
  if (res == expected) {
    print("\x1b[32;1mOK\x1b[0m");
  } else {
    print("\x1b[31;1mKO\x1b[0m");
  }
  print(" (exp=" + expected + " res=" + res + ")\n");
};
var x = 0;

verify(";", "[object]");
verify("; 2; 3", "3");
verify("2*(2+3)-1", 9);
verify("'' + 32", "32");
verify("\"\" + 32", "32");
verify("x + 32", 32);
verify("x = 3", 3);
verify("x", 3);
verify("var y = 11", 11);
verify("var y = 11, z = 22", 22);
verify("var foo = function () { 2; }; return foo;", "{ 2; }");
verify("' 1 2 \\n 23 \\' '", " 1 2 \n 23 \' ");
verify(" 'hello' == 'hello'; ", 1);
verify(" 'hello' == 'hello2'; ", 0);
verify(" 'hello' != 'hello2'; ", 1);
verify(" '32' == 32; ", 1);
verify(" '32' == 33; ", 0);
verify(" '32' <= 33; ", 1);
verify(" '32' <= 2; ", 0);
verify(" '2' >= 32; ", 0);
verify(" '32' >= 2; ", 1);
verify(" 32 == 32; ", 1);
verify(" 32 >= 0; ", 1);
verify(" 0 <= 32; ", 1);
verify(" 1+4 && 3-3; ", 0); 
verify(" 1+4 || 3-3; ", 1);
verify(" 1<<3; ", 8); 
verify(" 8>>3; ", 1); 
verify(" -6; ", -6); 
verify(" +'6'; ", 6); 
verify(" ~'6'; ", -7); 
verify(" !'6'; ", 0); 
verify(" !'0'; ", 1); 
verify(" !(1 && 2); ", 0);
verify(" 0.1 + 0.2 == 0.3; ", 1); // this is different from nodejs!! <<<<<<<<<<
verify(" 'hello'.length; ", 5);
verify(" [].length; ", 0);
verify(" {}.length; ", 0); // this is strange but usefull? <<<<<<<<<<<<<<<<<<<<
var obj = {};
verify("obj.abc = 32;", 32);
verify("obj[0] = 2; ",  2);
verify("obj[0]; ", 2);
verify("obj[1] = {}; ", "[object]");
verify("obj[1].temp = 123; ", 123);
verify("obj[1].temp; ", 123);
verify("'abc'[0];", "a"); 
verify("'1+2'();", 3); 
verify("0 || 'hello'", 0); 
verify("0 || '1hello'", 1); 
verify("; 2; 3;", 3);
verify("{ { 1; }; }; 2; {{3;}}", 3);
verify("{ { return 1; } } 2; 3", 1); 
verify("var strt = '' + 32", "32");
verify("var strt = \"\" + 32", "32");
