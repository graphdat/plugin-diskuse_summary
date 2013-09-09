var _du = require('diskspace');

var pollInterval = process.argv[2];

var c;
var smallestDev;
var smallest;

function checkFnc(dev)
{
	return function(total, free, status)
	{
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
