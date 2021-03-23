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
              "rgba(255, 159, 64, 0.2)",
              "rgba(75, 192, 192, 0.2)",
              "rgba(255, 99, 132, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(255, 206, 86, 0.2)",
              "rgba(153, 102, 255, 0.2)",
            ],
            borderColor: [
              "rgba(255, 159, 64, 1)",
              "rgba(75, 192, 192, 1)",
              "rgba(255, 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
              "rgba(153, 102, 255, 1)",
            ],
            borderWidth: 1,
            pointStyle: "line",
          },
        ],
        labels: monthsDisplay,
      },
      options: {
        scales: {
          yAxes: [{
            gridLines: {
             lineWidth: 0
            },
            ticks: {
              beginAtZero: false,
              padding: 4,
              fontSize: 10,
              userCallback: function(value, index, values) {
                value = value.toString();
                value = value.split(/(?=(?:...)*$)/);
                value = value.join(' ');
                return   value + ' €';
              }
            },
          }],
            xAxes: [{
              gridLines: {
                  lineWidth: 0
                },
              ticks: {
                  padding: 4,
                  fontSize: 12,
              }
            }]
        },
        legend: {
          display: true,
          position: "bottom",
          labels: {
            useLineStyle: true,
            usePointStyle: true,
            fontSize: 13,


          },
        },
        title: {
          display: true,
          text: "Cash-Flow Mensuel",
          fontSize: 20,
          padding: 15,
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
              label: "CashFlow",
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
  				scales: {
              yAxes: [{
                gridLines: {
                  lineWidth: 0
                },
                ticks: {
                // type: 'logarithmic'
                  suggestedMin: -5000,
                  suggestedMax: 5000,
                  padding: 4,
                  fontSize: 10,
                  // stepSize: 30000,
                  userCallback: function(value, index, values) {
                    value = value.toString();
                    value = value.split(/(?=(?:...)*$)/);
                    value = value.join(' ');
                    return   value + ' €';
                  }
                }
              }],
              xAxes: [{
                gridLines: {
                  lineWidth: 0
                },
                    ticks: {
                      padding: 4,
                      fontSize: 10
                    }
                }]
        },
        legend: {
              display: true,
              position: 'bottom',
              labels: {
                  useLineStyle: true,
                  usePointStyle: true,
                  fontSize: 13,
              }
          },
          title: {
            display: true,
            text: "Résultat net depuis achat",
            fontSize: 20,
            padding: 15,
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
              borderWidth: 1,
        }, {
            label: 'Line CashFlow',
            data: cashFlowCourbe,

            // Changes this dataset to become a line
            type: 'line',
            backgroundColor: [
                  'rgba(255, 159, 64, 0.2)',
                  'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)',
                  'rgba(153, 102, 255, 0.2)',
              ],
              borderColor: [
                  'rgba(255, 159, 64, 1)',
                  'rgba(255, 99, 132, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)',
                  'rgba(153, 102, 255, 1)',
              ],
              borderWidth: 1,
              pointStyle: 'line'
        }],
        labels: monthsDisplay,
      },
      options: {

          scales: {
              yAxes: [{
                gridLines: {
                  lineWidth: 0
                },
                ticks: {
                  beginAtZero: false,
                  padding: 4,
                  fontSize: 12,
                  stepSize: 5000,
                  userCallback: function(value, index, values) {
                    value = value.toString();
                    value = value.split(/(?=(?:...)*$)/);
                    value = value.join(' ');
                    return   value + ' €';
                  }
                }
              }],
                xAxes: [{
                  gridLines: {
                  lineWidth: 0
                },
              ticks: {
                  padding: 4,
                  fontSize: 12,
              }
            }]
          },
          legend: {
            display: true,
            position: 'bottom',
            fontSize: 20,
            labels: {
                useLineStyle: true,
                usePointStyle: true,
                fontSize: 13,
                // offsetGridLines: false,

            }
        },
        title: {
            display: true,
            text: "Cash-Flow Mensuel",
            fontSize: 20,
            padding: 15,
        },
      }
    });
  }
};

export { initChartCourbe, initChartBiens, initChartCourbeBien };
