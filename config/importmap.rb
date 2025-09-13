# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "@splidejs/splide", to: "https://ga.jspm.io/npm:@splidejs/splide@4.1.4/dist/js/splide.min.js"
pin "controllers/splide_controller", to: "controllers/splide_controller.js"
pin "controllers/application", to: "controllers/application.js"
