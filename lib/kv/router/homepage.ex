defmodule Router.User do
  use Maru.Router

  namespace :user do
    route_param :id do
#      get do
#        json(conn, %{ user: params[:id] })
#      end

      desc "description"
      params do
        requires :age,    type: Integer, values: 18..65
        requires :gender, type: Atom, values: [:male, :female], default: :female

        optional :intro,  type: String, regexp: ~r/^[a-z]+$/
        optional :avatar, type: File
        optional :avatar_url, type: String
        exactly_one_of [:avatar, :avatar_url]
      end
      post do
        json(conn, conn.params)
      end
    end
  end
end

defmodule Router.Homepage do

  use Maru.Router

  resources do
    get do
      json(conn, %{ hello: :kv })
    end

    mount Router.User
  end
end

defmodule KV.API do
  use Maru.Router

  before do
    plug Plug.Logger
    plug Plug.Static, at: "/static", from: "/my/static/path/"
  end

  plug Plug.Parsers,
       pass: ["*/*"],
       json_decoder: Poison,
       parsers: [:urlencoded, :json, :multipart]

  mount Router.Homepage

  rescue_from Unauthorized, as: e do
    IO.inspect e

    conn
    |> put_status(401)
    |> text("Unauthorized")
  end

  rescue_from [MatchError, RuntimeError], with: :custom_error

#  rescue_from :all, as: e do
#    conn
#    |> put_status(Plug.Exception.status(e))
#    |> text("Server Error")
#  end

  defp custom_error(conn, exception) do
    conn
    |> put_status(500)
    |> text(exception.message)
  end
end
