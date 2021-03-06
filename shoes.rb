require './lib/complete_me'

complete = CompleteMe.new

Shoes.app(title: "CompleteMe", width: 1000, height: 600, resizable: false) do
    background white
    para "Welcome to CompleteMe!"

    flow(margin: 15) do
      @insert = button "Insert a word"
      @load_dictionary = button "Load the dictionary"
      @load_addresses = button "Load Denver Addresses"
      @delete = button "Delete a word"
      @count = button "Total words"    
    end
    flow(margin: 15) do
      para "What partial word would you like to search for?"
      @input = edit_line # this is the substring to be searched
      @submit = button "Submit"
      @substring_submit = button "Submit substring"
    end

    flow(margin: 15) do
      para "Select an option:"
    end

    @output = flow(margin: 15) do

    end
    @count.click do
      @output.clear
      @output.append do
        para "Total words:"
        para complete.count
      end
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
              complete.select(@input.text, result)
            end
          end
        end
      end
    end

    @substring_submit.click do
      @output.clear
      @results = []
      flow(margin: 15) do
        sub_suggestions_array = complete.suggest_substrings(@input.text)
        sub_suggestions_array.each do |suggestion|
          @results << suggestion
        end
        @results.each do |result|
          @output.append do 
            @select_button = button(result) do
              complete.select(@input.text, result)
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