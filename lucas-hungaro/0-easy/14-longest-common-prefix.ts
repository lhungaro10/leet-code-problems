//solved
// Problem 14: Longest commom prefix
const words = ["dog","racecar","car"]

function longestCommonPrefix(strs: string[]): string {
    let longestPrefix = strs[0]
    
    for(let i = 0; i< strs.length; i++ ){
      let tempPrefix = ""
      for(let j = 0; j < strs[i].length; j++){
        if (longestPrefix[j] === strs[i][j]) {
          tempPrefix = tempPrefix.concat(strs[i][j])
        } else {
          break;
        };
      }
      longestPrefix = tempPrefix;
    }
    return longestPrefix.length  > 0 ? longestPrefix : "";
};
export function execute(){
  console.log(longestCommonPrefix(words)) 
}