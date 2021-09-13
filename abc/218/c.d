import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

char[][] rotate(char[][] X) {
    auto Y = new char[][](X.front.length, X.length);
    foreach (i, line; X) foreach (j, x; line) Y[j][X.length - i - 1] = x;
    return Y;
}

char[][] trim(char[][] X)
{
    void go() {
        foreach (x; X) if (x.front == '#') return;
        foreach (ref line; X) line = line[1..$];
        return go();
    }
    go();
    X = rotate(X);
    go();
    X = rotate(X);
    go();
    X = rotate(X);
    go();
    return X;
}

void main()
{
    int N; get(N);
    char[][] S, T; get_lines(N, S); get_lines(N, T);
    S = trim(S);
    T = trim(T);
    if (S == T) return writeln("Yes");
    S = rotate(S);
    if (S == T) return writeln("Yes");
    S = rotate(S);
    if (S == T) return writeln("Yes");
    S = rotate(S);
    if (S == T) return writeln("Yes");
    writeln("No");
}
