# workers-goindex

google drive 网盘目录列表服务

# install

登录cloudflare，打开workers(若没有初始化，先初始化并定制域名)

创建worker，将index.js中内容复制到脚本框中

修改index.js中的client_id，client_secret，refresh_token字段

填写index.js中的roots网盘列表

# visit
```
https://oss.example.com
```

# other
服务只能使用一个用户的授权，但是多个网盘列表，可以是用户目录，也可以是团队盘

# acknowledge
* [goindex-theme-acrou](https://github.com/Aicirou/goindex-theme-acrou)