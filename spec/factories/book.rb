FactoryBot.define do
  factory :book do
    title { 'Lord of the Rings' }
    genre { 'Fantasy' }
    description { 'The definitive fantasy book' }
    author { 'J.R.R. Tolkien' }
    quantity { 0 }
  end
end
