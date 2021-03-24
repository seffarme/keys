

const initRelance = () => {
  var relance = document.querySelector('.enveloppe-relance');
  console.log(relance);
  relance.addEventListener('click', (e) => {
    // e.innerHTML.remove('<i class="far fa-envelope-open" title="Faire une relance"></i>');
    // e.innerHTML.add('<i class="far fa-envelope" title="Faire une relance"></i>');
  });

};

export { initRelance };

