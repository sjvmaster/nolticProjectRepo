/**
 * Created by Ivan.Sokolov on 14.12.2021.
 */

import {api, LightningElement, wire} from 'lwc';
import {refreshApex} from "@salesforce/apex";
import {deleteRecord} from "lightning/uiRecordApi";
import getDiaryNotesByContactId from "@salesforce/apex/DiaryController.getDiaryNotesByContactId"
import addDiaryNote from "@salesforce/apex/DiaryController.addDiaryNote"


export default class Diary extends LightningElement {
    @api recordId;
    note;

    @wire(getDiaryNotesByContactId, {contactId: '$recordId'})
    diaryNotes;

    handleNoteChange(event) {
        this.note = event.target.value;
    }

    handleDiaryNoteDeleted(event){
        console.log('caught event' + event.detail)
        deleteRecord(event.detail)
            .then(result => {
                console.log('deleted record' + event.detail);
                refreshApex(this.diaryNotes)
                    .catch(error => console.log(error))})
            .catch(error => console.log(error));
    }

    addDiaryNote(){
        addDiaryNote({
            contactId: this.recordId,
            note: this.note})
            .then(result => {
                this.template.querySelector('lightning-input[data-id="clear"]').value = null;
                refreshApex(this.diaryNotes)
                    .catch(error => console.log(error));
            })
            .catch(error => console.log(error));
    }

}