import sys, util


class htmloutput:
	def __init__(self,):
		self.htmlHead = '''<!doctype html>
	<title>AudioGuide Concatenation Log</title>
	<script src="http://www.chartjs.org/dist/2.7.0/Chart.bundle.js"></script>
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
		self.scriptvars = ''
		self.onload = ''
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
<script>
var color = Chart.helpers.color;
%s

  window.onload = function() {
%s
};
</script>
</body>
</html>'''%(self.htmlHead, self.htmlBody, self.scriptvars, self.onload))
		fh.close()


	def addchart(self, data, type='barchart', title='My Chart'):

		self.htmlBody +=  '''<div style="width:75%%">
	<canvas id="chart%i"></canvas>
</div>\n'''%(self.chartcnt)


		if type == 'barchart':
			datas = util.histogram(data)
			chartlabels = str([d[1] for d in datas])
			chartdata = str([d[0] for d in datas])
			self.scriptvars +=  '''
  var barChartData%i = {
		labels: %s,
		datasets: [{
			 backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
			 borderColor: window.chartColors.red,
			 borderWidth: 1,
			 data: %s,
		}]
  };'''%(self.chartcnt, chartlabels, chartdata)


			self.onload += '''	var Cfx%i = document.getElementById("chart%i").getContext("2d");
	window.myBar = new Chart(Cfx%i, {type: 'bar', data: barChartData%i, options: {responsive: true, title: {display: true, text: '%s'}}});\n\n'''%(self.chartcnt, self.chartcnt, self.chartcnt, self.chartcnt, title)




		elif type == 'normscatter':
			tgtData = [{'x': arr[0], 'y': arr[1]} for arr in data['tgt']]
			cpsData = [{'x': arr[0], 'y': arr[1]} for arr in data['cps']]

			self.scriptvars +=  '''
        var scatterChartData%i = {
            datasets: [{
                label: "Target Segments",
                borderColor: window.chartColors.red,
                backgroundColor: color(window.chartColors.red).alpha(0.2).rgbString(),
                data: %s
            }, {
                label: "Corpus Segments",
                borderColor: window.chartColors.blue,
                backgroundColor: color(window.chartColors.blue).alpha(0.2).rgbString(),
                data: %s
            }]
        };'''%(self.chartcnt, str(tgtData), str(cpsData))


			self.onload += '''
	var ctx%i = document.getElementById("chart%i").getContext("2d");
   window.myScatter = Chart.Scatter(ctx%i, {data: scatterChartData%i, options: {title: {display: true, text: '%s'},}});\n\n'''%(self.chartcnt, self.chartcnt, self.chartcnt, self.chartcnt, title)



	
		elif type == 'line':
			data = [1, 2, 3, 4, 3, 2, 1]
			self.scriptvars +=  '''
		var lineconfig%i = {
			type: 'bar',
			data: {
				labels: labels,
				datasets: [{
					label: "%s",
					data: %s,
					type: 'line',
					pointRadius: 0,
					fill: false,
					lineTension: 0,
					borderWidth: 2
				}]
			},
			options: {
				scales: {
					xAxes: [{
						type: 'time',
						distribution: 'series',
						ticks: {
							source: 'labels'
						}
					}],
					yAxes: [{
						scaleLabel: {
							display: true,
							labelString: 'Amplitude'
						}
					}]
				}
			}
		};\n'''%(self.chartcnt, title, str(data))
		
	
			#self.onload += '''window.myBar = new Chart(document.getElementById("chart%i").getContext("2d"), lineconfig%i);\n\n'''%(self.chartcnt, self.chartcnt)
	
	
	


		self.chartcnt += 1

