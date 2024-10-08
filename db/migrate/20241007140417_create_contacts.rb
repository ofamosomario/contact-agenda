# frozen_string_literal: true

# table migrate
class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.string :zip_code, null: false
      t.string :cep, null: true
      t.float :latitude
      t.float :longitude

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :contacts, :cpf, unique: true
  end
end
