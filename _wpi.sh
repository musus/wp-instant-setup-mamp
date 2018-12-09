DB_USER="root"
DB_PASS="root"
WP_TITLE='Welcome to the WordPress'
WP_DESC='Hello World!'
PJ_NAME=${1-wpdev}
DB_NAME=$PJ_NAME"_db"
SCRIPT_DIR=$(cd $(dirname $0); pwd)
DIR_NAME=${SCRIPT_DIR##*/}

if [ -e "wp-config.php" ]; then
    open http://localhost:8888/$PJ_NAME
    exit 0
fi

echo "DROP DATABASE IF EXISTS $DB_NAME;" | /Applications/MAMP/Library/bin/mysql --defaults-extra-file=_wpi.cnf
echo "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" | /Applications/MAMP/Library/bin/mysql  --defaults-extra-file=_wpi.cnf

wp core download --locale=ja

export PATH="/Applications/MAMP/bin/php/php7.2.10/bin:$PATH"

export PATH=$PATH:/Applications/MAMP/Library/bin/

wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS

wp core install \
--url=http://localhost:8888/$DIR_NAME \
--title="WordPress" \
--admin_user="admin" \
--admin_password="admin" \
--admin_email="admin@example.com"

wp option update blogname "$WP_TITLE"
wp option update blogdescription "$WP_DESC"

open http://localhost:8888/$DIR_NAME