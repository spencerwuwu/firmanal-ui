class AddStatusToTargets < ActiveRecord::Migration[5.0]
  def change
    add_column :targets, :uploaded,     :boolean 
    add_column :targets, :extracted,    :integer
    add_column :targets, :source_code,  :integer
    add_column :targets, :angr,         :integer
    add_column :targets, :afl,          :integer
    add_column :targets, :network_fuzz, :integer
    add_column :targets, :metaexploits, :integer
  end
end
