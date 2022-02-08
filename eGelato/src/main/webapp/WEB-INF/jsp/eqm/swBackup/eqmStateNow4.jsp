<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>실시간 설비 상태(온도/UPH/생산량)</title>
<script src="https://d3js.org/d3.v7.min.js"></script>
</head>
<body>

<br>
<h2>모니터링 관리</h2>
<br>

<div class="col-sm-6">
	<div id="tempChart"></div>
</div>

<div class="col-sm-6">
	
</div>

<script>
//line-chart.js
const width = 500;
const height = 500;
const margin = {top: 40, right: 40, bottom: 40, left: 40};
const data = [
  {date: new Date('2018-01-01'), value: 10},
  {date: new Date('2018-01-02'), value: 20},
  {date: new Date('2018-01-03'), value: 30},
  {date: new Date('2018-01-04'), value: 25},
  {date: new Date('2018-01-05'), value: 35},
  {date: new Date('2018-01-06'), value: 45},
  {date: new Date('2018-01-07'), value: 60},
  {date: new Date('2018-01-08'), value: 50}
];
 
const x = d3.scaleTime()
  .domain(d3.extent(data, d => d.date))
  .range([margin.left, width - margin.right]);
 
const y = d3.scaleLinear()
  .domain([0, d3.max(data, d => d.value)]).nice()
  .range([height - margin.bottom, margin.top]);
 
const xAxis = g => g
  .attr("transform", `translate(0,${height - margin.bottom})`)
  .call(d3.axisBottom(x).ticks(width / 90).tickSizeOuter(0));
 
const yAxis = g => g
  .attr("transform", `translate(${margin.left},0)`)
  .call(d3.axisLeft(y))
  .call(g => g.select(".domain").remove())
  .call(g => {
    return g.select(".tick:last-of-type text").clone()
      .attr("x", 3)
      .attr("text-anchor", "start")
      .attr("font-weight", "bold")
      .attr("font-size", '20px')
      .text('Y축')
    });
 
const line = d3.line()
  .defined(d => !isNaN(d.value))
  .x(d => x(d.date))
  .y(d => y(d.value));
 
const svg = d3.select('body').append('svg').style('width', width).style('height', height);
svg.append("path")
  .datum(data)
  .attr("fill", "none")
  .attr("stroke", "steelblue")
  .attr("stroke-width", 1)
  .attr("stroke-linejoin", "round")
  .attr("stroke-linecap", "round")
  .attr("d", line);
svg.append('g').call(xAxis);
svg.append('g').call(yAxis);
svg.node();

//-----------------------------------

/* //set the dimensions and margins of the graph
const margin = {top: 10, right: 30, bottom: 30, left: 60},
    width = 460 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;

// append the svg object to the body of the page
const svg = d3.select("#tempChart")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", `translate(${margin.left},${margin.top})`);
    
$.ajax({
	url : "${path}/eqm/findEqmTemp.do",
	dataType : 'json',
	method : 'GET',
	error : function(result){
		console.log('에러',result)
	}
}).done(function (result){
	//result.data.contents
	// group the data: I want to draw one line per group
  const sumstat = d3.group(data, d => d.name); // nest function allows to group the calculation per level of a factor

  // Add X axis --> it is a date format
  const x = d3.scaleLinear()
    .domain(d3.extent(data, function(d) { return d.year; }))
    .range([ 0, width ]);
  svg.append("g")
    .attr("transform", `translate(0, ${height})`)
    .call(d3.axisBottom(x).ticks(5));

  // Add Y axis
  const y = d3.scaleLinear()
    .domain([0, d3.max(data, function(d) { return +d.n; })])
    .range([ height, 0 ]);
  svg.append("g")
    .call(d3.axisLeft(y));

  // color palette
  const color = d3.scaleOrdinal()
    .range(['#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#ffff33','#a65628','#f781bf','#999999'])

  // Draw the line
  svg.selectAll(".line")
      .data(sumstat)
      .join("path")
        .attr("fill", "none")
        .attr("stroke", function(d){ return color(d[0]) })
        .attr("stroke-width", 1.5)
        .attr("d", function(d){
          return d3.line()
            .x(function(d) { return x(d.year); })
            .y(function(d) { return y(+d.n); })
            (d[1])
        })
}) */




/* //Read the data
d3.csv("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/5_OneCatSevNumOrdered.csv").then( function(data) {
}) */
	
</script>

</body>
</html>