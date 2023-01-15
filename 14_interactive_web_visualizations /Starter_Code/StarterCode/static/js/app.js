var data = {};


d3.json("./samples.json").then(function(temp_data){
    console.log(temp_data);
    data = temp_data

    makeDropDown();
    makeBar("940");
    createMeta("940");
    createBub("940");
});

function makeDropDown(){
    for (let i = 0; i < data.names.length; i++){
        let name = data.names[i];
        d3.select("#selDataset").append("option").text(name);
    }
}

function optionChanged(val) {
    makeBar(val);
    createMeta(val);
    createBub(val);
}

function makeBar(val) {
    let fresh_data = data.samples.filter(x => x.id === val)[0];

    var trace1 = {
        x: fresh_data.sample_values.slice(0,10).reverse(),
        y: fresh_data.otu_ids.slice(0,10).reverse().map(x => `OTU ID: ${x}`),
        name: 'Bacteria',
        type: 'bar',
        orientation: "h",
        hovertext:fresh_data.otu_labels
      };
      
      let trace = [trace1];
      
      let layout = {title: 'Bacteria'};
      
      Plotly.newPlot('bar', trace, layout);

}


function createMeta(val) {
    let fresh_data = data.metadata.filter(x => x.id == val)[0];
    d3.select("#sample-metadata").html("");
    Object.entries(fresh_data).forEach(function (key) {
      d3.select("#sample-metadata").append("h6").text(`${key[0]}: ${key[1]}`);
    });
}

function createBub(val) {
    let fresh_data = data.samples.filter(x => x.id === val)[0];

    var trace1 = {
        x: fresh_data.otu_ids,
        y: fresh_data.sample_values,
        name: 'Bacteria',
        mode: "markers",
        marker: {
            color: fresh_data.otu_ids,
            size: fresh_data.sample_values
        },
        hovertext:fresh_data.otu_labels
      };
      
      let trace = [trace1];
      
      let layout = {title: 'Bacteria'};
      
      Plotly.newPlot("bubble", trace, layout);

}
  
