class AddPid < ActiveRecord::Migration[5.0]
  def change
    add_column :targets, :pid,     :integer
  end
end
