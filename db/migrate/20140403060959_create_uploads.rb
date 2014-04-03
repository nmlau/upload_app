class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :link
      t.integer :user_id
      t.boolean :watermark
      t.boolean :sepia
      t.boolean :vertflip

      t.timestamps
    end
    add_index :uploads, [:user_id, :created_at]
  end
end
