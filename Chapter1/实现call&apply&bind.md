# call apply bind

1. `call`

```js
Function.prototype.myCall = function (context, ...args) {
  // 1.判断context是否为空
  if (context === undefined || context === null) {
    context = window
  }
  // 2.给函数设置新的this指向
  let fn = new Symbol()
  context[fn] = this
  const result = context[fn](...args)
  delete context[fn]
  return result
}
```

2. `apply`

```js
Function.prototype.myApply = function (context, ...args) {
  // 1.判断context是否为空
  if (context === undefined || context === null) {
    context = window
  }
  // 2.给函数设置新的this指向
  let fn = new Symbol()
  context[fn] = this
  const result = context[fn](...args)
  delete context[fn]
  return result
}
```

3. `bind`

```js
Function.prototype.myBind = function (context, ...args) {
  // 1. 检查context是否为空
  if (context === undefined || context === null) {
    context = window
  }
  const fn = new Symbol()
  context[fn] = this
  const _this = this // 保存this

  const result = function (...innerArgs) {
    // 2.检查是否将bind之后的函数作为构造函数
    if (this instanceof _this) {
      this[fn] = _this
      this[fn](...args, ...innerArgs)
      delete this[fn]
    } else {
      context[fn](...args, ...innerArgs)
    }
  }

  result.prototype = Object.create(this.prototype)
  delete context[fn]
  return result
}
```
