# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

File.stream!("seeds/candidates.csv")
|> CSV.decode
|> Enum.map &Candid.CandidateCSVParser.save_row/1
