require './lib/complete_me'

complete = CompleteMe.new

Shoes.app(title: "CompleteMe",
  width: 800, height: 600, resizable: false) do
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
      @input = edit_line 
      @submit = button "Submit"
    end
    flow(margin: 15) do
      @test = para "Test area"
    end
    @submit.click do
      
      @test.replace @input.text
    end

end