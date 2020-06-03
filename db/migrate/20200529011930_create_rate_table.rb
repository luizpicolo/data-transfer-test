class CreateRateTable < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.decimal :download
      t.decimal :upload
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end