import { LightningElement } from 'lwc';

export default class SalesPrediction extends LightningElement {
    marketingSpend;
    predictedSales = null;

    valueNull = false;

    // Example historical data: [Marketing Spend, Sales]
    historicalData = [
        { spend:10000, sales: 50000 },
        { spend:12000, sales: 55000 },
        { spend:15000, sales: 60000 },
        { spend:11000, sales: 52000 },
        { spend:14000, sales: 58000 },
        { spend:13000, sales: 57000 },
        { spend:16000, sales: 62000 },
        { spend:18000, sales: 65000 },
        { spend:17000, sales: 63000 },
        { spend:19000, sales: 68000 },
        { spend:20000, sales: 70000 },
        { spend:22000, sales: 75000 }

    ];

    slope = 0;
    intercept = 0;

    connectedCallback() {
        // Calculate the slope and intercept for linear regression
        this.calculateRegression();
        this.predictedSales = null;
    }

    handleInputChange(event) {
        this.marketingSpend = parseFloat(event.target.value);
        if (!this.marketingSpend) {
            this.predictedSales = null;
        }
    }

    // Method to calculate the slope and intercept for the regression line
    calculateRegression() {
        const n = this.historicalData.length;
        let sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;

        // Summing up all the necessary values for regression formula
        this.historicalData.forEach(({ spend, sales }) => {
            sumX += spend;
            sumY += sales;
            sumXY += spend * sales;
            sumX2 += spend * spend;
        });

        // Calculate slope (m)
        this.slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);

        // Calculate intercept (b)
        this.intercept = (sumY - this.slope * sumX) / n;

        console.log('Slope (m):', this.slope);
        console.log('Intercept (b):', this.intercept);
    }

    // Method to predict sales based on the linear regression model
    predictSales() {
        if (!isNaN(this.marketingSpend)) {
            this.valueNull = false
            this.predictedSales = (this.slope * this.marketingSpend + this.intercept).toFixed(2);
            console.log('Predicted Sales:', this.predictedSales);
        } else {
            this.predictedSales = null;
            this.valueNull  = true;
        }
    }
}
