defmodule MainApp do
  import Pokedex #Manage the list filters

#Start the app with an initial list of pokemons is called once at the beginning
  def start() do
    #An initial list with some pokemons
    pokedexInicial=[{:"01", :Bolbassaur, "grass", 5, "Ivyssaur", nil},
    {:"02", :Ivyssaur, "grass", 16, "Venassaur", "Bolbassaur"},
    {:"03", :Venassaur, "grass", 32, nil, "Ivyssaur"},
    {:"04", :Charmander, "fire", 05, "Charmeleon", nil},
    {:"07", :Squirtle, "water", 05, "Wartortle", nil}]

    loop(pokedexInicial)
  end
# launch to menu of the app with 3 actions
  defp loop(pokemons) do
    action=get_action()
    make_action(action, pokemons)
  end

# Shows the menu of the app, and take the answer given by console
  defp get_action() do

    IO.puts """
    Bienvenido al aplicativo pokemon.
    Que deseas hacer?
    1. Registrar pokemon
    2. Filtrar Pokemons.
    3. Salir.
    """
    answer = IO.gets("Elige el numero de la opcion que deseas >>>>")
    value=String.first(answer)
    char_to_atom_option(value)
  end

# Take the action given by console and converts it in an atom
  defp char_to_atom_option(char) do
    case char do
      "1" -> :registrar
      "2" -> :filtrar
      "3" -> :salir
    end
  end
 # Given an atom called :registrar ask for the pokkemon info and stores it in a list
  defp make_action(:registrar, pokemons) do
    inId= String.to_atom(String.strip(IO.gets("Id del pokemon> ")))
    inNombre = String.to_atom(String.strip(IO.gets("Nombre del pokemon> ")))
    inTipo = String.strip(IO.gets("Tipo del pokemon> "))
    inNivel = String.to_integer(String.strip(IO.gets("Nivel del pokemon(numero)> ")))
    inEvol= String.strip(IO.gets("Evolucion del pokemon. Presiona Enter si no tiene evolucion> "))
    inPreEvol = String.strip(IO.gets("Pre-evolucion del pokemon. Presiona Enter si no tiene pre-evolucion> "))

    inEvol = if inEvol == "" do
      IO.puts "No tiene Evolucion"
      nil
    else
      IO.puts inEvol
      inEvol
    end

    inPreEvol= if inPreEvol == "" do
      IO.puts "No tiene preEvolucion"
      nil
    else
      IO.puts inPreEvol
      inPreEvol
    end
    #Format of the new pokemon
    inPokemon={inId, inNombre, inTipo, inNivel, inEvol, inPreEvol}
    #Insert the new pokemon in the last position of the given list
    pokemons_new = List.insert_at(pokemons, -1, inPokemon)
    #Print the pokemon
    IO.puts(inspect pokemons_new)
    #Call the loop function again
    loop(pokemons_new)
  end


# Given an atom called :filtrar shows the filter menu and call the respective filter
  defp make_action(:filtrar, pokemons) do
    IO.puts """
    Como deseas realizar el Filtro Pokemon?
    1. Por tipo
    2. Por Numero de ID
    3. Nivel.
    4. Evolucion(Mostrar los que tengan evolucion)
    5. Pre-Evolucion(Mostrar los que tengan pre-evolucion)
    """

    answer = IO.gets("Elige el numero de la opcion del filtro que deseas >>>>")
    value=String.first(answer)
    filtro=char_to_atom_filtro(value)
    #Function in Pokedex module
    accionFiltro(filtro, pokemons)
    #Call the loop function again.
    loop(pokemons)
  end

# Print a message of success and finish the app
  defp make_action(:salir, _pokemons) do
    IO.puts "Finalizo exitosamente, chaoo!"
  end

# Converts a given option in a filter atom
  defp char_to_atom_filtro(char) do
    case char do
      "1" -> :portipo
      "2" -> :porid
      "3" -> :pornivel
      "4" -> :porevolucion
      "5" -> :porprevolucion
    end
  end



end
