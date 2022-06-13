# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end

    add_index :participants, %i[user_id room_id], unique: true
  end
end
