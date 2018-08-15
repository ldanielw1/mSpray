class AddWorkers < ActiveRecord::Migration[5.0]
  def change
    create_table :workers do |t|
      t.string :worker_id
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
