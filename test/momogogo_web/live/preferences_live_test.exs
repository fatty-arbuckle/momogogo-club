defmodule MomogogoWeb.PreferencesLiveTest do
  use MomogogoWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Momogogo.Timeline

  @create_attrs %{step_scale: "some step_scale", user_id: 42}
  @update_attrs %{step_scale: "some updated step_scale", user_id: 43}
  @invalid_attrs %{step_scale: nil, user_id: nil}

  defp fixture(:preferences) do
    {:ok, preferences} = Timeline.create_preferences(@create_attrs)
    preferences
  end

  defp create_preferences(_) do
    preferences = fixture(:preferences)
    %{preferences: preferences}
  end

  describe "Index" do
    setup [:create_preferences]

    test "lists all preferences", %{conn: conn, preferences: preferences} do
      {:ok, _index_live, html} = live(conn, Routes.preferences_index_path(conn, :index))

      assert html =~ "Listing Preferences"
      assert html =~ preferences.step_scale
    end

    test "saves new preferences", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.preferences_index_path(conn, :index))

      assert index_live |> element("a", "New Preferences") |> render_click() =~
               "New Preferences"

      assert_patch(index_live, Routes.preferences_index_path(conn, :new))

      assert index_live
             |> form("#preferences-form", preferences: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#preferences-form", preferences: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.preferences_index_path(conn, :index))

      assert html =~ "Preferences created successfully"
      assert html =~ "some step_scale"
    end

    test "updates preferences in listing", %{conn: conn, preferences: preferences} do
      {:ok, index_live, _html} = live(conn, Routes.preferences_index_path(conn, :index))

      assert index_live |> element("#preferences-#{preferences.id} a", "Edit") |> render_click() =~
               "Edit Preferences"

      assert_patch(index_live, Routes.preferences_index_path(conn, :edit, preferences))

      assert index_live
             |> form("#preferences-form", preferences: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#preferences-form", preferences: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.preferences_index_path(conn, :index))

      assert html =~ "Preferences updated successfully"
      assert html =~ "some updated step_scale"
    end

    test "deletes preferences in listing", %{conn: conn, preferences: preferences} do
      {:ok, index_live, _html} = live(conn, Routes.preferences_index_path(conn, :index))

      assert index_live |> element("#preferences-#{preferences.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#preferences-#{preferences.id}")
    end
  end

  describe "Show" do
    setup [:create_preferences]

    test "displays preferences", %{conn: conn, preferences: preferences} do
      {:ok, _show_live, html} = live(conn, Routes.preferences_show_path(conn, :show, preferences))

      assert html =~ "Show Preferences"
      assert html =~ preferences.step_scale
    end

    test "updates preferences within modal", %{conn: conn, preferences: preferences} do
      {:ok, show_live, _html} = live(conn, Routes.preferences_show_path(conn, :show, preferences))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Preferences"

      assert_patch(show_live, Routes.preferences_show_path(conn, :edit, preferences))

      assert show_live
             |> form("#preferences-form", preferences: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#preferences-form", preferences: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.preferences_show_path(conn, :show, preferences))

      assert html =~ "Preferences updated successfully"
      assert html =~ "some updated step_scale"
    end
  end
end
