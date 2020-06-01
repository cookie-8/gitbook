# 异步并发

`限制异步操作的并发数量，且保证其执行顺序`

```js
class LimitRequest {
  constructor(max) {
    this.max = max // 最大并发数量
    this.count = 0 // 当前执行数量
    this.queueTask = [] // 待执行的任务队列
  }

  call = (fn, ...args) => {
    return new Promise((resolve, reject) => {
      const task = this.createTask(fn, args, resolve, reject)
      if (this.count >= this.max) {
        this.queueTask.push(task)
      } else {
        task()
      }
    })
  }

  createTask = (fn, args, resolve, reject) => {
    return () => {
      fn(...args)
        .then(resolve, reject)
        .finally(() => {
      
          this.count--
          if (this.queueTask.length) {
            const task = this.queueTask.shift()
            task()
          }
        })
      this.count++
    }
  }
}

// test 
const request = ()=> {
  return new Promise((resolve)=> {
    setTimeout(()=> {
      console.log(111)
      resolve()
    },3000)
  })
}

let lr = new LimitRequest(3)
for(let i = 0;i<10;i++)
lr.call(request)
```

