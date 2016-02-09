defmodule Candid.CandidateController do
  use Candid.Web, :controller
  import Ecto.Query
  alias Candid.Candidate

  def index(conn, _params) do
#    candidates = from(c in Candidate, limit: 20) |> Repo.all
    candidates = Repo.all(Candidate)
    render(conn, "index.html", candidates: candidates)
  end

  def show(conn, %{"id" => id}) do
    conn
    |> assign(:id, id)
    |> put_flash(:info, "info flash omg")
    |> put_flash(:error, "and dem errors!")
    |> render :show
  end

  def new(conn, _params) do
    changeset = Candidate.changeset(%Candidate{})
    render(conn, "new.html", changeset: changeset)
  end


  def edit(conn, %{"id" => id}) do
    user = Repo.get!(Candidate, id)
    changeset = Candidate.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = Candidate.changeset(%Candidate{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Candidate created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(Candidate, id)
    changeset = Candidate.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Candidate updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

end
