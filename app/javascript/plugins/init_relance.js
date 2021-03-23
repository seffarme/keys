

const initRelance = () => {
  const relance = document.querySelector('#enveloppe-relance');
  console.log(relance);
  relance.addEventListener('click', (e) => {console.log('coucou')});

};

export { initRelance };