# DB設計
## usersテーブル
| Column             | Type    | Option      |
|-|-|-|
| nickname           | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_kana     | string  | null: false |
| first_name_kana    | string  | null: false |
| date_of_birth      | date    | null: false |

### Association
- has_many :items
- has_many :shopping_records

## itemsテーブル
| Column | Type | Option |
|-|-|-|
| name               | string     | null: false |
| descritption       | text       | null: false |
| price              | integer    | null: false |
| category_id        | integer    | null: false |
| condition_id       | integer    | null: false |
| shipping_charge_id | integer    | null: false |
| shipping_date_id   | integer    | null: false |
| prefecture_id      | integer    | null: false |
| user(FK)           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :shopping_record

## shopping_recordsテーブル
| Column | Type | Option |
|-|-|-|
| user(FK) | references | null: false, foreign_key: true |
| item(FK) | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery_address

## delivery_addressesテーブル
| Column | Type | Option |
|-|-|-|
| prefecture_id          | integer    | null: false |
| postal_code            | string     | null: false |
| city                   | string     | null: false |
| house_number           | string     | null: false |
| building_name          | string     |
| telephone_number       | integer    | null: false |
| shopping_record(FK)    | references | null: false, foreign_key: true |

### Association
- belongs_to :shopping_record