defmodule Momogogo.Activity do

  @custom "Custom (enter steps directly)"

  @conversion_table %{
    "Aerobics Class" => %{ rate: 145 },
    "Archery" => %{ rate: 102 },
    "Backpacking, uphill" => %{ rate: 242, icon: "fa-hiking" },
    "Badminton" => %{ rate: 136 },
    "Baseball" => %{ rate: 111, icon: "fa-baseball-ball" },
    "Basketball, game" => %{ rate: 178, icon: "fa-basketball-ball" },
    "Basketball, recreational" => %{ rate: 133, icon: "fa-basketball-ball" },
    "Bicycling, 10 mph easy" => %{ rate: 133, icon: "fa-bicycle" },
    "Bicycling, 13 mph moderate" => %{ rate: 178, icon: "fa-bicycle" },
    "Bicycling, 15 mph vigorous" => %{ rate: 222, icon: "fa-bicycle" },
    "Billiards/pool" => %{ rate: 77 },
    "Bowling" => %{ rate: 87 },
    "Boxing, noncompetitive" => %{ rate: 131 },
    "Boxing, competitive" => %{ rate: 222 },
    "Calisthenics" => %{ rate: 106 },
    "Canoeing" => %{ rate: 106 },
    "Chopping Wood" => %{ rate: 133 },
    "Circuit training, general" => %{ rate: 178 },
    "Cleaning house" => %{ rate: 78 },
    "Climbing, rock or mountain" => %{ rate: 273, icon: "fa-mountain" },
    "Dancing, aerobic" => %{ rate: 133 },
    "Dancing, general" => %{ rate: 100 },
    "Elliptical machine" => %{ rate: 249 },
    "Fencing" => %{ rate: 133 },
    "Fishing, sitting" => %{ rate: 91 },
    "Fitness class –low impact" => %{ rate: 152 },
    "Fitness class –high impact" => %{ rate: 212 },
    "Football" => %{ rate: 189 },
    "Frisbee" => %{ rate: 67 },
    "Gardening" => %{ rate: 131, icon: "fa-leaf" },
    "Golf, carrying clubs" => %{ rate: 122, icon: "fa-golf-ball" },
    "Golf, cart" => %{ rate: 78, icon: "fa-golf-ball" },
    "Gymnastics" => %{ rate: 89 },
    "Handball" => %{ rate: 267 },
    "Hiking, general" => %{ rate: 172, icon: "fa-hiking" },
    "Hiking, uphill" => %{ rate: 212, icon: "fa-hiking" },
    "Hockey" => %{ rate: 178, icon: "fa-hockey-puck" },
    "Horseback riding, general" => %{ rate: 102, icon: "fa-horse" },
    "Ice skating" => %{ rate: 203, icon: "fa-skating" },
    "Jogging" => %{ rate: 156, icon: "fa-running" },
    "Jumping rope, moderate" => %{ rate: 244 },
    "Jumping rope, slow" => %{ rate: 178 },
    "Kayaking" => %{ rate: 152 },
    "Line dancing" => %{ rate: 139 },
    "Martial Arts" => %{ rate: 222 },
    "Miniature golf" => %{ rate: 91, icon: "fa-golf-ball" },
    "Mowing (push mower)" => %{ rate: 160 },
    "Mopping" => %{ rate: 101 },
    "Painting" => %{ rate: 100 },
    "Pilates" => %{ rate: 99 },
    "Ping Pong" => %{ rate: 121, icon: "fa-table-tennis" },
    "Punching bag" => %{ rate: 182 },
    "Racquetball, moderate" => %{ rate: 156 },
    "Rock climbing" => %{ rate: 244, icon: "fa-mountain" },
    "Rollerblading/skating" => %{ rate: 156, icon: "fa-skating" },
    "Rowing machine, moderate" => %{ rate: 111 },
    "Rowing machine, vigorous" => %{ rate: 189 },
    "Rugby" => %{ rate: 303 },
    "Running, 8 minute mile" => %{ rate: 278, icon: "fa-running" },
    "Running, 10 minute mile" => %{ rate: 222, icon: "fa-running" },
    "Running, 12 minute mile" => %{ rate: 178, icon: "fa-running" },
    "Scuba diving" => %{ rate: 212 },
    "Shoveling snow" => %{ rate: 133 },
    "Skiing, cross-country" => %{ rate: 200, icon: "fa-skiing-nordic" },
    "Skiing, downhill" => %{ rate: 133, icon: "fa-skiing" },
    "Sledding" => %{ rate: 212 },
    "Snowshoeing" => %{ rate: 178 },
    "Soccer, Recreational" => %{ rate: 156, icon: "fa-futbol" },
    "Softball" => %{ rate: 152, icon: "fa-baseball-ball" },
    "Spinning class" => %{ rate: 240, icon: "fa-bicycle" },
    "Stair climbing, leisurely" => %{ rate: 90 },
    "Stair climbing, vigorous" => %{ rate: 267 },
    "Stretching" => %{ rate: 76 },
    "Swimming, leisurely" => %{ rate: 133, icon: "fa-swimmer" },
    "Swimming laps, moderate" => %{ rate: 212, icon: "fa-swimmer" },
    "Swimming laps, vigorous" => %{ rate: 303, icon: "fa-swimmer" },
    "Tai chi" => %{ rate: 121 },
    "Tennis, singles" => %{ rate: 178 },
    "Tennis, doubles" => %{ rate: 133 },
    "Vacuuming" => %{ rate: 87 },
    "Volleyball" => %{ rate: 89 },
    "Walking, 2 mph" => %{ rate: 76, icon: "fa-walking" },
    "Walking, 3 mph" => %{ rate: 100, icon: "fa-walking" },
    "Walking, 4 mph" => %{ rate: 152, icon: "fa-walking" },
    "Washing car" => %{ rate: 100 },
    "Water aerobics" => %{ rate: 89 },
    "Weight lifting" => %{ rate: 133, icon: "fa-dumbbell" },
    "Yard work" => %{ rate: 111, icon: "fa-leaf" },
    "Yoga" => %{ rate: 89 }
  }


  def convert(activity, steps) when activity == @custom, do: steps
  def convert(activity, duration_in_minutes) do
    case Map.get(@conversion_table, activity) do
      %{ rate: rate } -> rate * duration_in_minutes
    end
  end

  def activities() do
    [
      @custom |
      (Map.keys(@conversion_table)
      |> Enum.sort)
    ]
  end

  def icon(activity) do
    case Map.get(@conversion_table, activity) do
      %{ icon: icon } -> icon
      _ -> "fa-smile"
    end
  end

  def custom do
    @custom
  end

end
