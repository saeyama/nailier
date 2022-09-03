class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string 'title', null: false
      t.string 'name', null: false
      t.string 'email', null: false
      t.text 'description', null: false

      t.timestamps
    end
  end
end
