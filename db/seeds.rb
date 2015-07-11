# coding: utf-8

require 'open-uri'

# テーブルレコードの削除
App.delete_all

product_ids = [
  930026670,
  815181808,
  577232024,
  728293409,
  357421934,
  794729836,
  893927401,
  320606217,
  733772494,
  935672069,
  333903271,
  389801252
]

product_ids.each {|id|
  Utils::AppUtil.new("itunes", product_id).save_app
}
