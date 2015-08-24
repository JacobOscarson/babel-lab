// Assumed to be running in the old world

function fail(msg) {
  throw new Error(msg);
}

var foo = require('pkg1/mod1').foo;
if(foo == 'bar') {
  console.log('Can import from pkg1');
} else {
  fail("Failed to import from pkg1");
}

var mod21 = require('pkg2/mod21');
console.log(mod21);

if(mod21.bar == 'bar') {
  console.log("Can import from pkg2");
} else {
  fail("Failed to import (directly) from pkg2");
}

if(mod21.foo_imp == 'bar') {
  console.log('Can import (indirectly) from pkg2');
} else {
  var msg = "Failed to import (indirectly) from pkg2";
  console.error(msg);
  throw new Error(msg);
}
