//solved
// Problem 2: Add two Numbers

/*
  constraints:
    - não possui zeros a esquerda
    - número de nós vai de 1 a 100
    - valor do nó [0-9]

  Informações relevantes:
    os números estão na ordem inversa, então:
    2 -> 4 -> 3 = 342
    5 -> 6 -> 4 = 465
*/ 

class ListNode {
    val: number
    next: ListNode | null
    constructor(val?: number, next?: ListNode | null) {
        this.val = (val===undefined ? 0 : val)
        this.next = (next===undefined ? null : next)
    }
}

export function addTwoNumbers(l1: ListNode | null, l2: ListNode | null): ListNode | null {
  let count = 0;
  let previousSumHasExcess = false;
  let result  =  new ListNode();
  let aux = result
  while(aux !== null){
    count++
    
    let valToBeStored = 0;
    if(l1 === null) l1 = new ListNode()
    if(l2 === null) l2 = new ListNode()
    
    let sum = (!previousSumHasExcess) ? l1.val + l2.val : l1.val + l2.val + 1; // 9 + 1
      
    let excess = sum - 10;
    if (excess >= 0) {
      valToBeStored = excess
      previousSumHasExcess = true
    } else {
      valToBeStored = sum
      previousSumHasExcess = false
    }

    aux.val = valToBeStored

    if((l1.next !== null || l2.next !== null) || (l1.next === null && l2.next === null && previousSumHasExcess)){
      aux.next = new ListNode()
      aux = aux.next
      l1 = l1.next;
      l2 = l2.next
     
    }else {
      aux = null
    }
    
    
  }
  return result
};


// debug functions
function showListNode(l1:ListNode): void {
  let aux = l1;
  while(aux!= null){
    console.log(aux.val)
    aux = aux.next
  }
}

export function execute(){
  // 2, 4, 3
  const val1 = new ListNode(2, new ListNode(4, new ListNode(3)))

  // 5, 6, 4
  const val2 = new ListNode(5, new ListNode(6, new ListNode(4)))

  showListNode(addTwoNumbers(val1, val2));
}
