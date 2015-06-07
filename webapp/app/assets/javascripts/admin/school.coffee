# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#school_address_post").jpostal({
    postcode : [ "#school_address_post" ],

    # 入力項目フォーマット
    #   %3  都道府県
    #   %4  市区町村
    #   %5  町域
    #   %6  大口事業所の番地
    #   %7  大口事業所の名称
    address  : {
                  "#school_address_prefecture" : "%3", # 都道府県が入力される
                  "#school_address_city"       : "%4", # 市区町村と町域が入力される
                  "#school_address_address1"   : "%5"
                }
  })
