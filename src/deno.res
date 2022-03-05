module Promise = Js.Promise

@scope("Deno") @val external args: array<string> = "args"

module Uint8Array = {
  type t

  @new external make: int => t = "Uint8Array"

  @send external slice: (t, int, int) => string = "slice"
}

module Readable_stream = {
  type t

  module Controller = {
    type t

    @send external close: t => Js.Promise.t<unit> = "close"
    @send external enqueue: (t, string) => Js.Promise.t<unit> = "enqueue"
  }

  type config = {
    start: unit => Js.Promise.t<unit>,
    pull: Controller.t => Js.Promise.t<unit>,
  }

  @new external make: config => t = "ReadableStream"
}

module Async = {
  type debounced_fn<'a, 'b> = 'a => 'b

  @module("https://deno.land/std@0.123.0/async/mod.ts") @val
  external debounce: ('a => 'b, int) => debounced_fn<'a, 'b> = "debounce"
}

module Text_encoder = {
  type t

  @new
  external new: unit => t = "TextEncoder"

  @send external encode: (t, string) => Uint8Array.t = "encode"
}

module File = {
  type seek_mode =
    | Start
    | Current
    | End

  type t

  type stat = {size: int}

  @scope("Deno") @val external open_file: string => Js.Promise.t<t> = "open"

  @scope("Deno") @val external write: (string, Uint8Array.t) => Js.Promise.t<unit> = "writeFile"

  @scope("Deno") @val external watch: string => Async_generator.t<unit> = "watchFs"

  @scope("Deno") @val external stat: string => Js.Promise.t<stat> = "stat"

  @send external close: t => unit = "close"

  @send external read: (t, Uint8Array.t) => Js.Promise.t<Js.Nullable.t<int>> = "read"

  @send external seek: (t, int, seek_mode) => Js.Promise.t<unit> = "seek"

  @get external size: stat => int = "size"
}

module Fs = {
  @module("https://deno.land/std@0.123.0/fs/mod.ts") @val
  external ensure_file: string => Js.Promise.t<unit> = "ensureFile"

  @module("https://deno.land/std@0.123.0/fs/mod.ts") @val
  external ensure_file_sync: string => unit = "ensureFileSync"
}

module Io = {
  @module("https://deno.land/std@0.123.0/io/mod.ts") @val
  external read_lines: File.t => Async_generator.t<string> = "readLines"
}

module Console = {
  @scope("console") @val external log: 'a => unit = "log"
  @scope("console") @val external log2: ('a, 'b) => unit = "log"
  @scope("console") @val external log3: ('a, 'b, 'c) => unit = "log"
  @scope("console") @val external log4: ('a, 'b, 'c, 'd) => unit = "log"
  @scope("console") @val external log5: ('a, 'b, 'c, 'd, 'e) => unit = "log"
}

module Path = {
  @module("https://deno.land/std@0.123.0/path/mod.ts") @val
  external join: (string, string) => string = "join"
}

module Log = {
  @module("https://deno.land/std@0.123.0/log/mod.ts") @val external debug: 'a => unit = "debug"
  @module("https://deno.land/std@0.123.0/log/mod.ts") @val external info: 'a => unit = "info"
  @module("https://deno.land/std@0.123.0/log/mod.ts") @val external warning: 'a => unit = "warning"
  @module("https://deno.land/std@0.123.0/log/mod.ts") @val external error: 'a => unit = "error"
  @module("https://deno.land/std@0.123.0/log/mod.ts") @val
  external critical: 'a => unit = "critical"
}

module Flags = {
  module Args = {
    type t = {
      @as("_")
      path: array<string>,
    }
  }
  @module("https://deno.land/std@0.123.0/flags/mod.ts")
  external parse: (~args: array<string>) => Args.t = "parse"
}

module URL = {
  type t

  @new external unsafe_of_string: string => t = "URL"

  @get external path: t => string = "pathname"
}

module Http = {
  module Headers = {
    type t

    @new external make: unit => t = "Headers"

    @send external set: (t, string, 'a) => unit = "set"
  }

  module Request = {
    type t

    @get external url: t => string = "url"

    @get external method: t => string = "method"
  }

  module Response = {
    type t

    @new external of_string: string => t = "Response"

    @new external of_readable_stream: (Readable_stream.t, 'a) => t = "Response"
  }

  type opts = {port: int}

  @module("https://deno.land/std@0.123.0/http/server.ts")
  external serve: (Request.t => Js.Promise.t<Response.t>, opts) => unit = "serve"
}
