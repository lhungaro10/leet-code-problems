//
// Problem 1: Two Sum
const nums = [3,3];
const target = 6;

function twoSum(nums: number[], target: number): number[] {
    let index1: number 
    let index2: number
    for(let i = 0; i < nums.length; i++){
        index1 = i
        for(let j = i + 1; j < nums.length; j++){
            index2 = j
            if (nums[index1] + nums[index2] === target) return [index1, index2]
        }
    }
    return []
};

export function execute(){
    console.log("indexes: ", twoSum(nums, target));
}
 