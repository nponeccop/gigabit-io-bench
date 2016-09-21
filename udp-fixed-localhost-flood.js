'use strict';

const dgram = require('dgram');
const s = dgram.createSocket('udp4');
const buf = new Buffer(64).fill('Q');

let toSend = 6 * 1000 * 1000;
const bulk = 100;

const send = cnt => {
  const cb = err => {
    if (err) {
      console.log("err!");
    }
    toSend -= 1;
    if (toSend === 0) {
      s.close();
    }

    if (cnt > 0) {
      cnt -= 1;
      s.send(buf, 0, 64, 9999, '127.0.0.1', cb);
    }
  };

  toSend += 1;
  cb();
};

console.log(toSend);
for(let i = 0; i < bulk; i++) {
  send(toSend / bulk);
}
