const string = "{([])}"

function isValid(s: string): boolean {
  const teste = {")":"(", "}":"{", "]":"["}
  const abre  = ['(', '{', '[']
  const fecha  = [')', '}', ']']

  const stack :string[]= [];
  let stackTopIndex = 0;
  for (let i = 0; i < s.length; i++) {
    if(abre.includes(s[i])) {
      stack.push(s[i])
      stackTopIndex++
    }else if(fecha.includes(s[i])){
      if(stack[stackTopIndex-1] != teste[s[i] as keyof typeof teste]) return false;
      stack.pop();
      stackTopIndex--
    }
  }

  return stack.length === 0
};

console.log(isValid(string))