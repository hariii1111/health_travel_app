class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :minutes
      t.float :mets
      t.integer :calories
      t.float :distance

      t.timestamps
    end
  end
end
