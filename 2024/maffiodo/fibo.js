var number = 20,
    n1 = 0, 
    n2 = 1, 
    i = 0,
    nextTerm;

console.log('fibonacci series:');

while (i < number) {
    console.log(i, '=', n1);
    nextTerm = n1 + n2;
    n1 = n2;
    n2 = nextTerm;
    i += 1;
}
console.log('end', n1);
