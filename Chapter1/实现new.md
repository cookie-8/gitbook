# new

`实现new，关键点在于函数返回的结果究竟是不是对象或者函数，如果不是，需要返回构造的对象; 特别注意还要记得设置原型链`

```js
function myNew(fn, ...args) {
  const obj = {} // 构造一个对象
  obj.__proto__ = fn.prototype // 设置原型
  // 设置原型还可以更优雅
  // const obj = Object.create(fn.prototype)

  const result = fn.call(obj, ...args)
  if (
    (result && typeof result === "object") ||
    (result && typeof result === "function")
  ) {
    return result
  }
  return obj
}
```
