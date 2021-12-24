/**
 * Created by Ivan.Sokolov on 02.12.2021.
 */

import {LightningElement} from 'lwc';

export default class LeadProduct extends LightningElement {
    get isProducts(){
        return this.products && this.products.length > 0; 
    }
    products = [
        {
            Id: 1,
            Brand: 'BMW',
            Color: 'White',
            Price: 10000,
        },
        {
            Id: 2,
            Brand: 'Audi',
            Color: 'Black',
            Price: 20000,
        },
        {
            Id: 3,
            Brand: 'Opel',
            Color: 'Red',
        },
    ]
}