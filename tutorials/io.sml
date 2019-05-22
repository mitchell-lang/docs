fun readDistanceAdjMarix fileName =
    let
        val ins = TextIO.openIn fileName
        val size =
            case TextIO.inputLine ins of
                NONE => raise Fail "Bad File Format"
              | SOME line =>
                case Int.fromString line of
                    NONE => raise Fail "Bad File Format"
                  | SOME x => x
        fun loop i =
            if i = size then [] else
            case TextIO.inputLine ins of
                NONE => raise Fail "Bad File Format"
              | SOME line =>
                let
                    val tokens =
                        String.tokens (fn c => case Char.compare (c, #" ") of
                                                   EQUAL => true
                                                 | _ => false) line
                    val disList =
                        List.map
                            (fn tk =>
                                case Int.fromString tk of
                                    NONE => raise Fail "Bad File Format"
                                  | SOME x => x
                            ) tokens
                in
                    (Array.fromList disList) :: (loop (i + 1))
                end
        val mat = Array.fromList (loop 0)
        val start =
            case TextIO.inputLine ins of
                NONE => raise Fail "Bad File Format"
              | SOME line =>
                case Int.fromString line of
                    NONE => raise Fail "Bad File Format"
                  | SOME x => x
    in
        (mat, start)
    end

fun pathToString path = List.foldl (fn (e, r) => (Int.toString e) ^ " " ^ r) "" path
