@echo off

echo Creating Robot Framework project...

mkdir tests\login
mkdir tests\users
mkdir tests\orders

mkdir resources\keywords
mkdir resources\variables
mkdir resources\common

mkdir libraries\api
mkdir libraries\database

mkdir data
mkdir results

type nul > tests\login\login.robot
type nul > tests\users\users.robot
type nul > tests\orders\orders.robot

type nul > resources\keywords\login_keywords.robot
type nul > resources\keywords\user_keywords.robot
type nul > resources\keywords\order_keywords.robot

type nul > resources\variables\dev_variables.robot
type nul > resources\variables\prod_variables.robot

type nul > resources\common\common_keywords.robot

type nul > libraries\api\api_client.py
type nul > libraries\database\db_client.py

type nul > data\users.json
type nul > data\test_data.csv

type nul > requirements.txt
type nul > README.md
type nul > .gitignore

echo.
echo Robot Framework project created successfully!
echo.

tree /f

pause