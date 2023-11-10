FactoryBot.define do
  factory :user do
    trait :admin do
      sequence(:email) { |n| "admin#{n}@test.com" }
      password { '123456' }
      role { User.roles[:admin] }
    end

    trait :member do
      sequence(:email) { |n| "meber#{n}@test.com" }
      password { '123456' }
      role { User.roles[:member] }
    end
  end
end
