class AddOwnerAndRepositoryToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :owner, :string
    add_column :projects, :repository, :string
  end
end
