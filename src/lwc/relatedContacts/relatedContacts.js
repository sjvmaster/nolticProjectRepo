/**
 * Created by Ivan.Sokolov on 11.12.2021.
 */

import {LightningElement, api, wire} from 'lwc';
import {refreshApex} from "@salesforce/apex";
import getContactsByAccountId from '@salesforce/apex/ContactController.getContactsByAccountId';
import addContact from '@salesforce/apex/ContactController.addContact';

export default class RelatedContacts extends LightningElement {
    @api recordId;
    showContactForm = false;
    lastName;

    @wire(getContactsByAccountId, {accountId: '$recordId'})
    contacts;

    addContact(){
        this.showContactForm = !this.showContactForm;
    }

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    createContact(){
        addContact({accountId: this.recordId, lastName: this.lastName})
            .then(result => {
                console.log('Contact created');
                refreshApex(this.contacts)
                    .catch(error => console.log(error));
            })
            .catch(error => console.log(error));
    }
}