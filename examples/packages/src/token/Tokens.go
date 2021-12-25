package token

type Token int8

const (
    EOF Token = iota // end of file
    BAD       // unknown token

    IDENT     // identifier
    NUMBER    // number
    STRING    // string
)

func (token Token) String() string {
    return [...]string{
        "EOF", "BAD",

        "ident", "number", "string",
    }[token]
}
