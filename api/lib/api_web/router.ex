defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Api.Account.Pipeline
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", ApiWeb do
    pipe_through :api
    resources "/food_truck", FoodTruckController, except: [:new, :edit]
    post "/user", UserController, :create
    post "/sessions", SessionController, :create
  end

  # scope "/api", ApiWeb do
  #   pipe_through [:api, :auth]
  #   resources "/ratings", RatingController, only: [:index, :create]
  #   resources "/food_truck", FoodTruckController, only: [:random]
  # end
  scope "/api", ApiWeb do
    pipe_through :api
    pipe_through :auth
    resources "/ratings", RatingController, only: [:index, :create]
    get "/ratings/random", RatingController, :random
    get "/food_trucks/random", FoodTruckController, :random
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
