# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users テーブル

| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| nickname           | string    | null: false               |
| email              | string    | null: false, unique: true |
| encrypted_password | string    | null: false               |
| first_name         | string    | null: false               |
| last_name          | string    | null: false               |
| first_name_kana    | string    | null: false               |
| last_name_kana     | string    | null: false               |
| birth_year         | integer   | null: false               |
| birth_month        | integer   | null: false               |
| birth_day          | integer   | null: false               |

### Association
- has_many :items
- has_one :purchases


## itmes テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| image_id     | integer    | null: false                    |
| item_name    | string     | null: false, unique: true      |
| description  | text       | null: false                    |
| category     | string     | null: false                    |
| condition    | string     | null: false                    |
| delivery_fee | string     | null: false                    |
| shipment     | string     | null: false                    |
| shipping_day | string     | null: false                    |
| price        | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :purchase


## posts テーブル

| Column       | Type    | Options                   |
| ------------ | ------- | ------------------------- |
| post_code    | string  | null: false               |
| prefecture   | string  | null: false, unique: true |
| municipality | string  | null: false               |
| house_number | string  | null: false               |
| building     | string  |                           |
| phone_number | integer | null: false               |


### Association
- belongs_to :purchase


## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :post