import { Controller } from "@hotwired/stimulus"
import Splide from "@splidejs/splide"

// Connects to data-controller="splide"
export default class extends Controller {
  connect() {
    var splide = new Splide('.splide', {
      type: 'loop',
      padding: '5rem',
      gap: '1.5rem'
    });

    splide.mount();
  }
}
