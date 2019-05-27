fun fromFile fileName =
    let
        val inStream = TextIO.openIn fileName
        val len =
            case TextIO.inputLine inStream of
                NONE => raise Fail "Bad input format"
              | SOME s =>
                case Int.fromString s of
                    NONE => raise Fail "Bad input format"
                  | SOME x => x
        fun aux i =
            if i = len then [] else
            case TextIO.inputLine inStream of
                NONE => raise Fail "Bad input format"
              | SOME s =>
                let
                    val line =
                        List.map
                            (fn tk =>
                                case Int.fromString tk of
                                    SOME 0 => false
                                  | SOME 1 => true
                                  | _ => raise Fail "Bad input format"
                            ) (String.tokens (fn c => c = #" ") s)
                    val _ = if (List.length line) = len then () else raise Fail "Bad input format"
                in
                    (Array.fromList line) :: (aux (i + 1))
                end
        val adjMat = Array.fromList (aux 0)
    in
        (len, adjMat)
    end

fun prToString pr =
    List.foldl (fn (e, r) =>
                    r ^ (Real.toString e) ^ ", "
                ) "" pr
