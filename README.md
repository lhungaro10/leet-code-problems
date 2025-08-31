# Leet Code Problems
The goal of this project is the improvement of developers' programming logic through the problems offered by [LeetCode](https://leetcode.com/problemset/).

Only for personal development.

## Ranking


## How to contribute

> 🤖 **Important**: The ranking above is automatically updated by GitHub Actions when you push to master. You don't need to run `make update-ranking` or `make update-all` manually - the system will handle it for you!

### Getting Started
- Make a new folder with your name (ex: your-name).
- Add subfolders with the names: 0-easy, 1-medium, 2-hard.
  - The subfolder names have to be exactly as mentioned above for the scripts to work correctly.

### Create a problem
- Run one of the following commands **according to the difficulty level**:
```bash 
make add-easy
make add-medium
make add-hard
```
- Input the contributor name (your folder name)
- Input the number of the problem
- Input the name of the problem
- After that, run the command:
```bash
make update-indexes
```
- This will update all index files from the entire directory and allow you to run your problem in the main.ts file

### Mark a problem as solved
To have your solved problem counted in the ranking:
1. Add the comment `// solved` at the top of your problem file
2. Make sure your solution is working correctly
3. Push your changes to master

**Example:**
```ts
// solved
// Problem 1: Two Sum
export function solution(nums: number[], target: number): number[] {
  // Your solution here
}

export function execute() {
  // Your test code here
  console.log(solution([2, 7, 11, 15], 9));
}
```

### Running a problem
- Every problem created is going to have an execute function. This function will be executed in the main.ts file.
```ts
export function execute(){
  // 2, 4, 3
  const val1 = new ListNode(2, new ListNode(4, new ListNode(3)))

  // 5, 6, 4
  const val2 = new ListNode(5, new ListNode(6, new ListNode(4)))

  showListNode(addTwoNumbers(val1, val2));
}
```
- Prepare your test in that function and call it in the main file:
```ts
import { solution2 } from "./lucas-hungaro/1-medium";

solution2()
```

- After that, just run the command:
```bash
make run
```

### Upload to git
- Make sure the main.ts file is cleaned up for the next person.
- Commit your changes:
```bash
git add .
git commit -m "Add problem [problem-number]: [problem-name]"
```
- Push your changes:
```bash
git push
```

> 📊 **Automatic Ranking Update**: After you push, GitHub Actions will automatically update the ranking in this README within a few minutes. No manual intervention needed!

## Available Commands

| Command | Description | Who should use |
|---------|-------------|----------------|
| `make add-easy` | Create a new easy problem | ✅ Developers |
| `make add-medium` | Create a new medium problem | ✅ Developers |
| `make add-hard` | Create a new hard problem | ✅ Developers |
| `make update-indexes` | Update index.ts files | ✅ Developers |
| `make update-ranking` | Update ranking manually | ❌ **Don't use** - automated |
| `make update-all` | Update indexes + ranking | ❌ **Don't use** - automated |
| `make run` | Run main.ts | ✅ Developers |

> ⚠️ **Note**: The `update-ranking` and `update-all` commands are handled automatically by GitHub Actions. Running them manually may cause conflicts when pushing to master.