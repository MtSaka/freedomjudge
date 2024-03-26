set -e
echo ":: ACCESS LOG       ====>"
sudo cat /var/log/nginx/access.log | alp ltsv -m "/api/team/[0-9A-Za-z]+,/api/user/[0-9A-Za-z]+,/api/tasks/[0-9A-Za-z]+" --sort avg -r
echo ":: DB QUERY         ====>"
sudo cat /var/log/mysql/mysql-slow.log | pt-query-digest