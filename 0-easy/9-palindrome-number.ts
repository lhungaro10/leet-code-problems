const x = 10

function isPalindrome(x: number): boolean {
    if(x < 0) return false
    let leftToRight = x.toString()
    let inverseIndex = leftToRight.length -1
    for (let i = 0; i < leftToRight.length; i++) {
        console.log(leftToRight[i], ' -> ', leftToRight[inverseIndex]);
        if (leftToRight[i] !== leftToRight[inverseIndex]) return false
        inverseIndex -= 1
    }
    return true;  
};

export function execute(){
    console.log(isPalindrome(x) ? "É palindromo": "Não é palindromo");
}
