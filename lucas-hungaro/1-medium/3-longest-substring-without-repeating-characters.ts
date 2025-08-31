// Problem 3: Longest Substring Without Repeating Characters
/*
  constraints
    - 0 <= s.length <= 5 * 104
    - s consists of English letters, digits, symbols and spaces.
*/

function lengthOfLongestSubstring(s: string): number {
  let begin = 0;
  let end = 0;
  let maxlength = 0;
  let isWindowActive = false
  let currentMaxLength = 0;
  
  
  if(s.length < 1){
    return 0
  }
  
  // percorrer a string, verificando:
  for(let i= 0; i < s.length; i++){
    // console.debug("MaxLength: ", maxlength)
    // console.debug("CurrentMaxLength: ", currentMaxLength)
    console.debug(`=== ${i} ===`)
    console.debug("s.slice(begin, end+1) :", !s.substring(begin, end+1).includes(s[i]))
    console.debug("isWindowActive: ", isWindowActive)
    console.debug("begin: ", begin)
    console.debug("end: ", end)
    let interval = s.substring(begin, end +1)
    if(interval.length > 0 && interval.includes(s[i])){
      if(isWindowActive){
        //se a Janela está ativa 
        end = i
      } else {
        //se a Janela não está ativa 
        begin = i
        end = i
        isWindowActive = true
      }
    } else {
      console.debug("isWindowActive: ",isWindowActive)
      // senão (caso a letra anterior for igual a atual)
      if(isWindowActive){
        //se a Janela está ativa 
        currentMaxLength =  end - begin + 1
        maxlength = (currentMaxLength > maxlength)? currentMaxLength : maxlength;
        begin = i + 1
        isWindowActive = false
      } else {
        begin = i
        
      }
      
    }

  }

  if(isWindowActive){
        currentMaxLength =   end - begin + 1
        maxlength = (currentMaxLength > maxlength)? currentMaxLength : maxlength;
        isWindowActive = false
  }

  if(maxlength === 0){
    return 1
  }

  return maxlength
};

export function execute() {
  // console.log(lengthOfLongestSubstring("abcabcbb"))
  // console.log(lengthOfLongestSubstring("aub"))
  console.log(lengthOfLongestSubstring("pwwkew"))
  // console.log(lengthOfLongestSubstring("aabcd"))
  // let s = "abcd"
  // console.log(s.slice(0, 2))

}
