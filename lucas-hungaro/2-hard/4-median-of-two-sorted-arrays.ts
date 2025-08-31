//solved
// Problem 4: Median of two sorted arrays
const nums1=[1,2,3,4,5]
const nums2=[6,7,8,9,10,11,12,13,14,15,16,17]

function findMedianSortedArrays(nums1: number[], nums2: number[]): number {
  const isOdd = (n:number)=> (n % 2) != 0
  const median = (arr:number[])=>{
      if(isOdd(arr.length)){
        return arr[Math.trunc(arr.length / 2)]
      }
      
      return (arr[arr.length / 2 -1] + arr[arr.length / 2])/2 
  }
  const mergedArray = [...nums1, ...nums2].sort((a, b) => a - b)
  return median(mergedArray)
};

export function execute() {
  const nums1=[1,2,3,4,5]
  const nums2=[6,7,8,9,10,11,12,13,14,15,16,17]
  console.log(findMedianSortedArrays(nums1, nums2))
}
