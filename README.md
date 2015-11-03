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


## 開発

### 準備
```
cd hack/docker_cent
vagrant up
./up_mongo.sh  # dev mode のmongodb 起動
```

### アプリ動作確認
```
cd webapp
bundle install
bundle exec rails s
```
