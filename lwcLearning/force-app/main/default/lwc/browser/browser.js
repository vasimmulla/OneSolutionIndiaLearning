import { LightningElement, track } from 'lwc';

export default class Browser extends LightningElement {
    @track url = 'https://www.example.com';

    handleUrlChange(event) {
        this.url = event.target.value;
    }
}