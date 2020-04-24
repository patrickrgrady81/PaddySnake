class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.references :user, null: false, foreign_key: true, foreign_key: { on_delete: :cascade }
      t.integer :value

      t.timestamps
    end
  end
end
