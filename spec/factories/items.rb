FactoryBot.define do
  factory :item do
    name { "Item #{Faker::Lorem.word(exclude_words: ['id', 'error'])} #{Faker::Lorem.word(exclude_words: ['id', 'error'])}" }
    description { Faker::Lorem.paragraph(sentence_count: 3, supplemental: false, random_sentences_to_add: 2) }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2).to_s }
  end
end