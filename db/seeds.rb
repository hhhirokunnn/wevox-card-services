# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

titles = [
  'ロジック・論理',
  '挑戦',
  '自己成長',
  '多様性',
  '忍耐力',
  '信頼',
  '愛',
  '健康',
  'プロフェッショナル',
  'シンプル',
  'エモーション・感情',
  '安定',
  '貢献',
  '一体感',
  '爆発力',
  '努力',
  '感謝',
  '幸せ',
  '全力',
  '伝統',
  'グローバル',
  '変化',
  '革新性',
  '仕事',
  'ビジョン',
  '友情',
  '影響力',
  '刺激',
  '誇り',
  '自由',
  'ドメスティック',
  '一貫',
  '創造性',
  '家族',
  '堅実',
  '勝利',
  'ポジティブ',
  '個性',
  '学習',
  '能力',
  'リーダーシップ',
  '躍動的な人生',
  '行動',
  '情熱',
  '謙虚',
  '正直',
  '心地よさ',
  '遊び心',
  '効率',
  '気合い',
  'フォロワーシップ',
  '平穏な人生',
  '思考',
  '冷静',
  '尊敬',
  '勇気',
  '喜び',
  '責任感',
  '最先端',
  '経験'
]

titles.each do |title|
  Card.create(title: title)
end
