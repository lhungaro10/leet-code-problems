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
  
  if(s.length < 1) return 0
  if(s.length == 1) return 1
  
  
  
  // percorrer a string, verificando:
  for(let i= 0; i < s.length; i++){
    let interval = s.substring(begin, end+1)
      // caso a letra for diferente da substring da janela

        //se a Janela está ativa 
        //se a Janela não está ativa 
      // senão (caso a letra anterior for igual a atual)
        // A letra é igual, a janela está ativa
          // precisa atualizar o maxLength se necessário
          // o begin será o i + 1, já que já analisamos o i
          // e desativamos a janela
    
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
