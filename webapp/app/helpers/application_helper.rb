
module ApplicationHelper
  # 選択中のサイドメニューのクラスを返す
  def sidebar_activate(sidebar_link_url)
    current_url = request.headers['PATH_INFO']
    if current_url.match(sidebar_link_url)
      ' class="active"'
    else
      ''
    end
  end

  # サイドメニューの項目を出力する
  def sidebar_list_items
    items = [
      {:text => 'Schools',      :path => admin_schools_path},
      {:text => 'Students',      :path => admin_students_path},
      {:text => 'Curriculum Network',      :path => admin_curriculums_path},
    ]

    html = ''
    items.each do |item|
      text = item[:text]
      path = item[:path]
      html = html + %Q(<li#{sidebar_activate(path)}><a href="#{path}">#{text}</a></li>)
    end

    raw(html)
  end


  def prefectures
    return [
      "--都道府県--",
      "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県",
      "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県",
      "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県",
      "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県",
      "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
      "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県",
      "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県",
      "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
    ]
  end
end
