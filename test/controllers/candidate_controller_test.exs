defmodule Candid.CandidateControllerTest do
  use Candid.ConnCase

  alias Candid.Candidate
  @valid_attrs %{first_name: "some content", last_name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, candidate_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing candidate"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, candidate_path(conn, :new)
    assert html_response(conn, 200) =~ "New candidate"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, candidate_path(conn, :create), candidate: @valid_attrs
    assert redirected_to(conn) == candidate_path(conn, :index)
    assert Repo.get_by(Candidate, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, candidate_path(conn, :create), candidate: @invalid_attrs
    assert html_response(conn, 200) =~ "New candidate"
  end

  test "shows chosen resource", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = get conn, candidate_path(conn, :show, candidate)
    assert html_response(conn, 200) =~ "Show candidate"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, candidate_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = get conn, candidate_path(conn, :edit, candidate)
    assert html_response(conn, 200) =~ "Edit candidate"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = put conn, candidate_path(conn, :update, candidate), candidate: @valid_attrs
    assert redirected_to(conn) == candidate_path(conn, :show, candidate)
    assert Repo.get_by(Candidate, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = put conn, candidate_path(conn, :update, candidate), candidate: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit candidate"
  end

  test "deletes chosen resource", %{conn: conn} do
    candidate = Repo.insert! %Candidate{}
    conn = delete conn, candidate_path(conn, :delete, candidate)
    assert redirected_to(conn) == candidate_path(conn, :index)
    refute Repo.get(Candidate, candidate.id)
  end
end
