class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :shout, foreign_key: true


      t.timestamps
    end
    #user should not like the same shout more than once
    # that is why unique
    add_index :likes, [:user_id, :shout_id], unique: true
  end
end
