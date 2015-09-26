class CreateBooks < ActiveRecord::Migration
  def up
    create_table :books do |t|
	t.string "ISBN", :uniqueness => true, :null => false
	t.string "title"
	t.string "description"
	t.string "authors"
	t.string "status" , :default => "Available"
      t.timestamps 
    end
  end
	def down
		drop_table :books
	end
end
