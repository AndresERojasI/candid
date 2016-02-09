defmodule Candid.CandidateCSVParser do
  alias Candid.Candidate
  alias Candid.Repo

  def to_bool(val) do
    case val do
      "YES" -> true
      "NO" -> false
      _ -> false
    end
  end

  def save_row(row) do
    case row do
      [first_name, last_name, current_company, current_role,
       linkedin_url, started_working, years_at_current_company,
       owner, status, email, phone, github_url, twitter_url, technologies,
       mobile, web, hardware, startup_experience, management_experience,
        english, engineer, comments, city] ->

        profiles = %{linkedin: linkedin_url, github: github_url, twitter: twitter_url}

        work = %{
          current_role: current_role, current_company: current_company,
          started_current_company: years_at_current_company,
          started_working: started_working
        }

        tech_stack = technologies
        |> String.split(",")
        |> Enum.map(&String.strip/1)

        experience = %{
          mobile: to_bool(mobile),
          web: to_bool(web),
          hardware: to_bool(hardware),
          startups: to_bool(startup_experience),
          management: to_bool(management_experience),
          engineer: to_bool(engineer),
          english: to_bool(english),
        }

        candidate = %{first_name: first_name, last_name: last_name,
                      email: email, phone: phone, city: city,
                      comments: comments, profiles: profiles,
                      work: work, experience: experience,
                      tech_stack: tech_stack, owner: owner}

        changeset = Candidate.changeset(%Candidate{}, candidate)

        Candid.Repo.insert!(changeset)
      other -> IO.puts("Cannot import row: #{other}")
    end
  end
end
