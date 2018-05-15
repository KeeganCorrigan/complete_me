require './lib/complete_me'

complete = CompleteMe.new

Shoes.app(title: "CompleteMe", width: 800, height: 600, resizable: false) do
    background white
    para "Welcome to CompleteMe!"

    flow(margin: 15) do
      @insert = button "Insert a word"
      @load_dictionary = button "Load the dictionary"
      @load_addresses = button "Load Denver Addresses"
      @delete = button "Delete a word"     
    end
    flow(margin: 15) do
      para "What partial word would you like to search for?"
      @input = edit_line # this is the substring to be searched
      @submit = button "Submit"

    end

    flow(margin: 15) do
      para "Select an option:"
    end
    @output = flow(margin: 15) do

    end

    
    @insert.click do
      @insert_input = ask("Enter the word you want to input:")
      complete.insert(@insert_input)
    end

    @submit.click do
      @output.clear
      @results = [] 
      flow(margin: 15) do
        suggestions_array = complete.suggest(@input.text)
        suggestions_array.each do |suggestion|
          @results << suggestion
        end
        @results.each do |result|
          @output.append do 
            @select_button = button(result) do
              complete.select(@input, result)
            end
          end
        end
      end
    end

    @load_dictionary.click do
      dictionary = File.read("/usr/share/dict/words")

      complete.populate(dictionary)
    end

    @load_addresses.click do
      complete.load_addresses
    end

    @delete.click do
      delete_input = ask("Enter the word you want to delete:")
      complete.delete(delete_input)
    end

end