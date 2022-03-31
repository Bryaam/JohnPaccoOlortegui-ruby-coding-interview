FactoryBot.define do
  factory :tweet do
    user { create(:user) }
    body { Faker::Lorem.sentence }
  end
end
