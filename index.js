var _param = require('./param.json');
var _du = require('diskspace');

var pollInterval = _param.pollInterval || 3000;

var c;
var smallestDev;
var smallest;

function checkFnc(dev)
{
	return function(error, total, free, status)
	{
		if (!error) {
			var perc = 1.0 - (free / total);
			if (!smallest || smallest <  perc)
			{
				smallest = perc;
				smallestDev = dev;
			}

			if (!--c)
			{
				console.log('DISKUSE_SUMMARY %d', smallest);
			}
		} else {
			--c;
		}
	}
}

function poll()
{
	c = process.argv.length - 3;
	smallestDev = null;
	smallest = null;

	for (var i = 3; i < process.argv.length; i++)
	{
		_du.check(process.argv[i], checkFnc(process.argv[i]));
	}
}


setInterval(poll, pollInterval);
