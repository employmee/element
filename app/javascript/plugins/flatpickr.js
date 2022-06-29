// app/javascript/plugins/flatpickr.js
import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".timepicker", {
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    //time_24hr: true,
    minuteIncrement: 30
  });
  flatpickr(".datepicker", {
    enableTime: true,
    minuteIncrement: 30
  });
}
console.log(initFlatpickr)
export { initFlatpickr };
