var dgram = require('dgram')

var s = dgram.createSocket('udp4')

var buf = new Buffer(64);

for (var i = 0; i < 64; i++)
{
		buf[i] = 'Q'
}

var toSend = 10 * 1000 * 100;

function send()
{
		s.send(buf, 0, 64, 9999, '127.0.0.1', function (err)
		{
			if (err) console.log("err!");
			if (toSend > 0)
			{
				// process.nextTick(send)
				send()
			}
			else
			{
				s.close()
			}	
			toSend -= 1
		})
}

send()
console.log(toSend)
