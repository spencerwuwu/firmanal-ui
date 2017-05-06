class AddNewColumn < ActiveRecord::Migration[5.0]
  def change

    remove_column :targets, :metaexploits, :integer

    add_column :targets, :metasploits, :integer

    add_column :targets, :source_code_data,  :text, :default => ""
    add_column :targets, :angr_data_data,  :text, :default => ""         
    add_column :targets, :afl_data,  :text, :default => ""          
    add_column :targets, :network_fuzz_data,  :text, :default => ""
    add_column :targets, :metasploits_data,  :text, :default => ""
  end
end
