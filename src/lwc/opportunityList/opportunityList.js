/**
 * Created by Ivan.Sokolov on 07.12.2021.
 */

import {LightningElement, api, wire} from 'lwc';
import getOpportunitiesByAccountId from '@salesforce/apex/OpportunityController.getOpportunitiesByAccountId';
import addOpportunity from '@salesforce/apex/OpportunityController.addOpportunity';

export default class OpportunityList extends LightningElement {
    @api recordId;
    showOpportunityForm = false;
    name;
    @wire(getOpportunitiesByAccountId, {accountId: '$recordId'}) opportunities;

    addOpportunity(){
        this.showOpportunityForm = !this.showOpportunityForm;
    }

    handleNameChange(event) {
        this.name = event.target.value;
    }

    createOpportunity(){
        addOpportunity({accountId: this.recordId, name: this.name})
            .then(result => console.log('Opportunity created'))
            .catch(error => console.log(error));
    }

}