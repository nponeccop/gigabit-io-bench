'use strict';

const SIZE = 8 * 1024 * 1024;
const fs = require('fs');
const buf = new Buffer(SIZE).fill('Q');
let total = 30 * 1024 * 1024 * 1024;

const ws = fs.createWriteStream('bench.bin');

const cb = err => {
  if (err) {
    console.log('err');
  }

  if (total <= 0) {
    return;
  }

  if (total <= SIZE) {
    const w = total;
    total = 0;
    ws.end(buf.slice(0, w), cb);
  } else {
    total -= SIZE;
    ws.write(buf, cb);
  }
};

console.log(total);
cb();
