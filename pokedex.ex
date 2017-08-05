defmodule Pokedex do
  #Show the pokemons by type
  def accionFiltro(:portipo, lista) do
    tipos = obtenerTipos(lista, [])
    IO.puts "Tipos."
    menuTipos(0, tipos)
    answer = IO.gets("Elige el numero de la opcion de acuerdo al tipo >>>>")
    value = String.to_integer(String.first(answer))
    mostrar_por_tipo(elem(List.pop_at(tipos, value),0) , lista)
  end
  #show a pokemon with that id
  def accionFiltro(:porid, lista) do
    idDeseada = String.to_atom(String.strip(IO.gets("Id del pokemon> ")))
    listaFiltro = List.keyfind(lista, idDeseada, 0)
    IO.puts(inspect listaFiltro)
    listaFiltro
  end
  #Calls the funtion which sort the list of pokemons by lvl
  def accionFiltro(:pornivel, lista) do
    listaOrdenada= List.keysort(lista, 3)
    IO.puts(inspect listaOrdenada)
    listaOrdenada
  end
  #Calls the funtion which maps the list of pokemons
  def accionFiltro(:porevolucion, lista) do
    mostrar_con_evolucion(lista)
  end
  #Calls the funtion which maps the list of pokemons
  def accionFiltro(:porprevolucion, lista) do
    mostrar_con_preevol(lista)
  end

  #-----------------------------------------------------------------------------
  #if the parameter number 4(evolucion) is different from nil, it is shown
  def mostrar_con_evolucion([head | tail]) do
    if elem(head, 4) != nil do
      IO.puts(inspect head)
    end
    #calls the function again but with the tail of the list of pokemons
    mostrar_con_evolucion(tail)
  end

  # if the list of pokemons is empty shows and ending message
  def mostrar_con_evolucion([]) do
    IO.puts "No hay mas pokemon con evolucion"
  end

  #-----------------------------------------------------------------------------
  #if the parameter number 5(preevolucion) is different from nil, it is shown
  def mostrar_con_preevol([head | tail]) do
    if elem(head, 5) != nil do
      IO.puts(inspect head)
    end
    #calls the function again but with the tail of the list of pokemons
    mostrar_con_preevol(tail)
  end
  # if the list of pokemons is empty shows and ending message
  def mostrar_con_preevol([]) do
    IO.puts "No hay mas pokemon con preevolucion"
  end
  #Sarch the list of pokemons and creates a new list with all the different types
  def obtenerTipos([head | tail], tipos) do
    tipos = if !comprobar_existencia(elem(head, 2), tipos) do
      [elem(head, 2) | tipos]
    else
      tipos
    end
     obtenerTipos(tail, tipos)
  end
  #Stop function of obtenerTipos which returns the list with all the different types
  def obtenerTipos([], tipos) do
    IO.puts "No hay mas pokemons para obtener su elemento"
    IO.puts(inspect tipos)
    tipos
  end
  #Return true or false if the type is in the list
  def comprobar_existencia(t, lista) do
    Enum.member?(lista, t)
  end
  #Shows the menu from the list of types
  def menuTipos(i, [head | tail]) do
    IO.puts "#{i}. #{head}"
    menuTipos(i+1, tail)
  end
  #Stop function of menuTipos which shows a message if there is not more elements in the list
  def menuTipos(_i, []) do
    IO.puts "Estos son todos los tipos"
  end
  #Compares the type chosen with every element in the pokedex list and shows
  #that pokemon if it is from that type
  def mostrar_por_tipo(tipo, [head | tail]) do
    if tipo == elem(head,2)  do
      IO.puts inspect head
    end
    mostrar_por_tipo(tipo, tail)
  end
  #Stop function from mostrar_por_tipo which shows a message that there isn't more
  #Pokemons with that type.
  def mostrar_por_tipo(tipo, []) do
    IO.puts "No hay mas elementos de este tipo #{tipo}."
  end
end
