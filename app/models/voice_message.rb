class VoiceMessage < ApplicationRecord
  mount_uploader :voice_message, VoiceUploader
end
