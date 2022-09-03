class CreateDesigns < ActiveRecord::Migration[6.1]
  def change
    create_table :designs do |t|
      t.string :title, null: false
      t.string :nail_part, null: false
      t.string :description

      t.timestamps
    end
  end
end
