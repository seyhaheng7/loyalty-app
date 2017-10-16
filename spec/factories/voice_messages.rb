FactoryGirl.define do
  factory :voice_message do
    voice_file File.open('spec/support/default.wav')
  end
end
