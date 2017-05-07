local inputChar = ">>>"

function newResearch(name, keyWords, gettedFunc)
  return {
    name = name,
    keyWords = keyWords,
    gettedFunc = gettedFunc
  }
end

local researches = {
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
local character = {
  researches = {},
  notes = {
  },
  addNote = function()
  end,
}

function input()
  io.write(inputChar)
  return io.read()
end

function research()
  inputChar = "The note on which the research is based on:"
  local note = input()
  if character.notes[note] then
    completeNote = ""
    for k, word in pairs(character.notes[note]) do
      completeNote = completeNote..word
    end
    failed = false
    for k, research in pairs(researches) do
      for k, word in pairs(research.keyWords) do
        if not string.find(completeNote, word) then
          failed = true
        end
      end
      if not failed then
        print("It worked! Research '"..research.name.."' getted!")
        return research.gettedFunc()
      else
        failed = false
      end
    end
    print("it didnt worked...")
  end
end

function drawNote(note, untilLine)
  if note then
    term.clear()
    for lineNumber, text in pairs(note) do
      if untilLine == lineNumber then
        return
      end
      print("|"..text)
    end
  else
    return false
  end
end

function actions(actionsTab)
  local answer = input()
  if answer == "options" then
    for key, func in pairs(actionsTab) do
      print(key)
    end
    print("Now type what you want to do!")
  end
  for key, func in pairs(actionsTab) do
    if answer == key then
      inputChar = key..">"
      return func()
    end
  end
end

function notes()
  actions(
    {
      delete = function()
        inputChar = "Note to delete: "
        note = input()
        if character.notes[note] then
          character.notes[note] = nil
        else
          print("This note does not exist!")
        end
      end,
      double = function()
        inputChar = "File to double: "
        note = input()
        if not character.notes[note] then
          print("This file does not exist!")
          return
        end
        inputChar = "Name of the double: "
        character.notes[input()] = character.notes[note]
      end,
      rename = function()
        inputChar = "File to rename: "
        note = input()
        inputChar = "Name: "
        character.notes[input()] = character.notes[note]
        character.notes[note] = nil
      end,
      help = function()
        print("new: create a new note")
        print("list: lists every note you have")
        print("read: print a note you want")
      end,
      edit = function()
        inputChar = "Name of note:"
        local name = input()
        inputChar = "|"
        if drawNote(character.notes[name]) then
          character.notes[name] = {}
          error("file does not exits")
        end

        local note = character.notes[name]
        local lineNum = #note+1

        while true do
          drawNote(note, lineNum)
          if not note[lineNum] then
            note[lineNum] = ""
          end
          inputChar = "|"..note[lineNum]
          local text = input()
          if text == "end" then
            break
          elseif text == "up" then
            if lineNum > 1 then
              lineNum = lineNum - 1
            end
          elseif text == "delete" then
            if lineNum ~= 1 then
              table.remove(note, lineNum)
              if lineNum+1 == #note then
                lineNum = lineNum - 1
              end
            end
          elseif text == "clear" then
            note[lineNum] = ""
          else
            note[lineNum] = note[lineNum]..text
            lineNum = lineNum + 1
          end
        end
      end,
      list = function()
        for name, note in pairs(character.notes) do
          print(name)
        end
      end,
      read = function()
        inputChar = "Note to read: "
        local note = input()
        if character.notes[note] then
          for k, text in pairs(character.notes[note]) do
            print("|"..text)
          end
        else
          print("That note doesnt exists...")
        end
      end
    }
  )
end

function newWay(direction, open)
  return {
    direction = direction,
    open = open
  }
end

function newPlace(name, description, ways, note, enterFunc)
  return {
    name = name,
    ways = ways,
    note = note,
    noteGetted = false,
    enterFunc = enterFunc
  }
end

local places = {}
local localplace

function go()
  inputChar = "Go to "
  local text = input()
  for k, way in pairs(localplace.ways) do
    if way.open then
      if text == "" then
        print(way.direction)
      else
        print("going to "..way.direction.."...")
        localplace = places[way.direction]
        if localplace.enterFunc then
          localplace.enterFunc()
        end
        if localplace.note then
          print("you got a note about the place!")
          inputChar = "Name of the note: "
          character.notes[input()] = localplace.note
        end
      end
    end
  end
end

function main()
  actions(
    {
      research = research,
      notes = notes,
      go = go
    }
  )
  inputChar = ">>>"
end
