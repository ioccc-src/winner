var String = {};

// slice(string, from, to)
//    return substring
String.slice = function () {
  if (arguments.length < 2) {
    return '';
  }
  var s = arguments[0];
  var from = arguments[1];
  var to;
  if (arguments.length > 2) {
    to = arguments[2];
    //print("slice case0 " + to + '\n');
  } else {
    to = s.length;
  }
  var o = '';
  var i = from;
  while (i < to && i < s.length) {
    //print("slice loop [" + s[i] + "]\n");
    o += s[i];
    i += 1;
  }
  return o;
};

// split(string, singleCharSeparator)
//    return array of strings
String.split = function () {
  var o = [];
  var s = arguments[0];
  var delimiter = arguments[1];
  var start = 0;
  var i = 0;
  var oindex = 0;
  while (i < s.length) {
    if (s[i] == delimiter) {
      o[oindex] = String.slice(s, start, i);
      start = i + 1;
      oindex += 1;
    }
    i += 1;
  }
  if (start < s.length) { 
    o[oindex] = String.slice(s, start); 
  }
  return o;
};

// startsWith(s, prefix)
//    return 1 if s starts with prefix substring
String.startsWith = function () {
  var s = arguments[0];
  var prefix = arguments[1];
  return String.slice(s, 0, prefix.length) == prefix;
};

var _cm = {}; // map from character to ASCII code 
_cm["\x00"] =   0;  _cm["\x01"] =   1;  _cm["\x02"] =   2;  _cm["\x03"] =   3;  
_cm["\x04"] =   4;  _cm["\x05"] =   5;  _cm["\x06"] =   6;  _cm["\x07"] =   7;  
_cm["\x08"] =   8;  _cm["\x09"] =   9;  _cm["\x0a"] =  10;  _cm["\x0b"] =  11;  
_cm["\x0c"] =  12;  _cm["\x0d"] =  13;  _cm["\x0e"] =  14;  _cm["\x0f"] =  15;  
_cm["\x10"] =  16;  _cm["\x11"] =  17;  _cm["\x12"] =  18;  _cm["\x13"] =  19;  
_cm["\x14"] =  20;  _cm["\x15"] =  21;  _cm["\x16"] =  22;  _cm["\x17"] =  23;  
_cm["\x18"] =  24;  _cm["\x19"] =  25;  _cm["\x1a"] =  26;  _cm["\x1b"] =  27;  
_cm["\x1c"] =  28;  _cm["\x1d"] =  29;  _cm["\x1e"] =  30;  _cm["\x1f"] =  31;  
_cm["\x20"] =  32;  _cm[   "!"] =  33;  _cm[   '"'] =  34;  _cm[   "#"] =  35;  
_cm[   "$"] =  36;  _cm[   "%"] =  37;  _cm[   "&"] =  38;  _cm[   "'"] =  39;  
_cm[   "("] =  40;  _cm[   ")"] =  41;  _cm[   "*"] =  42;  _cm[   "+"] =  43;  
_cm[   ","] =  44;  _cm[   "-"] =  45;  _cm[   "."] =  46;  _cm[   "/"] =  47;  
_cm[   "0"] =  48;  _cm[   "1"] =  49;  _cm[   "2"] =  50;  _cm[   "3"] =  51;  
_cm[   "4"] =  52;  _cm[   "5"] =  53;  _cm[   "6"] =  54;  _cm[   "7"] =  55;  
_cm[   "8"] =  56;  _cm[   "9"] =  57;  _cm[   ":"] =  58;  _cm[   ";"] =  59;  
_cm[   "<"] =  60;  _cm[   "="] =  61;  _cm[   ">"] =  62;  _cm[   "?"] =  63;  
_cm[   "@"] =  64;  _cm[   "A"] =  65;  _cm[   "B"] =  66;  _cm[   "C"] =  67;  
_cm[   "D"] =  68;  _cm[   "E"] =  69;  _cm[   "F"] =  70;  _cm[   "G"] =  71;  
_cm[   "H"] =  72;  _cm[   "I"] =  73;  _cm[   "J"] =  74;  _cm[   "K"] =  75;  
_cm[   "L"] =  76;  _cm[   "M"] =  77;  _cm[   "N"] =  78;  _cm[   "O"] =  79;  
_cm[   "P"] =  80;  _cm[   "Q"] =  81;  _cm[   "R"] =  82;  _cm[   "S"] =  83;  
_cm[   "T"] =  84;  _cm[   "U"] =  85;  _cm[   "V"] =  86;  _cm[   "W"] =  87;  
_cm[   "X"] =  88;  _cm[   "Y"] =  89;  _cm[   "Z"] =  90;  _cm[   "["] =  91;  
_cm[  "\\"] =  92;  _cm[   "]"] =  93;  _cm[   "^"] =  94;  _cm[   "_"] =  95;  
_cm[   "`"] =  96;  _cm[   "a"] =  97;  _cm[   "b"] =  98;  _cm[   "c"] =  99;  
_cm[   "d"] = 100;  _cm[   "e"] = 101;  _cm[   "f"] = 102;  _cm[   "g"] = 103;  
_cm[   "h"] = 104;  _cm[   "i"] = 105;  _cm[   "j"] = 106;  _cm[   "k"] = 107;  
_cm[   "l"] = 108;  _cm[   "m"] = 109;  _cm[   "n"] = 110;  _cm[   "o"] = 111;  
_cm[   "p"] = 112;  _cm[   "q"] = 113;  _cm[   "r"] = 114;  _cm[   "s"] = 115;  
_cm[   "t"] = 116;  _cm[   "u"] = 117;  _cm[   "v"] = 118;  _cm[   "w"] = 119;  
_cm[   "x"] = 120;  _cm[   "y"] = 121;  _cm[   "z"] = 122;  _cm[   "{"] = 123;  
_cm[   "|"] = 124;  _cm[   "}"] = 125;  _cm[   "~"] = 126;  _cm["\x7f"] = 127;  
_cm["\x80"] = 128;  _cm["\x81"] = 129;  _cm["\x82"] = 130;  _cm["\x83"] = 131;  
_cm["\x84"] = 132;  _cm["\x85"] = 133;  _cm["\x86"] = 134;  _cm["\x87"] = 135;  
_cm["\x88"] = 136;  _cm["\x89"] = 137;  _cm["\x8a"] = 138;  _cm["\x8b"] = 139;  
_cm["\x8c"] = 140;  _cm["\x8d"] = 141;  _cm["\x8e"] = 142;  _cm["\x8f"] = 143;  
_cm["\x90"] = 144;  _cm["\x91"] = 145;  _cm["\x92"] = 146;  _cm["\x93"] = 147;  
_cm["\x94"] = 148;  _cm["\x95"] = 149;  _cm["\x96"] = 150;  _cm["\x97"] = 151;  
_cm["\x98"] = 152;  _cm["\x99"] = 153;  _cm["\x9a"] = 154;  _cm["\x9b"] = 155;  
_cm["\x9c"] = 156;  _cm["\x9d"] = 157;  _cm["\x9e"] = 158;  _cm["\x9f"] = 159;  
_cm["\xa0"] = 160;  _cm["\xa1"] = 161;  _cm["\xa2"] = 162;  _cm["\xa3"] = 163;  
_cm["\xa4"] = 164;  _cm["\xa5"] = 165;  _cm["\xa6"] = 166;  _cm["\xa7"] = 167;  
_cm["\xa8"] = 168;  _cm["\xa9"] = 169;  _cm["\xaa"] = 170;  _cm["\xab"] = 171;  
_cm["\xac"] = 172;  _cm["\xad"] = 173;  _cm["\xae"] = 174;  _cm["\xaf"] = 175;  
_cm["\xb0"] = 176;  _cm["\xb1"] = 177;  _cm["\xb2"] = 178;  _cm["\xb3"] = 179;  
_cm["\xb4"] = 180;  _cm["\xb5"] = 181;  _cm["\xb6"] = 182;  _cm["\xb7"] = 183;  
_cm["\xb8"] = 184;  _cm["\xb9"] = 185;  _cm["\xba"] = 186;  _cm["\xbb"] = 187;  
_cm["\xbc"] = 188;  _cm["\xbd"] = 189;  _cm["\xbe"] = 190;  _cm["\xbf"] = 191;  
_cm["\xc0"] = 192;  _cm["\xc1"] = 193;  _cm["\xc2"] = 194;  _cm["\xc3"] = 195;  
_cm["\xc4"] = 196;  _cm["\xc5"] = 197;  _cm["\xc6"] = 198;  _cm["\xc7"] = 199;  
_cm["\xc8"] = 200;  _cm["\xc9"] = 201;  _cm["\xca"] = 202;  _cm["\xcb"] = 203;  
_cm["\xcc"] = 204;  _cm["\xcd"] = 205;  _cm["\xce"] = 206;  _cm["\xcf"] = 207;  
_cm["\xd0"] = 208;  _cm["\xd1"] = 209;  _cm["\xd2"] = 210;  _cm["\xd3"] = 211;  
_cm["\xd4"] = 212;  _cm["\xd5"] = 213;  _cm["\xd6"] = 214;  _cm["\xd7"] = 215;  
_cm["\xd8"] = 216;  _cm["\xd9"] = 217;  _cm["\xda"] = 218;  _cm["\xdb"] = 219;  
_cm["\xdc"] = 220;  _cm["\xdd"] = 221;  _cm["\xde"] = 222;  _cm["\xdf"] = 223;  
_cm["\xe0"] = 224;  _cm["\xe1"] = 225;  _cm["\xe2"] = 226;  _cm["\xe3"] = 227;  
_cm["\xe4"] = 228;  _cm["\xe5"] = 229;  _cm["\xe6"] = 230;  _cm["\xe7"] = 231;  
_cm["\xe8"] = 232;  _cm["\xe9"] = 233;  _cm["\xea"] = 234;  _cm["\xeb"] = 235;  
_cm["\xec"] = 236;  _cm["\xed"] = 237;  _cm["\xee"] = 238;  _cm["\xef"] = 239;  
_cm["\xf0"] = 240;  _cm["\xf1"] = 241;  _cm["\xf2"] = 242;  _cm["\xf3"] = 243;  
_cm["\xf4"] = 244;  _cm["\xf5"] = 245;  _cm["\xf6"] = 246;  _cm["\xf7"] = 247;  
_cm["\xf8"] = 248;  _cm["\xf9"] = 249;  _cm["\xfa"] = 250;  _cm["\xfb"] = 251;  
_cm["\xfc"] = 252;  _cm["\xfd"] = 253;  _cm["\xfe"] = 254;  _cm["\xff"] = 255;  

var _rcm = {};
_rcm[  0] = "\x00";  _rcm[  1] = "\x01";  _rcm[  2] = "\x02";  _rcm[  3] = "\x03";  
_rcm[  4] = "\x04";  _rcm[  5] = "\x05";  _rcm[  6] = "\x06";  _rcm[  7] = "\x07";  
_rcm[  8] = "\x08";  _rcm[  9] = "\x09";  _rcm[ 10] = "\x0a";  _rcm[ 11] = "\x0b";  
_rcm[ 12] = "\x0c";  _rcm[ 13] = "\x0d";  _rcm[ 14] = "\x0e";  _rcm[ 15] = "\x0f";  
_rcm[ 16] = "\x10";  _rcm[ 17] = "\x11";  _rcm[ 18] = "\x12";  _rcm[ 19] = "\x13";  
_rcm[ 20] = "\x14";  _rcm[ 21] = "\x15";  _rcm[ 22] = "\x16";  _rcm[ 23] = "\x17";  
_rcm[ 24] = "\x18";  _rcm[ 25] = "\x19";  _rcm[ 26] = "\x1a";  _rcm[ 27] = "\x1b";  
_rcm[ 28] = "\x1c";  _rcm[ 29] = "\x1d";  _rcm[ 30] = "\x1e";  _rcm[ 31] = "\x1f";  
_rcm[ 32] = "\x20";  _rcm[ 33] =    "!";  _rcm[ 34] =    '"';  _rcm[ 35] =    "#";  
_rcm[ 36] =    "$";  _rcm[ 37] =    "%";  _rcm[ 38] =    "&";  _rcm[ 39] =    "'";  
_rcm[ 40] =    "(";  _rcm[ 41] =    ")";  _rcm[ 42] =    "*";  _rcm[ 43] =    "+";  
_rcm[ 44] =    ",";  _rcm[ 45] =    "-";  _rcm[ 46] =    ".";  _rcm[ 47] =    "/";  
_rcm[ 48] =    "0";  _rcm[ 49] =    "1";  _rcm[ 50] =    "2";  _rcm[ 51] =    "3";  
_rcm[ 52] =    "4";  _rcm[ 53] =    "5";  _rcm[ 54] =    "6";  _rcm[ 55] =    "7";  
_rcm[ 56] =    "8";  _rcm[ 57] =    "9";  _rcm[ 58] =    ":";  _rcm[ 59] =    ";";  
_rcm[ 60] =    "<";  _rcm[ 61] =    "=";  _rcm[ 62] =    ">";  _rcm[ 63] =    "?";  
_rcm[ 64] =    "@";  _rcm[ 65] =    "A";  _rcm[ 66] =    "B";  _rcm[ 67] =    "C";  
_rcm[ 68] =    "D";  _rcm[ 69] =    "E";  _rcm[ 70] =    "F";  _rcm[ 71] =    "G";  
_rcm[ 72] =    "H";  _rcm[ 73] =    "I";  _rcm[ 74] =    "J";  _rcm[ 75] =    "K";  
_rcm[ 76] =    "L";  _rcm[ 77] =    "M";  _rcm[ 78] =    "N";  _rcm[ 79] =    "O";  
_rcm[ 80] =    "P";  _rcm[ 81] =    "Q";  _rcm[ 82] =    "R";  _rcm[ 83] =    "S";  
_rcm[ 84] =    "T";  _rcm[ 85] =    "U";  _rcm[ 86] =    "V";  _rcm[ 87] =    "W";  
_rcm[ 88] =    "X";  _rcm[ 89] =    "Y";  _rcm[ 90] =    "Z";  _rcm[ 91] =    "[";  
_rcm[ 92] =   "\\";  _rcm[ 93] =    "]";  _rcm[ 94] =    "^";  _rcm[ 95] =    "_";  
_rcm[ 96] =    "`";  _rcm[ 97] =    "a";  _rcm[ 98] =    "b";  _rcm[ 99] =    "c";  
_rcm[100] =    "d";  _rcm[101] =    "e";  _rcm[102] =    "f";  _rcm[103] =    "g";  
_rcm[104] =    "h";  _rcm[105] =    "i";  _rcm[106] =    "j";  _rcm[107] =    "k";  
_rcm[108] =    "l";  _rcm[109] =    "m";  _rcm[110] =    "n";  _rcm[111] =    "o";  
_rcm[112] =    "p";  _rcm[113] =    "q";  _rcm[114] =    "r";  _rcm[115] =    "s";  
_rcm[116] =    "t";  _rcm[117] =    "u";  _rcm[118] =    "v";  _rcm[119] =    "w";  
_rcm[120] =    "x";  _rcm[121] =    "y";  _rcm[122] =    "z";  _rcm[123] =    "{";  
_rcm[124] =    "|";  _rcm[125] =    "}";  _rcm[126] =    "~";  _rcm[127] = "\x7f";  
_rcm[128] = "\x80";  _rcm[129] = "\x81";  _rcm[130] = "\x82";  _rcm[131] = "\x83";  
_rcm[132] = "\x84";  _rcm[133] = "\x85";  _rcm[134] = "\x86";  _rcm[135] = "\x87";  
_rcm[136] = "\x88";  _rcm[137] = "\x89";  _rcm[138] = "\x8a";  _rcm[139] = "\x8b";  
_rcm[140] = "\x8c";  _rcm[141] = "\x8d";  _rcm[142] = "\x8e";  _rcm[143] = "\x8f";  
_rcm[144] = "\x90";  _rcm[145] = "\x91";  _rcm[146] = "\x92";  _rcm[147] = "\x93";  
_rcm[148] = "\x94";  _rcm[149] = "\x95";  _rcm[150] = "\x96";  _rcm[151] = "\x97";  
_rcm[152] = "\x98";  _rcm[153] = "\x99";  _rcm[154] = "\x9a";  _rcm[155] = "\x9b";  
_rcm[156] = "\x9c";  _rcm[157] = "\x9d";  _rcm[158] = "\x9e";  _rcm[159] = "\x9f";  
_rcm[160] = "\xa0";  _rcm[161] = "\xa1";  _rcm[162] = "\xa2";  _rcm[163] = "\xa3";  
_rcm[164] = "\xa4";  _rcm[165] = "\xa5";  _rcm[166] = "\xa6";  _rcm[167] = "\xa7";  
_rcm[168] = "\xa8";  _rcm[169] = "\xa9";  _rcm[170] = "\xaa";  _rcm[171] = "\xab";  
_rcm[172] = "\xac";  _rcm[173] = "\xad";  _rcm[174] = "\xae";  _rcm[175] = "\xaf";  
_rcm[176] = "\xb0";  _rcm[177] = "\xb1";  _rcm[178] = "\xb2";  _rcm[179] = "\xb3";  
_rcm[180] = "\xb4";  _rcm[181] = "\xb5";  _rcm[182] = "\xb6";  _rcm[183] = "\xb7";  
_rcm[184] = "\xb8";  _rcm[185] = "\xb9";  _rcm[186] = "\xba";  _rcm[187] = "\xbb";  
_rcm[188] = "\xbc";  _rcm[189] = "\xbd";  _rcm[190] = "\xbe";  _rcm[191] = "\xbf";  
_rcm[192] = "\xc0";  _rcm[193] = "\xc1";  _rcm[194] = "\xc2";  _rcm[195] = "\xc3";  
_rcm[196] = "\xc4";  _rcm[197] = "\xc5";  _rcm[198] = "\xc6";  _rcm[199] = "\xc7";  
_rcm[200] = "\xc8";  _rcm[201] = "\xc9";  _rcm[202] = "\xca";  _rcm[203] = "\xcb";  
_rcm[204] = "\xcc";  _rcm[205] = "\xcd";  _rcm[206] = "\xce";  _rcm[207] = "\xcf";  
_rcm[208] = "\xd0";  _rcm[209] = "\xd1";  _rcm[210] = "\xd2";  _rcm[211] = "\xd3";  
_rcm[212] = "\xd4";  _rcm[213] = "\xd5";  _rcm[214] = "\xd6";  _rcm[215] = "\xd7";  
_rcm[216] = "\xd8";  _rcm[217] = "\xd9";  _rcm[218] = "\xda";  _rcm[219] = "\xdb";  
_rcm[220] = "\xdc";  _rcm[221] = "\xdd";  _rcm[222] = "\xde";  _rcm[223] = "\xdf";  
_rcm[224] = "\xe0";  _rcm[225] = "\xe1";  _rcm[226] = "\xe2";  _rcm[227] = "\xe3";  
_rcm[228] = "\xe4";  _rcm[229] = "\xe5";  _rcm[230] = "\xe6";  _rcm[231] = "\xe7";  
_rcm[232] = "\xe8";  _rcm[233] = "\xe9";  _rcm[234] = "\xea";  _rcm[235] = "\xeb";  
_rcm[236] = "\xec";  _rcm[237] = "\xed";  _rcm[238] = "\xee";  _rcm[239] = "\xef";  
_rcm[240] = "\xf0";  _rcm[241] = "\xf1";  _rcm[242] = "\xf2";  _rcm[243] = "\xf3";  
_rcm[244] = "\xf4";  _rcm[245] = "\xf5";  _rcm[246] = "\xf6";  _rcm[247] = "\xf7";  
_rcm[248] = "\xf8";  _rcm[249] = "\xf9";  _rcm[250] = "\xfa";  _rcm[251] = "\xfb";  
_rcm[252] = "\xfc";  _rcm[253] = "\xfd";  _rcm[254] = "\xfe";  _rcm[255] = "\xff";  

// charAt(s, index)
//    return character of s at index
String.charAt = function () {
  var s = arguments[0];
  var i = arguments[1];
  // print("debug2 " + s + ':' + i + '\n');
  return String.slice(s, i, i+1);
};

// charCodeAt(s, index)
//    return ASCII character code of s at index
String.charCodeAt = function () {
  var s = arguments[0];
  var i = arguments[1];
  var c = String.charAt(s, i);
  // print("debug? " + c + '\n');
  return _cm[c];
};

// fromCharCode(code)
//    return a new string with one character from given ASCII code
String.fromCharCode = function () {
  var code = arguments[0];
  return _rcm[code];
};

// trimStart(s)
//    return s with left side trimmable characters removed
String.trimStart = function () {
  var s = arguments[0];
  var o = "";
  var i = 0;
  while (1) {
    var code = String.charCodeAt(s, i);
    // print("code? " + code + '\n');
    if ((code == 32) || (code == 9) || (code == 10) || (code == 13))
      i += 1;
    else
      break;
  }
  // print("trim res " + i + '\n');
  return String.slice(s, i);
};

// trimEnd(s)
//    return s with right side trimmable characters removed
String.trimEnd = function () {
  var s = arguments[0];
  var o = "";
  var i = s.length - 1;
  while (i >= 0) {
    var code = String.charCodeAt(s, i);
    // print("code? " + code + '\n');
    if ((code == 32) || (code == 9) || (code == 10) || (code == 13))
      i -= 1;
    else
      break;
  }
  // print("trim res " + i + '\n');
  return String.slice(s, 0, i+1);
};

// trim(s)
//    return s with left+right side trimmable characters removed
String.trim = function () {
  var s = arguments[0];
  s = String.trimStart(s);
  s = String.trimEnd(s);
  return s;
};

if (test) {
  var test = "hello world!";
  print(String.slice(test, 1) + "\n");
  print(String.slice(test, 1, 5) + "\n");
  
  var test2 = "abc,  d, e f";
  var splitted = String.split(test2, ",");
  print(splitted.length + "\n");
  print('[' + splitted[0] + "]\n");
  print('[' + splitted[1] + "]\n");
  print('[' + splitted[2] + "]\n");

  print(String.slice('a', 0, 5) + '\n');
  
  print(String.startsWith('abc', 'ab') + '\n');
  print(String.startsWith('abc', 'abcd') + '\n');

  print(String.fromCharCode(112) + '\n');
  print(String.charCodeAt('p', 0) + '\n');

  print(String.trimStart(" \n    \x09 hello! ") + '\n');
  print(String.trimEnd(" \n    \x09 hello! \n \x0a ") + '|\n');
  print(String.trim(" \n    \x09 hello! \n \x0a ") + '|\n');
}
