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
      {:ok, _} = success ->
        success
      {:error, changeset} ->
        {
          :error,
          message: "Could not create Character",
          details: error_details(changeset)
        }
    end
  end

  defp error_details(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, _} -> msg end)
  end
end
