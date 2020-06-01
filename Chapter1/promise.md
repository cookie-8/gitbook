# promise

```js
class MyPromise {
  constructor(executor) {
    this.status = "pending"
    this.value = undefined
    this.reason = undefined
    this.onResovleCallback = []
    this.onRejectCallback = []

    executor(this.resovle, this.reject)
  }

  resovle = (value) => {
    if (this.status === "pending") {
      this.status = "fulfilled"
      this.value = value
      this.onResovleCallback.forEach((fn) => fn())
    }
  }

  reject = (reason) => {
    if (this.status === "pending") {
      this.status = "rejected"
      this.reason = reason
      this.onRejectCallback.forEach((fn) => fn())
    }
  }

  then = (onFulfilled, onRejected) => {
    const promise = new MyPromise((resolve, reject) => {
      if (this.status === "fulfilled") {
        setTimeout(() => {
          const x = onFulfilled(this.value)
          x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
        }, 0)
      }
      if (this.status === "rejected") {
        setTimeout(() => {
          const x = onRejected(this.reason)
          x instanceof MyPromise ? x.then(resolve, reject) : reject(x)
        }, 0)
      }
      if (this.status === "pending") {
        this.onResovleCallback.push(() => {
          setTimeout(() => {
            const x = onFulfilled(this.value)
            x instanceof MyPromise ? x.then(resolve, reject) : resolve(x)
          }, 0)
        })

        this.onRejectCallback.push(() => {
          setTimeout(() => {
            const x = onRejected(this.reason)
            x instanceof MyPromise ? x.then(resolve, reject) : reject(x)
          }, 0)
        })
      }
    })

    return promise
  }

  static all = (promises) => {
    let count = 0
    const result = []
    return new MyPromise((resolve, reject) => {
      promises.forEach((promise, index) => {
        promise.then(
          (res) => {
            result[index] = res

            count++
            if (count === promises.length) {
              resolve(result)
            }
          },
          (reason) => {
            reject(reason)
          },
        )
      })
    })
  }

  static race = (promises) => {
    return new MyPromise((resolve, reject) => {
      promises.forEach((promise) => {
        promise.then(
          (res) => {
            resolve(res)
          },
          (reason) => {
            reject(reason)
          },
        )
      })
    })
  }
}

// test

let promise1 = new MyPromise((resolve, reject) => {
  setTimeout(() => {
    resolve(123)
  }, 2000)
})
let promise2 = new MyPromise((resolve, reject) => {
  setTimeout(() => {
    resolve(1234)
  }, 1000)
})

MyPromise.all([promise1, promise2]).then((res) => {
  console.log(res)
  window.test = res
})

// MyPromise.race([promise1, promise2]).then(res => {
//   console.log(res);
// });

// promise1
//   .then(
//     res => {
//       console.log(res); //过两秒输出123
//       return new MyPromise((resolve, reject) => {
//         setTimeout(() => {
//           resolve("success");
//         }, 1000);
//       });
//     },
//     err => {
//       console.log(err);
//     }
//   )
//   .then(
//     res => {
//       console.log(res);
//     },
//     err => {
//       console.log(err);
//     }
//   );
```
