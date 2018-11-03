############################################################################
## This software is distributed for free, without warranties of any kind. ##
## Send bug reports or suggestions to hackbarth@gmail.com                 ##
############################################################################

import sys
import audioguide.util as util
import numpy as np





class htmloutput:
	def __init__(self,):
		self.htmlHead = '''<!doctype html>
	<title>AudioGuide Concatenation Log</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
	<script src="http://www.chartjs.org/dist/2.7.2/Chart.js"></script>
	<script src="http://www.chartjs.org/samples/latest/utils.js"></script>
	<style>
	canvas {
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
'''
		self.htmlBody = ''
		self.chartcnt = 0
	
	def log(self, text, p=True):
		if p: self.htmlBody += "<p>%s</p>\n"%text
		else: self.htmlBody += "%s\n"%text
	def logsection(self, text):
		self.htmlBody += "<h2>%s</h2>\n"%text

	def writefile(self, fullpath):
		fh = open(fullpath, 'w')
		fh.write('''<html>
<head>
%s
</head>
<body>
%s
</body>
</html>'''%(self.htmlHead, self.htmlBody))
		fh.close()


	def maketable(self, array, resolution=2):
		self.htmlBody += '<table border="1">'
		self.htmlBody += "<tr>%s</tr>"%(''.join(["<th>%s</th>"%s for s in array[0]]))
		for a in array[1:]:
			self.htmlBody += '<tr>'
			for s in a:
				if isinstance(s, float): self.htmlBody += ("<td>%%.%if</td>"%resolution)%(s)
				else: self.htmlBody += "<td>%s</td>"%s
			self.htmlBody += '</tr>'
		self.htmlBody += "</table>"

	
	
	def jschart_timeseries(self, widthpx=900, heightpx=300, maxlength=500, yarray=[0, 1, 2, 3, 4, 5], xarrays=[[5, 4, 3, 2, 1, 5]], ylabel='time in seconds', xlabels=['descriptorname']):
		id = 'chart%i'%self.chartcnt
		datasetstring = ''
		for idx, xar in enumerate(xarrays):
			if idx == 0: hidden = 'false'
			else: hidden = 'true'
			datasetstring += '''\t\t{label: '%s', data: %s, type: 'line', pointRadius: 0, fill: false, lineTension: 0, borderWidth: 2, hidden: %s},
	'''%(xlabels[idx], np.array2string(util.interpArray(xar, maxlength), precision=2, separator=',').replace('\n', ''), hidden)
	
		self.htmlBody += '''<div style="width:%ipx">
		<canvas id="%s"></canvas>
	</div>
	<script>
		var ctx = document.getElementById('%s').getContext('2d');
		ctx.canvas.width = %i;
		ctx.canvas.height = %i;
		var cfg = {
			type: 'bar',
			data: {
				labels: %s,
				datasets: [%s]
			},
			options: {
				scales: {
					xAxes: [{
						distribution: 'series',
						ticks: {
							source: 'labels'
						},
					}],
					yAxes: [{
						scaleLabel: {
							display: true,
							labelString: 'normalized values'
						}
					}]
				}
			}
		};
		var chart = new Chart(ctx, cfg);
		document.getElementById('update').addEventListener('click', function() {
			var type = document.getElementById('type').value;
			chart.update();
		}
		);
	</script>'''%(widthpx, id, id, widthpx, heightpx, np.array2string(util.interpArray(yarray, maxlength), precision=2, separator=',').replace('\n', ''), datasetstring)
		self.chartcnt += 1



	def addScatter2dAxisChoice(self, datadict, name='myscat', axisdefaults=['effDur-seg', 'power-seg']):
		id = 'chart%i'%self.chartcnt
		#startingDesc = datadict['descnames'][:2]
		html_xaxis_options = ''
		for dname in datadict['tgt'].keys():
			if dname==axisdefaults[0]: extra = 'selected="selected"'
			else: extra = ''
			html_xaxis_options += '\n\t\t<option value="%s" %s>%s</option>'%(dname, extra, dname)
		html_yaxis_options = ''
		for dname in datadict['tgt'].keys():
			if dname==axisdefaults[1]: extra = 'selected="selected"'
			else: extra = ''
			html_yaxis_options += '\n\t\t<option value="%s" %s>%s</option>'%(dname, extra, dname)
		
		
		descOptions = '\n\t\t'.join(['<option value="%s">%s</option>'%(dname, dname) for dname in datadict['tgt'].keys()])
		tgtdata = ''
		for dn, dv in datadict['tgt'].items():
			tgtdata += "'%s': [%s],"%(dn, ', '.join(['%.3f'%(f) for f in dv]))
		cpsdata = ''
		for dn, dv in datadict['cps'].items():
			cpsdata += "'%s': [%s],"%(dn, ', '.join(['%.3f'%(f) for f in dv]))
		self.htmlBody += '''\t<div style="width:100%%">
		<canvas id="%s"></canvas>
	</div>

	x axis: <select id="%s-xaxis">		%s
	</select>
	y axis: <select id="%s-yaxis">		%s
	</select>
	<button id="%s-update">update</button>
	<script>
		var color = Chart.helpers.color;
		
		var tgtdata = {%s};
		var cpsdata = {%s};
		
		function pullValues(chartobj, xaxis_name, yaxis_name) {
			var tgtcoors = [];
			for (i = 0; i < tgtdata[xaxis_name].length; i++) { 
    			tgtcoors.push({'x': tgtdata[xaxis_name][i], 'y': tgtdata[yaxis_name][i]});
			};
			var cpscoors = [];
			for (i = 0; i < cpsdata[xaxis_name].length; i++) { 
    			cpscoors.push({'x': cpsdata[xaxis_name][i], 'y': cpsdata[yaxis_name][i]});
			};
			chartobj.config.data.datasets[0].data = tgtcoors;
			chartobj.config.options.scales.xAxes[0].scaleLabel.labelString = xaxis_name;
			chartobj.config.data.datasets[1].data = cpscoors;
			chartobj.config.options.scales.yAxes[0].scaleLabel.labelString = yaxis_name;
			chartobj.update();
		};

		window.onload = function() {
			var ctx = document.getElementById('%s').getContext('2d');
			window.myScatter = Chart.Scatter(ctx, {
				data: {
					datasets: [{label: 'Target Segments', borderColor: window.chartColors.red, backgroundColor: color(window.chartColors.red).alpha(0.2).rgbString(), data: []}, {label: 'Corpus Segments', borderColor: window.chartColors.blue, backgroundColor: color(window.chartColors.blue).alpha(0.2).rgbString(), data: []}]
				},
				options: {
					title: {
						display: true,
						text: '%s'
					},
					scales: {
						xAxes: [{
							scaleLabel: {
								display: true,
								labelString: ''
							}
						}],
						yAxes: [{
							scaleLabel: {
								display: true,
								labelString: ''
							}
						}]
					},
				}
			});
			pullValues(window.myScatter, "%s", "%s");
		};

		document.getElementById('%s-update').addEventListener('click', function() {
			var xaxis_name = document.getElementById('%s-xaxis').value;
			var yaxis_name = document.getElementById('%s-yaxis').value;
			pullValues(window.myScatter, xaxis_name, yaxis_name);
		});
	</script>'''%(id, id, html_xaxis_options, id, html_yaxis_options, id, tgtdata, cpsdata, id, name, axisdefaults[0], axisdefaults[1], id, id, id)
		self.chartcnt += 1


