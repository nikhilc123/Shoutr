class MakeShoutsPolymorphic < ActiveRecord::Migration[5.1]
  #not added any validations, callbacks
  class Shout < ApplicationRecord
    belongs_to :content, polymorphic: true
  end
  class TextShout < ApplicationRecord; end

  def change
    #copying the content/body from Shouts table to TextShout
    # Shouts were already created and we need to handle that and the new shouts that will be created
    # Shouts can be textshout or imageshout
    change_table(:shouts) do |t|
      t.string :content_type
      t.integer :content_id
      t.index [:content_type, :content_id]
    end

    #Create the Text shout for the existing shout
    # Update the shout to have content type and content_id

    #Problem: As application grows, we may add validations ,callback...
    # could fail at update action

    # Solution: Redefine to add models in this migration: Ruby looks for constants in the class before it traverse below in the code:
    # Added Class immediately after change method

    # reversible: add the body of text to TextShout body and delete from Shout
    reversible do |dir|
      #Incase shout has its column cached
      Shout.reset_column_information
      Shout.find_each do |shout|
        dir.up do
          text_shout = TextShout.create(body: shout.body)
          shout.update(content_id: text_shout.id, content_type: "TextShout")
        end
        dir.down do
          shout.update(body: shout.content.body)
          shout.content.destroy
        end
      end
    end

    remove_column :shouts, :body, :string
  end
end
