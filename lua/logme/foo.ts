function truong() {
    
}

const TEST1 = () => {
    return "TEST"
}

const a: number = 2

export const test = () => {
    return "truong"
}

export const scheme = {
    title: 'truong dep trai',
    description: 'truong dep trai',
    required: 'truong dep trai',
    type: 'object',
    properties: {
        latitude: {
            type: 'number',
            minimum: -90,
            maximun: 90,
        },
        longitude: {
            type: 'number', 
            minimum:-180,
            maximun: 180
        }
    }
}
