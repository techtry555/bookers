class Book < ApplicationRecord

  # バリデーションの設定 (今回は未入力チェック)。
  ## この後で、バリデーションの結果をcontrollerで検出できるように記述する。次へ。。
  ## 今回は、create(新規保存) と update(更新保存) アクションで追加記述。

  # 入力されたデータの存在をチェックする。 ※ presence (存在)、true は存在しなきゃダメの意味。
  validates :title, presence: true
  validates :body, presence: true

end
