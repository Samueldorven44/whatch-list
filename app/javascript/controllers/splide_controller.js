import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if (typeof Splide !== 'undefined') {
      new Splide(this.element, {
        type: 'loop',
        padding: '5rem',
        gap: '20px',
      }).mount();
    } else {
      console.error("❌ Splide is not defined. Make sure the CDN script is loaded correctly.");
    }
  }
}
