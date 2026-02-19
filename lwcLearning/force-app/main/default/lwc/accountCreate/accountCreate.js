import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import createAccount from '@salesforce/apex/AccountController.createAccount';
import { refreshApex } from '@salesforce/apex';

export default class AccountCreate extends LightningElement {
        @track accounts;
        wiredAccountResult; // store wired result
        
        @wire(getAccounts)
        wiredAccounts(result) {
            this.wiredAccountResult = result;
            if (result.data) {
                this.accounts = result.data;
            } else if (result.error) {
                console.error(result.error);
            }
        }
        handleCreate() {
            createAccount({ accName: 'New LWC Account' })
            .then(() => {
            return refreshApex(this.wiredAccountResult);
        })
        .catch(error => {
        console.error(error);
        });
    }
}