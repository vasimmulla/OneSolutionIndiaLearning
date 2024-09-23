import { LightningElement,track } from 'lwc';
import getNasaImage from '@salesforce/apex/NasaCallout.getNasaImage';
export default class NasaImageDisplay_LWC extends LightningElement {
    @track result = '';

    connectedCallback(){

        getNasaImage().then(result => {
            this.fetchStatus();
        });
    }

    fetchStatus(){
        getNasaImage().then(response=>{
            //console.log(response);
            this.formatImageData(response);
        }).catch(error=>{
            console.log(error);
        })
    }

    formatImageData(res){
        this.result = JSON.parse(res); //COnvert String Data Into Javascript Object
        console.log(this.result);
    }

}