FactoryGirl.define do
  factory :site do
    sequence(:name){|n| "site #{n}"}
    is_default false
  end

  factory :domain do
    site
    sequence(:domain){|n| "test_domain_#{n}.test"}
    is_primary false
  end

  factory :photo do
    is_primary false
  end

  factory :background do
    is_primary false
  end
end
