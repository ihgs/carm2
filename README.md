# 塾生徒管理システム

## 実行方法

```
cd /opt
git clone (this repository)
cd cram
docker-compose build
docker-compose up -d
```

## 更新方法

```
cd /opt/cram
git pull origin
docker-compose build
docker-compose stop
docker-compose up -d
```
