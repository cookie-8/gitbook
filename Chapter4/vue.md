# vue

1. v-show
    > v-show 控制显隐，是通过 js 代码去修改元素的 element style。如果 value 为 false，设置 display: none；如果 value 为 true，清除 display 属性。所以 value 为 true 时，只是将 element style 中的 display 效果清除，并不能覆盖 css 中的 display 样式。
2. react 和 vue 的 diff 过程有什么区别

    > React diff 的是 Dom，而 Vue diff 的是数据。

    > React：你给我一个数据，我根据这个数据生成一个全新的 Virtual DOM，然后跟我上一次生成的 Virtual DOM 去 diff，得到一个 Patch，然后把这个 Patch 打到浏览器的 DOM 上去。完事。并且这里的 Patch 显然不是完整的 Virtual DOM，而是新的 Virtual DOM 和上一次的 Virtual DOM 经过 diff 后的差异化的部分。

    > Vue: 在渲染过程中，会跟踪每一个组件的依赖关系，不需要重新渲染整个组件树。

