class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.references :design, null: false, foreign_key: true
      t.string  :access_code, null: false

      t.timestamps
    end
  end
end
