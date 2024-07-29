import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["qualifier", "day", "week", "month"];

  connect() {
    console.log(this.element);
    this.updateEndings();
  }
  
  updateEndings() {
    console.log("Chosen " + this.qualifierTarget.value);
    
    let qualifier = this.qualifierTarget.value;
    let showDays = qualifier.startsWith('the_') || qualifier === 'on'
    
    this.showDays(showDays);
    this.showWeek(!showDays)
    this.showMonth(qualifier !== 'on')
  }

  // Private
  showEnding(ending, show) {
    if(show) {
      ending.removeAttribute('disabled');
    } else {
      ending.setAttribute('disabled', 'disabled');
    }
  }
  
  showDays(show) {
    let day;
    for(day of this.dayTargets) {
      this.showEnding(day, show);
    }
  }

  showMonth(show) {
    this.showEnding(this.monthTarget, show)
  }

  showWeek(show) {
    this.showEnding(this.weekTarget, show)
  }

  
}
