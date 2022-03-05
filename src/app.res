open Deno

Log.info("serving project on http://0.0.0.0:2112")

Http.serve(_req => {
  Http.Response.of_string("Hello, world!") |> Promise.resolve
}, {port: 2112})
->ignore
