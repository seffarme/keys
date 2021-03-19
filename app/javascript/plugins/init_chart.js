import Chart from 'chart.js';

const initChartCourbe = () => {

  const ctx = document.getElementById('myChartCourbe').getContext('2d');

  if (ctx) {

    // data = document.querySelector('#depense')

    const myChart = new Chart(ctx, {
      type: 'bar',
      data: {
        datasets: [{
            label: 'Bar CashFlow',
            data: [10, 20, 30, 40]
        }, {
            label: 'Line CashFlow',
            data: [10, 17, 40, 50],

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
              borderWidth: 1
        }],
        labels: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre']
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
                      fontSize: 25
                  }
              }],
							xAxes: [{
								ticks: {
										beginAtZero: false,
										padding: 4,
										fontSize: 25
								}
						}]
          },
        responsive: true,
        maintainAspectRatio: false,
				aspectRatio: 2,
				onResize: null
      }
    });
  }
};
console.log('toto')
const initChartBiens = () => {

  const ctx = document.getElementById('myChartBiens').getContext('2d');

  if (ctx) {

    // data = document.querySelector('#depense')

    const myChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
          datasets: [{
              label: '# of Votes',
              data: [12, 19, 7, 5, 2, 15,0],
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
              borderWidth: 1
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
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: false,
											padding: 4,
											fontSize: 25
                  }
              }],
							xAxes: [{
									ticks: {
											beginAtZero: false,
											padding: 4,
											fontSize: 40
									}
							}]
          },
        responsive: true,
        maintainAspectRatio: false,
				aspectRatio: 2,
				onResize: null
      }
  	}
	});
  }
};
export { initChartCourbe, initChartBiens };
