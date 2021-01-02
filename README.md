# テーブル設計

## users テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| nickname   | string  | null: false |
| email      | string  | null: false |
| password   | string  | null: false |
| last_name  | string  | null: false |
| first_name | string  | null: false |
| kana_last  | string  | null: false |
| kana_first | string  | null: false |
| birth      | integer | null: false |

### Association

- has_many :items
- has_many :cards

## items テーブル

| Column          | Type        | Options                        |
| --------------- | ----------- | ------------------------------ |
| name            | string      | null: false                    |
| text            | text        | null: false                    |
| category        | string      | null: false                    |
| condition       | string      | null: false                    |
| delivery_fee    | string      | null: false                    |
| sender_location | string      | null: false                    |
| delivery_time   | string      | null: false                    |
| price           | integer     | null: false                    |
| user            | references  | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :card
- has_one_attached :image

## Cards テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| credit_card     | integer    | null: false                    |
| validated_month | integer    | null: false                    |
| validated_year  | integer    | null: false                    |
| card_cvc        | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## Shipping_Address テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | integer    | null: false                    |
| prefectures  | string     | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     | null: false                    |
| phone_number | integer    | null: false                    |
| card         | references | null: false, foreign_key: true |

### Association

- belongs_to :card