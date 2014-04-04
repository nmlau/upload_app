class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.integer :user_id
      t.string :image
      t.integer :bytes

      t.timestamps
    end
  end
end
