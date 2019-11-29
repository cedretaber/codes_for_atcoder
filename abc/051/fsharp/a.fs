open System

[<EntryPoint>]
let main _ =
    printfn "%s" (Console.ReadLine().Split [|','|] |> String.concat " ")
    0