class CreateColors < ActiveRecord::Migration[6.1]
  def change
    create_table :colors do |t|
      t.references :design, null: false, foreign_key: true
      t.boolean :lame, null: false, default: false
      t.string  :hex_number, null: false

      t.timestamps
    end
  end
end
