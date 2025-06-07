module Public::ReportsHelper
  #i18nを使わず、helper経由で変換(表示できないときはhumanizeで英語表記を読みやすく)
  def report_reason_label(reason)
    {
      "spam" => "スパム・宣伝行為",
      "abuse" => "暴言・誹謗中傷",
      "harassment" => "嫌がらせ・迷惑行為",
      "inappropriate_content" => "不適切な内容",
      "illegal_content" => "違法なコンテンツ",
      "other" => "その他"
    }[reason] || reason.humanize
  end
end
