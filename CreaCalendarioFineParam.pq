(DataIniziale as date, DataFinale as date) =>
let
    #"elenco date" = List.Dates(DataIniziale,Number.From(Date.From(DataFinale)-DataIniziale)+1, #duration(1,0,0,0)),
    #"tabella calendario" = Table.FromList(#"elenco date", Splitter.SplitByNothing(),{"Data"}),
    #"anno" = Table.AddColumn(#"tabella calendario", "Anno", each Date.Year([Data])),
    #"mese" = Table.AddColumn(#"anno", "Mese", each Date.Month([Data])),
    #"nome mese" = Table.AddColumn(#"mese", "Nome mese", each Date.MonthName([Data])),
    #"trimestre" = Table.AddColumn(#"nome mese", "Trimestre", each Date.QuarterOfYear([Data])),
    #"settimana anno" = Table.AddColumn(#"trimestre", "Settimana anno", each Date.WeekOfYear([Data])),
    #"giorno settimana" = Table.AddColumn(#"settimana anno", "Giorno settimana", each Date.DayOfWeekName([Data])),
    #"tipi corretti" = Table.TransformColumnTypes(#"giorno settimana",{{"Data", type date}, {"Anno", Int64.Type}, {"Mese", Int64.Type}, {"Nome mese", type text}, {"Trimestre", Int64.Type}, {"Settimana anno", Int64.Type}, {"Giorno settimana", type text}})
in
    #"tipi corretti"