# react

> react 推荐使用组合而不是继承

-   组件开发常用 render props，分离 render 的是无状态组件

-   高阶组件 常用 **组件参数** 、 **属性代理** 和 **反向继承**

> React hooks

-   useEffect 依赖需要清楚指定，应当避免造成死循环

    ```js
    useEffect(() => {
    	props.onChange(props.id);
    }, [props.onChange, props.id]);

    class App {
    	render() {
    		return (
    			<Child
    				id={this.state.id}
    				onChange={id => this.setState({ id })}
    			/>
    		);
    	}
    }
    ```

    上例代码会造成死循环

-   useMemo useCallback
    useMemo 和 useCallback 都会在组件第一次渲染的时候执行，之后会在其依赖的变量发生改变时再次执行；并且这两个 hooks 都返回缓存的值，useMemo 返回缓存的变量，useCallback 返回缓存的函数。

    useMemo 使用范例

    ```js

                export default function WithMemo() {
                const [count, setCount] = useState(1);
                const [val, setValue] = useState('');
                const expensive = useMemo(() => {
                console.log('compute');
                let sum = 0;
                for (let i = 0; i < count \* 100; i++) {
                sum += i;
                }
                return sum;
                }, [count]);

                    return <div>
                        <h4>{count}-{expensive}</h4>
                        {val}
                        <div>
                            <button onClick={() => setCount(count + 1)}>+c1</button>
                            <input value={val} onChange={event => setValue(event.target.value)}/>
                        </div>
                    </div>;
    ```

    useCallback 使用范例

    ```js
    function Parent() {
    	const [count, setCount] = useState(1);
    	const [val, setVal] = useState('');

    	const callback = useCallback(() => {
    		return count;
    	}, [count]);
    	return (
    		<div>
    			<h4>{count}</h4>
    			<Child callback={callback} />
    			<div>
    				<button onClick={() => setCount(count + 1)}>+</button>
    				<input
    					value={val}
    					onChange={event => setVal(event.target.value)}
    				/>
    			</div>
    		</div>
    	);
    }

    function Child({ callback }) {
    	const [count, setCount] = useState(() => callback());
    	useEffect(() => {
    		setCount(callback());
    	}, [callback]);
    	return <div>{count}</div>;
    }
    ```
