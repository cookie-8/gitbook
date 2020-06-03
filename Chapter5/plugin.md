# 第 3 节：plugin

```js
class BasicPlugin {
  // 在构造函数中获取用户给该插件传入的配置
  constructor(options) {}

  // Webpack 会调用 BasicPlugin 实例的 apply 方法给插件实例传入 compiler 对象
  apply(compiler) {
    compiler.plugin("compilation", function (compilation) {})
  }
}

// 导出 Plugin
module.exports = BasicPlugin
```

```js
/**
 * 广播出事件
 * event-name 为事件名称，注意不要和现有的事件重名
 * params 为附带的参数
 */
compiler.apply("event-name", params)

/**
 * 监听名称为 event-name 的事件，当 event-name 事件发生时，函数就会被执行。
 * 同时函数中的 params 参数为广播事件时附带的参数。
 */
compiler.plugin("event-name", function (params) {})
```

```js
module.exports = {
  plugins: [
    // 在初始化 EndWebpackPlugin 时传入了两个参数，分别是在成功时的回调函数和失败时的回调函数；
    new EndWebpackPlugin(
      () => {
        // Webpack 构建成功，并且文件输出了后会执行到这里，在这里可以做发布文件操作
      },
      (err) => {
        // Webpack 构建失败，err 是导致错误的原因
        console.error(err)
      },
    ),
  ],
}

class EndWebpackPlugin {
  constructor(doneCallback, failCallback) {
    // 存下在构造函数中传入的回调函数
    this.doneCallback = doneCallback
    this.failCallback = failCallback
  }

  apply(compiler) {
    compiler.plugin("done", (stats) => {
      // 在 done 事件中回调 doneCallback
      this.doneCallback(stats)
    })
    compiler.plugin("failed", (err) => {
      // 在 failed 事件中回调 failCallback
      this.failCallback(err)
    })
  }
}
// 导出插件
module.exports = EndWebpackPlugin
```
