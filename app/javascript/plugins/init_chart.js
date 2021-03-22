import Chart from 'chart.js';

const initChartCourbe = () => {

  const ctx = document.getElementById('myChartCourbe')



    const depensesDiv = document.querySelector('#depenses')
    const depensesValue =JSON.parse(depensesDiv.dataset.depenses)

    const monthsDisplay = JSON.parse(depensesDiv.dataset.months)
    console.log(monthsDisplay);

    const cashFlowCourbe = JSON.parse(depensesDiv.dataset.courbe)
    console.log(cashFlowCourbe);

  if (ctx) {
  const deuxd = ctx.getContext('2d');
    // data = document.querySelector('#depense')


    const myChart = new Chart(deuxd, {
      type: 'bar',
      data: {
        datasets: [{
            label: 'CashFlow',
            data: depensesValue,
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
								fontSize: 20,
						}
					},
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: false,
                      padding: 4,

                      fontSize: 10,
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
        // responsive: true,
        // maintainAspectRatio: false

      }
    });
  }
};

const initChartBiens = () => {

  const ctx = document.getElementById('myChartBiens')

  if (ctx) {


    const cfbien = document.querySelector('#cfbien')
    const cfbienValue = JSON.parse(cfbien.dataset.cfbien)
    console.log(cfbienValue);
    const labelValue = JSON.parse(cfbien.dataset.label)
    console.log(labelValue);

    const deuxd = ctx.getContext('2d');
    // data = document.querySelector('#depense')


    const myChart = new Chart(deuxd, {
      type: 'bar',
      data: {
          labels: labelValue,
          datasets: [{

              label: 'CashFlow',
              data: cfbienValue,

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
              pointStyle: 'rect'
          }]
      },
      options: {
				legend: {
					display: true,
					labels: {
							fontColor: 'rgb(255, 99, 132)',
							fontSize: 20
					}
				},
				scales: {
            yAxes: [{
              ticks: {
              // type: 'logarithmic'
                min: -500000,
                max: 5000,
                padding: 4,
                fontSize: 10,
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
export { initChartCourbe, initChartBiens };
