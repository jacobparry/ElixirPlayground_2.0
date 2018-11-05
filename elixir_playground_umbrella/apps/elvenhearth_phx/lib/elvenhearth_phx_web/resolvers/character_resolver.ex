defmodule ElvenhearthPhxWeb.Resolvers.CharacterResolver do
  alias Elvenhearth.Characters.CharacterQueries
  alias Elvenhearth.Characters.Character

  def list_characters(_, _, _) do
    {:ok, CharacterQueries.get_all()}
  end

  def get_characters_for_user(user, _, _) do
    {:ok, CharacterQueries.get_all_for_user(user)}
  end

  def create_character(_parent, %{input: params} = args, _resolution) do
    character = Character.changeset(%Character{}, params)

    case CharacterQueries.create(character) do
      {:ok, character} = success ->
        {:ok, %{character: character}}
      {:error, changeset} ->
        {:ok, %{errors: transform_errors(changeset)}}
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn {key, value} ->
      %{key: key, message: value}
    end)
  end

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
