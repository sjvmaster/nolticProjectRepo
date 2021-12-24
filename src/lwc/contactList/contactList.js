/**
 * Created by Ivan.Sokolov on 07.12.2021.
 */

import {LightningElement} from 'lwc';

export default class ContactList extends LightningElement {
    contacts = [
        {
            'Id': 0,
            'Name': 'NoName 1',
            'Address': 'Address 1',
        },
        {
            'Id': 1,
            'Name': 'NoName 2',
            'Address': 'Address 2',
            'PhoneNumber': '+380961234567'
        },

        {
            'Id': 2,
            'Name': 'NoName 3',
            'Address': 'Address 3',
            'Description': 'Test description for item 3'
        }
    ];
}