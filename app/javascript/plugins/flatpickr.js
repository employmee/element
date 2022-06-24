// app/javascript/plugins/flatpickr.js
import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr("#datepicker", {
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    static: true,
    minuteIncrement: 30
  });
}
console.log(initFlatpickr)
export { initFlatpickr };
