FactoryBot.define do
  factory :reservation do
    book
    association :user, :admin
    pickup_time { Time.zone.tomorrow }
    code { SecureRandom.uuid }

    trait :lent do  
      status { Reservation.statuses[:lent] }
    end

    trait :reserved do
      status { Reservation.statuses[:reserved] }
    end
  end
end