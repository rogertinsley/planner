class AddRepoToProject < ActiveRecord::Migration
  def change
    add_column :projects, :github_repository, :string
  end
end
