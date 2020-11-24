# # Load another ".iex.exs" file
# import_file("~/.iex.exs")

defmodule Data.Helper do

  def create_test_data do
    IO.inspect("running elixir code", label: ".iex.exs")

    today = DateTime.utc_now
    |> DateTime.to_date

    Data.Helper.insert_user(1, "kermit@example.com", "Kermit J. Frog", "password")
    Data.Helper.insert_post(1, Date.add(today,  0), "Running, 8 minute mile", 45)
    Data.Helper.insert_post(1, Date.add(today,  0), "Stretching", 20)
    Data.Helper.insert_post(1, Date.add(today, -1), "Spinning class", 50)
    Data.Helper.insert_post(1, Date.add(today, -1), "Stretching", 15)
    Data.Helper.insert_post(1, Date.add(today, -3), "Hiking, general", 75)
    Data.Helper.insert_post(1, Date.add(today, -5), "Running, 8 minute mile", 45)
    Data.Helper.insert_post(1, Date.add(today, -5), "Stretching", 10)
    Data.Helper.insert_post(1, Date.add(today, -6), "Hiking, uphill", 90)
    Data.Helper.insert_post(1, Date.add(today, -7), "Running, 8 minute mile", 45)
    Data.Helper.insert_post(1, Date.add(today, -7), "Stretching", 15)

    Data.Helper.insert_user(2, "piggy@example.com", "Miss Piggy", "password")
    Data.Helper.insert_post(2, Date.add(today,  -1), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -2), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -3), "Weight lifting", 30)
    Data.Helper.insert_post(2, Date.add(today,  -4), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -5), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -6), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -7), "Weight lifting", 30)
    Data.Helper.insert_post(2, Date.add(today,  -8), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -9), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -10), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -11), "Weight lifting", 30)
    Data.Helper.insert_post(2, Date.add(today,  -12), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -13), "Walking, 4 mph", 60)
    Data.Helper.insert_post(2, Date.add(today,  -14), "Walking, 4 mph", 60)

    Data.Helper.insert_user(3, "scooter@example.com", "Scooter", "password")
    Data.Helper.insert_post(3, Date.add(today,  -0), "Basketball, recreational", 60)
    Data.Helper.insert_post(3, Date.add(today,  -2), "Basketball, recreational", 60)
    Data.Helper.insert_post(3, Date.add(today,  -3), "Basketball, game", 45)
    Data.Helper.insert_post(3, Date.add(today,  -5), "Basketball, recreational", 60)
    Data.Helper.insert_post(3, Date.add(today,  -7), "Basketball, recreational", 60)
    Data.Helper.insert_post(3, Date.add(today,  -8), "Basketball, game", 45)
    Data.Helper.insert_post(3, Date.add(today,  -11), "Basketball, recreational", 60)
    Data.Helper.insert_post(3, Date.add(today,  -12), "Basketball, recreational", 60)
    Data.Helper.insert_post(3, Date.add(today,  -15), "Basketball, game", 45)
    Data.Helper.insert_post(3, Date.add(today,  -18), "Basketball, recreational", 60)
    Data.Helper.insert_post(3, Date.add(today,  -19), "Basketball, recreational", 60)

    Data.Helper.insert_user(4, "fozzy@example.com", "Fozzy Bear", "password")
    Data.Helper.insert_post(4, Date.add(today,  -0), "Walking, 4 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -1), "Walking, 3 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -2), "Walking, 2 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -4), "Walking, 2 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -5), "Walking, 4 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -7), "Walking, 3 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -8), "Walking, 3 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -9), "Walking, 4 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -10), "Walking, 3 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -11), "Walking, 3 mph", 60)
    Data.Helper.insert_post(4, Date.add(today,  -12), "Walking, 4 mph", 60)

    Data.Helper.insert_user(5, "gonzo@example.com", "Weirdo", "password")
    Data.Helper.insert_post(5, Date.add(today,  -0), "Aerobics Class", 60)
    Data.Helper.insert_post(5, Date.add(today,  -0), "Archery", 50)
    Data.Helper.insert_post(5, Date.add(today,  -1), "Badminton", 20)
    Data.Helper.insert_post(5, Date.add(today,  -1), "Bowling", 50)
    Data.Helper.insert_post(5, Date.add(today,  -2), "Chopping Wood", 40)
    Data.Helper.insert_post(5, Date.add(today,  -3), "Fencing", 60)
    Data.Helper.insert_post(5, Date.add(today,  -3), "Frisbee", 40)
    Data.Helper.insert_post(5, Date.add(today,  -4), "Gymnastics", 10)
    Data.Helper.insert_post(5, Date.add(today,  -5), "Jogging", 20)
    Data.Helper.insert_post(5, Date.add(today,  -5), "Line dancing", 70)
    Data.Helper.insert_post(5, Date.add(today,  -7), "Miniature golf", 45)
    Data.Helper.insert_post(5, Date.add(today,  -8), "Painting", 90)
    Data.Helper.insert_post(5, Date.add(today,  -8), "Rollerblading/skating", 30)
    Data.Helper.insert_post(5, Date.add(today,  -8), "Snowshoeing", 50)
    Data.Helper.insert_post(5, Date.add(today,  -9), "Swimming, leisurely", 10)
    Data.Helper.insert_post(5, Date.add(today,  -10), "Tai chi", 60)
    Data.Helper.insert_post(5, Date.add(today,  -11), "Vacuuming", 50)
    Data.Helper.insert_post(5, Date.add(today,  -13), "Water aerobics", 30)

    :ok
  end

  def insert_user(id, email, name, password) do
    %Momogogo.Users.User{}
    |> Momogogo.Users.User.changeset(%{
      id: id,
      name: name,
      email: email,
      password: password,
      password_confirmation: password
    })
    |> Momogogo.Repo.insert()
  end

  def insert_post(user_id, date, activity, duration) do
    %Momogogo.Timeline.Post{}
    |> Momogogo.Timeline.Post.changeset(%{
      username: to_string(user_id),
      date: Date.to_iso8601(date),
      activity: activity,
      duration: duration
    })
    |> Momogogo.Repo.insert()
  end

end
