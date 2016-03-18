class RemoveGithubRepositoruFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :github_repository, :string
  end
end
