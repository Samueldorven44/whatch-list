import { application } from "./application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import SplideController from "./splide_controller"

application.register("splide", SplideController)
eagerLoadControllersFrom("controllers", application)
