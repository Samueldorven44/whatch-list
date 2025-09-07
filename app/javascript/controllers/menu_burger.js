import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const connexion = document.querySelector(".connexion-btn-event");
    connexion.addEventListener("click", (event) => {
      console.log("✅ Clic détecté !");
    });
  }
}
