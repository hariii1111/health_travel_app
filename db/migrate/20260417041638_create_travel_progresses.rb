class CreateTravelProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :travel_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.float :total_distance

      t.timestamps
    end
  end
end
