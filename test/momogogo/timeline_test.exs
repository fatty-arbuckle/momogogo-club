defmodule Momogogo.TimelineTest do
  use Momogogo.DataCase

  alias Momogogo.Timeline

  describe "posts" do
    alias Momogogo.Timeline.Post

    @valid_attrs %{activity: "some activity", date: "some date", duration: "some duration", steps: 42, username: "some username"}
    @update_attrs %{activity: "some updated activity", date: "some updated date", duration: "some updated duration", steps: 43, username: "some updated username"}
    @invalid_attrs %{activity: nil, date: nil, duration: nil, steps: nil, username: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Timeline.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Timeline.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Timeline.create_post(@valid_attrs)
      assert post.activity == "some activity"
      assert post.date == "some date"
      assert post.duration == "some duration"
      assert post.steps == 42
      assert post.username == "some username"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Timeline.update_post(post, @update_attrs)
      assert post.activity == "some updated activity"
      assert post.date == "some updated date"
      assert post.duration == "some updated duration"
      assert post.steps == 43
      assert post.username == "some updated username"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_post(post, @invalid_attrs)
      assert post == Timeline.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Timeline.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Timeline.change_post(post)
    end
  end

  describe "preferences" do
    alias Momogogo.Timeline.Preferences

    @valid_attrs %{step_scale: "some step_scale", user_id: 42}
    @update_attrs %{step_scale: "some updated step_scale", user_id: 43}
    @invalid_attrs %{step_scale: nil, user_id: nil}

    def preferences_fixture(attrs \\ %{}) do
      {:ok, preferences} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timeline.create_preferences()

      preferences
    end

    test "list_preferences/0 returns all preferences" do
      preferences = preferences_fixture()
      assert Timeline.list_preferences() == [preferences]
    end

    test "get_preferences!/1 returns the preferences with given id" do
      preferences = preferences_fixture()
      assert Timeline.get_preferences!(preferences.id) == preferences
    end

    test "create_preferences/1 with valid data creates a preferences" do
      assert {:ok, %Preferences{} = preferences} = Timeline.create_preferences(@valid_attrs)
      assert preferences.step_scale == "some step_scale"
      assert preferences.user_id == 42
    end

    test "create_preferences/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_preferences(@invalid_attrs)
    end

    test "update_preferences/2 with valid data updates the preferences" do
      preferences = preferences_fixture()
      assert {:ok, %Preferences{} = preferences} = Timeline.update_preferences(preferences, @update_attrs)
      assert preferences.step_scale == "some updated step_scale"
      assert preferences.user_id == 43
    end

    test "update_preferences/2 with invalid data returns error changeset" do
      preferences = preferences_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_preferences(preferences, @invalid_attrs)
      assert preferences == Timeline.get_preferences!(preferences.id)
    end

    test "delete_preferences/1 deletes the preferences" do
      preferences = preferences_fixture()
      assert {:ok, %Preferences{}} = Timeline.delete_preferences(preferences)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_preferences!(preferences.id) end
    end

    test "change_preferences/1 returns a preferences changeset" do
      preferences = preferences_fixture()
      assert %Ecto.Changeset{} = Timeline.change_preferences(preferences)
    end
  end
end
