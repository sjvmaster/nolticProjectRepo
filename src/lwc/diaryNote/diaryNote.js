/**
 * Created by Ivan.Sokolov on 14.12.2021.
 */

import {LightningElement, api} from 'lwc';

export default class DiaryNote extends LightningElement {
    @api diary;

    handleDeleteClick(){
        console.log('ID' + this.diary.Id);
        this.dispatchEvent(new CustomEvent("diarynotedeleted", {detail: this.diary.Id}))
    }
}