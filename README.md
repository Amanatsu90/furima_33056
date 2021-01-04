# テーブル設計

## users テーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | null: false |
| email                | string  | null: false |
| encrypted_password   | string  | null: false |
| last_name            | string  | null: false |
| first_name           | string  | null: false |
| kana_last            | string  | null: false |
| kana_first           | string  | null: false |
| birth                | date    | null: false |

### Association

- has_many :items

## items テーブル

| Column          | Type        | Options                        |
| --------------- | ----------- | ------------------------------ |
| name            | string      | null: false                    |
| text            | text        | null: false                    |
| category        | integer     | null: false                    |
| condition       | integer     | null: false                    |
| delivery_fee    | integer     | null: false                    |
| sender_location | integer     | null: false                    |
| delivery_time   | integer     | null: false                    |
| price           | integer     | null: false                    |
| user            | references  | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one_attached :image
- has_one :shipping_address

## Shipping_Address テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefectures  | integer    | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :item