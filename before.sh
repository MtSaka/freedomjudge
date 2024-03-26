set -e
echo ":: CLEAR LOGS       ====>"
sudo truncate -s 0 -c /var/log/nginx/access.log
sudo truncate -s 0 -c /var/log/mysql/mysql-slow.log 

echo ":: KILL PPROF       ====>"
set +e
kill -9 $(lsof -t -i:1080)
set -e
echo ":: GIT PULL         ====>"
cd ~/webapp
git pull
# 設定ファイルのコピー
sudo cp ~/webapp/conf/nginx.conf /etc/nginx/nginx.conf
sudo cp ~/webapp/conf/risucontest.conf /etc/nginx/sites-enabled/risucontest.conf
sudo cp ~/webapp/conf/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
# コンパイル
cd ~/webapp/go
go build -o risucontest
echo ":: RESTART SERVICES ====>"
sudo systemctl restart --now risucontest.service
sudo systemctl restart --now mysql.service
sudo systemctl restart --now nginx.service
echo ":: START PPROF ====>"
go tool pprof -http=:1080 http://localhost:6060/debug/fgprof/profile?seconds=80
# wait ってなったらsshを切る