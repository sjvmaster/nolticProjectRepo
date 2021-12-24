/**
 * Created by Ivan.Sokolov on 07.12.2021.
 */

import {LightningElement, api, track} from 'lwc';

export default class Contact extends LightningElement {
    contactData;
    @track contactFields = [];
    get contact(){
        return this.contactData;
    }
    @api
    set contact(value){
        this.contactData = value;
        for(const [field, field_value] of Object.entries(value)){
            if (field != 'Id') {
                this.contactFields.push({'field': field, 'field_value': field_value});
            }
        }
    }



}