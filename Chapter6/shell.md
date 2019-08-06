# 第 1 节：shell 小脚本

1. 循环找出指定后缀的文件，并且追加写入某一文件

```shell
for i in $(find ~/projects/every-record-new/src \( -name "*.js" -o -name "*.html" -o -name "*.css" \))
  do  cat $i >> ~/test.txt
  done
```
