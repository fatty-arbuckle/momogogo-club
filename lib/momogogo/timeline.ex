defmodule Momogogo.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false
  alias Momogogo.Repo

  alias Momogogo.Timeline.Post

  def list_users do
    Repo.all(
      from u in Momogogo.Users.User
    )
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(:all) do
    Repo.all(
      from p in Post,
      order_by: [desc: p.date]
    )
  end
  def list_posts(user) do
    Repo.all(
      from p in Post,
      where: p.username == ^user,
      order_by: [desc: p.date]
    )
  end


  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
    # |> broadcast(:post_created)
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
    # |> broadcast(:post_updated)
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def subscribe() do
    Phoenix.PubSub.subscribe(Momogogo.PubSub, "posts")
  end

  # defp broadcast({:error, _reason} = error, _event), do: error
  # defp broadcast({:ok, post}, event) do
  #   Phoenix.PubSub.broadcast(Momogogo.PubSub, "posts", {event, post})
  #   {:ok, post}
  # end

  alias Momogogo.Timeline.Preferences

  @doc """
  Returns the list of preferences.

  ## Examples

      iex> list_preferences()
      [%Preferences{}, ...]

  """
  def list_preferences do
    Repo.all(Preferences)
  end

  @doc """
  Gets a single preferences.

  Raises `Ecto.NoResultsError` if the Preferences does not exist.

  ## Examples

      iex> get_preferences!(123)
      %Preferences{}

      iex> get_preferences!(456)
      ** (Ecto.NoResultsError)

  """
  def get_preferences!(id), do: Repo.get!(Preferences, id)

  @doc """
  Creates a preferences.

  ## Examples

      iex> create_preferences(%{field: value})
      {:ok, %Preferences{}}

      iex> create_preferences(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_preferences(attrs \\ %{}) do
    %Preferences{}
    |> Preferences.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a preferences.

  ## Examples

      iex> update_preferences(preferences, %{field: new_value})
      {:ok, %Preferences{}}

      iex> update_preferences(preferences, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_preferences(%Preferences{} = preferences, attrs) do
    preferences
    |> Preferences.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a preferences.

  ## Examples

      iex> delete_preferences(preferences)
      {:ok, %Preferences{}}

      iex> delete_preferences(preferences)
      {:error, %Ecto.Changeset{}}

  """
  def delete_preferences(%Preferences{} = preferences) do
    Repo.delete(preferences)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking preferences changes.

  ## Examples

      iex> change_preferences(preferences)
      %Ecto.Changeset{data: %Preferences{}}

  """
  def change_preferences(%Preferences{} = preferences, attrs \\ %{}) do
    Preferences.changeset(preferences, attrs)
  end

  def get_preferences_id_for_user(user_id) do
    %{ id: id } = get_preferences_by_user(user_id)
    id
  end

  def get_preferences_by_user(user_id) do
    case Repo.one(
      from p in Preferences,
      where: [user_id: ^user_id]
    ) do
      nil ->
        {:ok, preferences} = create_preferences(%{user_id: user_id})
        preferences
      preferences ->
        preferences
    end
  end

end
