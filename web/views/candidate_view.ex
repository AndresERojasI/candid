defmodule Candid.CandidateView do
  use Candid.Web, :view
  alias Timex.DateFormat
  alias Timex.Date

  def full_name(candidate) do
    "#{String.capitalize(candidate.first_name)} #{String.capitalize(candidate.last_name)}"
  end

  def gravatar(candidate) do
    mail = candidate.email |> String.strip |> String.downcase
    :crypto.hash(:md5, mail) |> Base.encode16 |> String.downcase
  end

  def link_icon_if_exists(label, url) do
    case url != "" do
      true -> raw("<a href='#{url}'><i class='fa #{label}'></i></a>")
      _ -> ""
    end
  end

  def experience_label(candidate, field, color) do
    title = field |> String.capitalize
    case candidate.experience[field] do
      true -> content_tag(:span, title, class: "label label-#{color} experience-#{field} right")
      _ -> ""
    end
  end

  def tech_stack(candidate) do
    tags = candidate.tech_stack
    case length(tags) > 3 do
      false -> tags |> Enum.join(", ")
      true ->
        string = tags |> Enum.take(4) |> Enum.join(", ")
        link = " <a>and more...</a>"
        "#{string} #{link}" |> raw
    end
  end

  def years_working(candidate) do
    start = candidate.work["started_working"]

    case DateFormat.parse(start, "{YYYY}") do
      {:ok, year} -> year |> Date.diff(Date.now, :years)
      _ -> 0
    end
  end

  def years_at_current_company(candidate) do
    start = candidate.work["started_current_company"]

    case DateFormat.parse(start, "{M}/{D}/{YY}") do
      {:ok, date} -> date |> Date.diff(Date.now, :years)
      _ -> 0
    end
  end
end
