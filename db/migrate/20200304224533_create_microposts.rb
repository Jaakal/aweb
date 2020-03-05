class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :text
      t.integer :author_id

      t.timestamps
    end
    add_index :microposts, :author_id
  end
end
