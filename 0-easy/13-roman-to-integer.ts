const s = "III";
type RomansSymbolsType ={
    [key:string]: number
}

const romansSymbolsMap:RomansSymbolsType = {
    'I':1,
    'V':5,
    'X':10,
    'L':50,
    'C':100,
    'D':500,
    'M':1000
}

function romanToInt(romanNumber: string): number {
    let total = 0;
    const romanArray = romanNumber.split('');
    for(let i = 0; i < romanArray.length ; i++){
        if (romansSymbolsMap[romanArray[i]] < romansSymbolsMap[romanArray[i+1]]) {
            total += (romansSymbolsMap[romanArray[i+1]] - romansSymbolsMap[romanArray[i]])
            i++;
        }else {
            total+= romansSymbolsMap[romanArray[i]]
        }
    }
    return total;
};

export function execute(){
    romanToInt(s)
}
 