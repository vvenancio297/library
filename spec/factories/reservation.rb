FactoryBot.define do
  factory :reservation do
    trait :lent do
      book
      user
      pickup_time { Time.zone.tomorrow }
      status { Reservation.statuses[:lent] }
    end

    trait :reserved do
      book
      user
      pickup_time { Time.zone.tomorrow }
      status { Reservation.statuses[:reserved] }
    end
  end
end