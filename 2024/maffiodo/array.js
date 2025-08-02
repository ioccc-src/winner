var Array = {};

// at(array, index)
//    return element at array index
Array.at = function () {
  var array = arguments[0];
  var index = arguments[1];
  return array[index];
};

// join(array, separator)
//    return a string there all array items has been concatenated using separator
Array.join = function () {
  var array = arguments[0];
  var separator = arguments[1];
  var i = 0;
  var o = '';
  while (i < array.length) {
    o += array[i];
    if (i + 1 < array.length)
      o += separator;
    i += 1;
  }
  return o;
};

// push(array, item1..itemN)
//    return the array element with item1..itemN added to it
Array.push = function () {
  var array = arguments[0];
  var j = array.length;
  var i = 1;
  while (i < arguments.length) {
    //print("apush " + j + "\n");
    array[j] = arguments[i];
    i += 1;
    j += 1;
  }
  return array;
};

// pop(array)
//    return an object with the removed element and a new array
Array.pop = function () {
  var array = arguments[0];
  var i = 0;
  var newArray = [];
  var results = {};
  var alen = array.length;
  if (alen == 0) {
    return results;
  }
  //print("alen-1 = " + (alen -1) + '\n');
  var removed = array[alen - 1];
  while (i < alen - 1) {
    newArray[i] = array[i];
    i += 1;
  }
  results.removed = removed;
  results.new = newArray;
  return results;
};

// concat(array1, array2)
//    return a new array concatenation of array1 and array2
Array.concat = function () {
  var array1 = arguments[0];
  var array2 = arguments[1];
  var i = 0;
  var newArray = [];
  while (i < array1.length) {
    newArray[i] = array1[i];
    i += 1;
  }
  var j = 0;
  while (j < array2.length) {
    newArray[i] = array2[j];
    i += 1;
    j += 1;
  }
  return newArray;
};

// slice(array, start, end)
//    return a slice of the array from start to end 
Array.slice = function () {
  if (arguments.length < 2) {
    return [];
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
  var o = [];
  var j = 0;
  var i = from;
  print("to=" + to + ", sl=" + s.length + "\n");
  while (i < to && i < s.length) {
    //print("slice loop [" + s[i] + "]\n");
    o[j] = s[i];
    j += 1;
    i += 1;
  }
  return o;
};

// toString(array)
//    return array join with comma
Array.toString = function () {
  var array = arguments[0];
  return Array.join(array, ',');
};

// filter(array, callback)
//    return array elements where callback(item) return 1 (true)
Array.filter = function () {
  var array = arguments[0];
  var callback = arguments[1];
  var i = 0;
  var j = 0;
  var out = [];
  while (i < array.length) {
    if (callback(array[i])) {
      out[j] = array[i];
      j += 1;
    }
    i += 1;
  }
  return out;
};

if (test) {
  var a0 = [];
  a0[0] = 123;
  a0[1] = 'H2o';
  var temp = a0[0 + 1];
  print("temp: " + temp + '\n');
  print(a0.length + '\n');
  print(Array.join(a0, " , ") + '\n');
  Array.push(a0, 1, 2, 3);
  print(Array.join(a0, " ") + '\n');
  print("pop tests\n");
  var popResults = Array.pop(a0);
  //print(popResults.length + '\n');
  print(popResults.removed + '\n');
  //print(popResults.new + '\n');
  print(Array.join(popResults.new, " ") + '\n');
  print("concat tests\n");
  var ct = Array.concat(popResults.new, a0);
  print(Array.toString(ct) + '\n');
  print("slice tests\n");
  print(Array.toString(Array.slice(ct, 0, 2)) + '\n');
  print(Array.toString(Array.slice(ct, 5, 8)) + '\n');
  print(Array.toString(Array.slice(ct, 5)) + '\n');
  print("filter tests\n");
  print(Array.toString(Array.filter(ct, function () { 
    return arguments[0] > 1; 
  })) + '\n');
  var matrix = [];
  matrix[0] = [];
  matrix[0][0] = 1;
  matrix[0][1] = 2;
  matrix[0][2] = 3;
  matrix[1] = [];
  matrix[1][0] = 11;
  matrix[1][1] = 12;
  matrix[1][2] = 13;
  print("matrix: \n" + 
    "  " + Array.toString(matrix[0]) + '\n' +
    "  " + Array.toString(matrix[1]) + '\n');
}
