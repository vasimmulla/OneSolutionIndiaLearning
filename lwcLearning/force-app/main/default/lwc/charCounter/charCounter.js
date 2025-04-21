import { LightningElement } from 'lwc';

export default class CharCounter extends LightningElement {
    charCount = 0;          // Current character count
    maxChars = 200;         // Max characters allowed

    // Class for dynamic styling
    get charCountClass() {
        return this.charCount >= this.maxChars 
            ? 'count-warning' 
            : 'count-normal';
    }

    // Event handler for input
    handleInput(event) {
        this.charCount = event.target.value.length;
    }
}
