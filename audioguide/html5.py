def makeHtml5ScatterChart(targetvalues, corpusvalues, tgtpowers):
	fh = open('/Users/ben/Documents/audioguide/output/output.html', 'w')
	fh.write('''
<!doctype html>
<html>
<head>
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
</head>

<body>
	<p>ben ben ben</p>
	<div style="width:75%">
		<canvas id="tgtamplitude"></canvas>
	</div>
	<p>ben ben ben</p>
	<div style="width:75%">
		<canvas id="canvas"></canvas>
	</div>



	<script>
	var color = Chart.helpers.color;
	var scatterChartData = {
		datasets: [{
			label: "Target Segments",
			xAxisID: "x-axis-1",
			yAxisID: "y-axis-1",
			borderColor: window.chartColors.red,
			backgroundColor: color(window.chartColors.red).alpha(0.2).rgbString(),
			data: '''+str(targetvalues)+'''
		}, {
			label: "Corpus Segments",
			xAxisID: "x-axis-1",
			yAxisID: "y-axis-2",
			borderColor: window.chartColors.blue,
			backgroundColor: color(window.chartColors.blue).alpha(0.2).rgbString(),
			data: '''+str(corpusvalues)+'''
		}]
	};

	window.onload = function() {
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myScatter = Chart.Scatter(ctx, {
			data: scatterChartData,
			options: {
				responsive: true,
				hoverMode: 'nearest',
				intersect: true,
				title: {
					display: true,
					text: 'Segment Normalization'
				},
				scales: {
					xAxes: [{
						position: "bottom",
						gridLines: {
							zeroLineColor: "rgba(0,0,0,1)"
						}
					}],
					yAxes: [{
						type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
						display: true,
						position: "left",
						id: "y-axis-1",
					}, {
						type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
						display: true,
						position: "right",
						reverse: true,
						id: "y-axis-2",

						// grid line settings
						gridLines: {
							drawOnChartArea: false, // only want the grid lines for one axis to show up
						},
					}],
				}
			}
		});



	
   var config = {
		type: 'line',
		data: {
			 labels: '''+str(range(len(list(tgtpowers))))+''',
			 datasets: [{
				  backgroundColor: window.chartColors.black,
				  borderColor: window.chartColors.blue,
				  data: '''+str(list(tgtpowers))+''',
				  fill: true,
			 }]
		},
		options: {
			 responsive: true,
			 title:{
				  display:true,
				  text:'Target Amplitude'
			 },
			 tooltips: {
				  mode: 'index',
				  intersect: false,
			 },
			 hover: {
				  mode: 'nearest',
				  intersect: true
			 },

			 elements: {
				  point: {
						radius: 0
					},
			 },


			 scales: {
				  xAxes: [{
						display: true,
						scaleLabel: {
							 display: true,
							 labelString: 'Time in Seconds'
						}
				  }],
				  yAxes: [{
						display: true,
						scaleLabel: {
							 display: true,
							 labelString: 'Amplitude'
						}
				  }]
			 }
		}
  };


  var ctx = document.getElementById("tgtamplitude").getContext("2d");
  window.myLine = new Chart(ctx, config);
  };

	</script>
</body>
</html>''')
	fh.close()

import random
targetvalues = [{'x': random.random(), 'y': random.random()} for i in range(20)]
corpusvalues = [{'x': random.random(), 'y': random.random()} for i in range(20)]
makeHtml5ScatterChart(targetvalues, corpusvalues, [0, 1, 2, 3, 4,3, 2, 1, ])