import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css"
const initFlatpickr = () => {
  const dateForm = document.getElementById("depense-form-date");

 if (dateForm) {
  flatpickr("#input-date", {
  })
  }
};
export {initFlatpickr}
