import { LightningElement, wire, track } from 'lwc';
import getStaticResources from '@salesforce/apex/StaticResourceController.getStaticResources';

export default class StaticResourceManager extends LightningElement {
    @track staticResources = [];
    @track error;

    columns = [
        {
            label: 'Name',
            fieldName: 'link',
            type: 'url',
            typeAttributes: {
                label: { fieldName: 'name' },
                target: '_blank',
            },
        },
        {
            label: 'Size (KB)',
            fieldName: 'size',
            type: 'number',
            cellAttributes: { alignment: 'left' },
        },
        {
            label: 'Type',
            fieldName: 'type',
            type: 'text',
        }
    ];

    @wire(getStaticResources)
    wiredStaticResources({ error, data }) {
        if (data) {
            const baseUrl = `${window.location.origin}/resource/`; // Direct link to file

            this.staticResources = data.map((res, index) => ({
                id: index + 1,
                name: res.name,
                link: `${baseUrl}${res.name}`, // Direct access to resource
                size: (res.size / 1024).toFixed(2),
                type: res.type,
            }));

            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.staticResources = undefined;
        }
    }
}
