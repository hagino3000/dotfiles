load('/Users/nishibayashi/src/js/fulljslint.js');
 
var body = arguments[0];
 
var result = JSLINT(body);

if (result) {
   print('All good.');
} else {
   print('Problems:');
}

print(JSLINT.report());

