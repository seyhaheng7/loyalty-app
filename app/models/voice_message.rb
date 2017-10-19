class VoiceMessage < ApplicationRecord
  mount_uploader :voice_file, VoiceUploader
end
