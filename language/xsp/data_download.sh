# coding=utf-8
# Copyright 2018 The Google AI Language Team Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#~/usr/bin/env bash

TRAIN_ONLY_ARG="train_only"
PSWD=""      ## REMOVE WHEN FINISHED RUNNING!!!!!!!!!!!

# 1. Need to download the Spider dataset from the website directly (wget won't
# work with Google drive links).

# This data can stay as-is.

if ! ( test -d spider )
then
    # echo "Download the Spider dataset before proceeding (URL: https://drive.google.com/uc?export=download&id=1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0). After downloading, the current working directory should contain a subdirectory called spider."
    # exit
    gdown 
else
    echo "Spider is already downloaded."
fi

if ! (test -d spider/train.json)
then
    cp spider/train_spider.json spider/train.json
fi

# 2. Download the Michigan annotations. Each should be stored in a directory
# called dataset_name/, with two files inside: dataset.json and
# dataset_schema.csv.

# WikiSQL
if ! (test -d wikisql)
then
    echo "************************ DOWNLOADING DATASET: WikiSQL ************************"
    mkdir wikisql
    wget https://github.com/jkkummerfeld/text2sql-data/blob/master/data/wikisql.json.bz2?raw=true
    mv wikisql.json.bz2?raw=true wikisql/wikisql.json.bz2

    bzip2 -d wikisql/wikisql.json.bz2

    # TODO: Get the schemas
    wget https://github.com/salesforce/WikiSQL/blob/master/data.tar.bz2?raw=true
    mv data.tar.bz2?raw=true wikisql/data.tar.bz2
    bzip2 -d wikisql/data.tar.bz2
    tar -xzvf wikisql/data.tar

    mv data/* wikisql/
    rm -rf data
else
    echo "WikiSQL is already downloaded."
fi

# Exit here if not downloading the evaluation data.
if [ "$TRAIN_ONLY_ARG" = "$1" ]; then
    echo "Downloading training data only."
    exit
fi

# Geoquery
if ! (test -d geoquery)
then
    echo "Downloading Geoquery annotations."
    mkdir geoquery
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/geography.json || exit
    mv geography.json geoquery/geoquery.json

    # wget https://github.com/jkkummerfeld/text2sql-data/blob/master/data/geography-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/geography-schema.csv || exit
    mv geography-schema.csv geoquery/geoquery_schema.csv
fi

# ATIS
if ! (test -d atis)
then
    echo "Downloading ATIS annotations."
    mkdir atis
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/atis.json || exit
    mv atis.json atis/atis.json

    # wget https://github.com/jkkummerfeld/text2sql-data/blob/master/data/atis-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/atis-schema.csv || exit
    mv atis-schema.csv atis/atis_schema.csv
fi

# Academic
if ! (test -d academic)
then
    echo "Downloading Academic annotations."
    mkdir academic
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/academic.json || exit
    mv academic.json academic/academic.json

    # wget https://github.com/jkkummerfeld/text2sql-data/blob/master/data/academic-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/academic-schema.csv || exit
    mv academic-schema.csv academic/academic_schema.csv
fi

# Restaurants
if ! (test -d restaurants)
then
    echo "Downloading Restaurants annotations."
    mkdir restaurants
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/restaurants.json || exit
    mv restaurants.json restaurants/restaurants.json

    # wget https://github.com/jkkummerfeld/text2sql-data/blob/master/data/restaurants-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/restaurants-schema.csv || exit
    mv restaurants-schema.csv restaurants/restaurants_schema.csv
fi

# Yelp
if ! (test -d yelp)
then
    echo "Downloading Yelp annotations."
    mkdir yelp
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/yelp.json || exit
    mv yelp.json yelp/yelp.json

    # wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/blob/master/data/yelp-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/yelp-schema.csv || exit
    mv yelp-schema.csv yelp/yelp_schema.csv
fi

# Scholar
if ! (test -d scholar)
then
    echo "Downloading Scholar annotations."
    mkdir scholar
    # wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/blob/master/data/scholar.json || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/scholar.json || exit
    mv scholar.json scholar/scholar.json

    # wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/blob/master/data/scholar-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/scholar-schema.csv || exit
    mv scholar-schema.csv scholar/scholar_schema.csv
fi

# Advising
if ! (test -d advising)
then
    echo "Downloading Advising annotations."
    mkdir advising
    # wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/blob/master/data/advising.json || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/advising.json || exit
    mv advising.json advising/advising.json

    # wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/blob/master/data/advising-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/advising-schema.csv || exit
    mv advising-schema.csv advising/advising_schema.csv
fi

# IMDB
if ! (test -d imdb)
then
    echo "Downloading IMDB annotations."
    mkdir imdb
    # wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/blob/master/data/imdb.json || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/imdb.json || exit
    mv imdb.json imdb/imdb.json

    # wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/blob/master/data/imdb-schema.csv || exit
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/imdb-schema.csv || exit
    mv imdb-schema.csv imdb/imdb_schema.csv
fi

# 3. Download the actual databases.

if ! (test -d databases)
then
    mkdir databases
fi

# Download the database utils.
if ! (test -f data_utils/mysql2sqlite.sh)
then
    echo "Download the mysql2sqlite.sh script here:"
    echo "https://gist.githubusercontent.com/esperlu/943776/raw/be469f0a0ab8962350f3c5ebe8459218b915f817/mysql2sqlite.sh"
    echo "Make sure the md5 hash of the script is 0029197bbaf57c8d60300c2e0896d137."
    echo "Then move the downloaded script to the directory `data_utils` and rerun this script."
    exit
fi

# You also need to download and install a mysql server.
# Details on how to install: https://dev.mysql.com/doc/refman/5.7/en/installing.html

# Spider's databases are included in the official download, so no need to
# re-download anything. Just move them to the databases directory.
if ! (test -d databases/spider_databases)
then
    mkdir databases/spider_databases
    for domain in spider/database/*; do
        echo "Copying data from "$domain
        cp $domain/*.sqlite databases/spider_databases
    done
fi

database_installation() {
    # [1] Name of downloaded database
    # [2] Desired database name (e.g., geoquery)
    cat data_utils/$2-prefix.txt $1 > $2-modified.sql

    echo "Installing "$2
    # mysql -u root -p < $2-modified.sql
    mysql -u root -p < $2-modified.sql

    echo "Converting to sqlite3"
    sh data_utils/mysql2sqlite.sh -u root -p $2 | sqlite3 databases/$2.db

    rm *.sql
}

# ATIS
if ! (test -f databases/atis.db)
then
    echo "Downloading and converting ATIS database."
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/atis-db.sql

    database_installation atis-db.sql atis
fi

# Geoquery
if ! (test -f databases/geoquery.db)
then
    echo "Downloading and converting Geoquery database."
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/geography-db.sql

    database_installation geography-db.sql geoquery
fi

# Advising
if ! (test -f databases/advising.db)
then
    echo "Downloading and converting the Advising datbase."
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/advising-db.sql

    database_installation advising-db.sql advising
fi

# Academic, Yelp, and IMDB

if ! (test -f databases/academic.db)
then
    if ! (test -f MAS.sql)
    then
        echo "To install academic, please download MAS.sql from this link: https://drive.google.com/drive/folders/0B-2uoWxAwJGKY09kaEtTZU1nTWM"
        exit
    fi

    database_installation MAS.sql academic
fi

if ! (test -f databases/imdb.db)
then
    if ! (test -f IMDB.sql)
    then
        echo "To install imdb, please download IMDB.sql from this link: https://drive.google.com/drive/folders/0B-2uoWxAwJGKY09kaEtTZU1nTWM"
        exit
    fi

    database_installation IMDB.sql imdb
fi

if ! (test -f databases/yelp.db)
then
    if ! (test -f YELP.sql)
    then
        echo "To install yelp, please download YELP.sql from this link: https://drive.google.com/drive/folders/0B-2uoWxAwJGKY09kaEtTZU1nTWM"
        exit
    fi

    database_installation YELP.sql yelp
    echo "If you notice errors in the database installation for Yelp, it did not install properly. You may need to manually dump the MySQL database to a text file, then pipe it to sqlite3 by fixing syntax errors. For example, you may need to fix instances of the character sequence \"\',\"."
fi

# Restaurants
if ! (test -f databases/restaurants.db)
then
    wget https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master/data/restaurants-db.txt

    if ! (test -f data_utils/create_restaurant_database.py)
    then
        echo "You need to download the create_restaurant_database.py file into data_utils/:"
        echo "https://github.com/jkkummerfeld/text2sql-data/blob/master/tools/create_restaurant_database.py"
        echo "We used commit #ab96e30. The md5 hash is a90157e9eab77706fbd95bf99ff65736."
        echo "You also need to modify this script slightly. On lines 23, 82, and 93, you need to change RESTAURANT_ID to ID."
        exit
    fi

    # Convert the restaurants database to a sqlite3 database.
    python3 data_utils/create_restaurant_database.py restaurants-db.txt databases/restaurants.db

    rm restaurants-db.txt
fi

# Scholar
if ! (test -f databases/scholar.db)
then
    # if ! (test -f scholar_mysql_dump.db)
    # then
    #     echo "To install Scholar, please download and unzip from https://drive.google.com/uc?id=0Bw5kFkY8RRXYRXdYYlhfdXRlTVk&export=download."
    #     exit
    # fi

    echo "Downloading and converting the Scholar datbase."
    gdown 0Bw5kFkY8RRXYRXdYYlhfdXRlTVk

    database_installation scholar_mysql_dump.db scholar

    rm scholar_mysql_dump.db
fi

# 4. Generate empty versions of the databases.

if ! (test -d empty_databases)
then
    mkdir empty_databases
fi

empty_database() {
    if ! (test -f empty_databases/$1.db)
    then
        cp databases/$1.db empty_databases
        python data_utils/empty_database.py --db_to_empty=empty_databases/$1.db
    fi
}

empty_database geoquery
empty_database atis
empty_database restaurants
empty_database academic
empty_database imdb
empty_database yelp
empty_database scholar
empty_database advising

if ! (test -d empty_databases/spider_databases)
then
    cp -r databases/spider_databases empty_databases
    python data_utils/empty_database.py --db_to_empty=empty_databases/spider_databases
fi

# 5. Add indices to the databases that need them.

python data_utils/add_indices.py --database_name=academic
python data_utils/add_indices.py --database_name=imdb
python data_utils/add_indices.py --database_name=scholar

# 6. Compute caches of execution.
echo "If you want to create caches ahead of time for your evaluation, run data_utils/create_cache.py."
echo "See this file for a description of the necessary arguments."
echo "Creating a cache can take a long time (up to several hours) even with indices added to the databases."
