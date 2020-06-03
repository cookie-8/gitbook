# 第 2 节：loader

loader 是 nodejs 的一个模块

```js
const loaderUtils = require("loader-utils")
module.exports = function (source) {
  const options = loaderUtils.getOptions(this) // 获取loader option参数
  // 返回其他结果
  // 当你使用 this.callback 返回内容时，该 Loader 必须返回 undefined，
  // this.callback(null, source, sourceMaps)

  // 异步情况
  // var callback = this.async()
  // someAsyncOperation(source, function (err, result, sourceMaps, ast) {
  //   // 通过 callback 返回异步执行后的结果
  //   callback(err, result, sourceMaps, ast)
  // })
  
  return source
}
```
