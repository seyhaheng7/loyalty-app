class CreateVoiceMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :voice_messages do |t|
      t.string :voice_file

      t.timestamps
    end
  end
end
