defmodule Asap.Base do
  defmacro __using__(_) do
    quote do
      import Asap.Base, only: [schema: 2]

      Module.register_attribute(__MODULE__, :schema, accumulate: false)
      Module.register_attribute(__MODULE__, :asap_fields, accumulate: true)

      def serialize(struct, terminator \\ "\\") do
        str =
          struct.__struct__.__schema__(:fields)
          |> Enum.map(&Map.get(struct, &1, ""))
          |> Enum.map(&to_string/1)
          |> concat(struct.__struct__.__schema__(:source))
          |> Enum.join("*")

        str <> terminator
      end

      def parse(str) do
        str
        |> String.split("*")

        # get source
        # take number list and match to order of schema
      end

      # private
      defp concat(list, value), do: [value | list]
    end
  end

  defmacro schema(source, do: block) do
    schema(__CALLER__, source, block)
  end

  defp schema(_caller, source, block) do
    prelude =
      quote do
        Module.register_attribute(__MODULE__, :struct_fields, accumulate: true)
        source = unquote(source)

        try do
          import Asap.Base
          unquote(block)
        after
          :ok
        end
      end

    postlude =
      quote unquote: false do
        fields = @asap_fields |> Enum.reverse()
        loaded = Asap.Base.__loaded__(__MODULE__, @struct_fields)

        defstruct @struct_fields

        # used for runtime introspection of the schema
        def __schema__(:fields), do: unquote(Enum.map(fields, &elem(&1, 0)))
        def __schema__(:types), do: unquote(Enum.map(fields, &elem(&1, 1)))
        def __schema__(:source), do: unquote(source)

        for clauses <- Asap.Base.__schema__(fields),
            {args, body} <- clauses do
          def __schema__(unquote_splicing(args)), do: unquote(body)
        end
      end

    quote do
      unquote(prelude)
      unquote(postlude)
    end
  end

  def __schema__(_fields), do: []

  def __loaded__(module, struct_fields) do
    case Map.new([{:__struct__, module} | struct_fields]) do
      struct -> struct
    end
  end

  defmacro field(name, type, opts \\ []) do
    quote do
      Asap.Base.__field__(__MODULE__, unquote(name), unquote(type), unquote(opts))
    end
  end

  def __field__(mod, name, type, opts) do
    define_field(mod, name, type, opts)
  end

  defp define_field(mod, name, type, opts) do
    put_struct_field(mod, name, Keyword.get(opts, :default))
    Module.put_attribute(mod, :asap_fields, {name, type})
  end

  defp put_struct_field(mod, name, assoc) do
    fields = Module.get_attribute(mod, :struct_fields)

    if List.keyfind(fields, name, 0) do
      raise ArgumentError, "field #{inspect(name)} is already set on schema"
    end

    Module.put_attribute(mod, :struct_fields, {name, assoc})
  end
end
