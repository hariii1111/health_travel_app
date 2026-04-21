class CreateCharacterStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :character_statuses do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :level
      t.float :exp
      t.float :total_exp
      t.integer :last_level

      t.timestamps
    end
  end
end
