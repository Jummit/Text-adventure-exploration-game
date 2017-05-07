os.loadAPI("/TextadventureExplorationGame/api.lua")
os.loadAPI("api.lua")

api.researches = {
  newResearch(
    "The truth about this game",
    {
      "game", "what", "to do"
    },
    function()
      print("You Won!!!")
      os.exit()
    end
  ),
  newResearch(
    "first steps",
    {
      "it"
    },
    function()
    end
  ),
  newResearch(
    "Where is the wiki?",
    {
      "wiki",
      "is"
    },
    function()
    end
  ),
  newResearch(
    "No way home",
    {
      "go",
      "tower"
    }
  )
}

api.places = {
  castle = newPlace(
    "castel",
    "The dark big castle",
    {
      newWay("tower", true)
    },
    {
      "The castle",
      "It is very grand. The family which lives there once is now gone."
    },
    function()
    end
  ),
  tower = newPlace(
    "Tower",
    "A very heigh tower.",
    {
      newWay("castle", true),
    },
    nil,
    function()
    end
  )
}

while true do
  api.main()
end
