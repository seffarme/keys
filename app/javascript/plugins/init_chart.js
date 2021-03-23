import Chart from "chart.js";

const initChartCourbe = () => {
  const ctx = document.getElementById("myChartCourbe");

  if (ctx) {

  const deuxd = ctx.getContext('2d');
    // data = document.querySelector('#depense')

    const depensesDiv = document.querySelector('#depenses')
    const depensesValue =JSON.parse(depensesDiv.dataset.depenses)

    const monthsDisplay = JSON.parse(depensesDiv.dataset.months)

    const cashFlowCourbe = JSON.parse(depensesDiv.dataset.courbe)

    const myChart = new Chart(deuxd, {
      type: "bar",
      data: {
        datasets: [
          {
            label: "CF/mois",
            data: depensesValue,
            backgroundColor: [
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(54, 162, 235, 0.2)",
            ],
            borderColor: [
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(54, 162, 235, 1)",
            ],
            borderWidth: 1,
          },
          {
            label: "CF Cumulé",
            data: cashFlowCourbe,

            // Changes this dataset to become a line
            type: "line",
            backgroundColor: [
              "rgba(255, 99, 132, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(255, 206, 86, 0.2)",
              "rgba(75, 192, 192, 0.2)",
              "rgba(153, 102, 255, 0.2)",
              "rgba(255, 159, 64, 0.2)",
            ],
            borderColor: [
              "rgba(255, 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
              "rgba(75, 192, 192, 1)",
              "rgba(153, 102, 255, 1)",
              "rgba(255, 159, 64, 1)",
            ],
            borderWidth: 1,
            pointStyle: "line",
          },
        ],
        labels: monthsDisplay,
      },
      options: {
        legend: {
          display: true,
          labels: {
            fontColor: "rgb(255, 99, 132)",
            fontSize: 20,
          },
        },
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: false,
                padding: 4,
                fontSize: 10,
                callback: function(value, index, values) {
                  return value + " €";
                },
              },
            },
          ],
        },
        legend: {
          display: true,
          position: "top",
          labels: {
            useLineStyle: true,
            usePointStyle: true,
          },
        },
        title: {
          display: true,
          text: "Cash-Flow Mensuel",
        },
      },

    });
  }
};

// jQuery(function(){
  const initChartBiens = () => {
    const ctx = document.getElementById("myChartBiens");

    if (ctx) {
      const cfbien = document.querySelector("#cfbien");
      const cfbienValue = JSON.parse(cfbien.dataset.cfbien);
      const labelValue = JSON.parse(cfbien.dataset.label);
      const bienId = JSON.parse(cfbien.dataset.bienId);

      const deuxd = ctx.getContext("2d");

      const myChart = new Chart(deuxd, {
        type: "bar",
        data: {
          labels: labelValue,
          datasets: [
            {
              label: "",
              data: cfbienValue,

              backgroundColor: [
             'rgba(54, 162, 235, 0.2)',
             'rgba(54, 162, 235, 0.2)',
             'rgba(54, 162, 235, 0.2)',
             'rgba(54, 162, 235, 0.2)',
             'rgba(54, 162, 235, 0.2)',
             'rgba(54, 162, 235, 0.2)',
              ],
              borderColor: [
                "rgba(54, 162, 235, 1)",
                "rgba(54, 162, 235, 1)",
                "rgba(54, 162, 235, 1)",
                "rgba(54, 162, 235, 1)",
                "rgba(54, 162, 235, 1)",
                "rgba(54, 162, 235, 1)",
              ],
              borderWidth: 1,
            },
          ],
        },
        options: {
  				legend: {
  					display: false,
  					labels: {
  							fontColor: 'rgb(255, 99, 132)',
  							fontSize: 20,
  					}
  				},
  				scales: {
              yAxes: [{
                ticks: {
                // type: 'logarithmic'
                  suggestedMin: -5000,
                  suggestedMax: 5000,
                  padding: 4,
                  callback: function(value, index, values) {
                          return value + ' €';
                      },
                }
              }],
              xAxes: [{
                    ticks: {

                        padding: 4,
                        fontSize: 10
                    }
                }]
        },
        // legend: {
        //       display: true,
        //       position: 'bottom',
        //       labels: {
        //           useLineStyle: true,
        //           usePointStyle: true
        //       }
        //   },
          title: {
            display: true,
            text: "Résultat depuis Achat",
          },
        },
      });

      ctx.addEventListener('click', (event) => {
        console.log(event)
        const activepoints = myChart.getElementsAtEvent(event);
        console.log(activepoints)
        if(activepoints.length > 0){
          const clickedIndex = activepoints[0]["_index"];

          const clickedId = bienId[clickedIndex]
          console.log(clickedId)

          window.location.href = `http://localhost:3000/biens/${clickedId}`
        }
      });
    }
  };



//   $("#myChartBiens").click(
//           function(event){
//               var activepoints = myChart.getElementsAtEvent(event);
//               if(activepoints.length > 0){
//                 alert("yes!")
//                   //get the index of the slice
//                  // var clickedIndex = activepoints[0]["_index"];

//                  // var socialMedia = myChart.data.labels[clickedIndex];

//                  // var users = myChart.data.datasets[0].data[clickedIndex];

//                  // window.location.href = "file:///C:/Users/barbi/Desktop/Chartjs-demo/clickable-charts/chart2.html?socialmedia=" + socialMedia + "&users=" + users

//               }
//               else{
//                 alert("no!")
//               }
//           }
//       )
// })

const initChartCourbeBien = () => {

  const ctx = document.getElementById('myChartCourbeBien')

  if (ctx ) {
  const deuxd = ctx.getContext('2d');
    // data = document.querySelector('#depense')

		Chart.defaults.global.defaultFontSize=18;
    const cfbm = document.querySelector('#cfbm')
    const cfbmValue =JSON.parse(cfbm.dataset.cfb)
    const monthsDisplay = JSON.parse(cfbm.dataset.months)
    const cashFlowCourbe = JSON.parse(cfbm.dataset.courbe)

    const myChart = new Chart(deuxd, {
      type: 'bar',
      data: {
        datasets: [{
            label: 'CashFlow',
            data: cfbmValue,
            backgroundColor: [
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(54, 162, 235, 0.2)'
              ],
              borderColor: [
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(54, 162, 235, 1)'
              ],
              borderWidth: 1
        }, {
            label: 'Line CashFlow',
            data: cashFlowCourbe,

            // Changes this dataset to become a line
            type: 'line',
            backgroundColor: [
                  'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)',
                  'rgba(153, 102, 255, 0.2)',
                  'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  'rgba(255, 99, 132, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)',
                  'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              pointStyle: 'line'
        }],
        labels: monthsDisplay,
      },
      options: {
          legend: {
            display: true,
            labels: {
                fontColor: 'rgb(255, 99, 132)',
            }
          },
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: false,
                      padding: 4,
                      callback: function(value, index, values) {
                        return value + ' €';
                    }
                  }
              }]
          },
          legend: {
            display: true,
            position: 'top',
            labels: {
                useLineStyle: true,
                usePointStyle: true
            }
        },
      }
    });
  }
};

export { initChartCourbe, initChartBiens, initChartCourbeBien };
