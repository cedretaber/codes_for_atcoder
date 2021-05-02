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

alias P = Tuple!(int, "a", int, "b");

void main()
{
    int N; get(N);
    P[] ps; get_lines(N, ps);
    sort!"a.b < b.b"(ps);

    auto DP = new int[][](N + 1, N + 1);
    foreach (ref dp; DP) dp[] = int.max / 3;
    DP[0][0] = 0;
    foreach (i; 0..N) with (ps[i]) foreach (j; 0..N) {
        DP[i + 1][j] = min(DP[i + 1][j], DP[i][j]);
        if (DP[i][j] + a <= b) DP[i + 1][j + 1] = min(DP[i + 1][j + 1], DP[i][j] + a); 
    }
    foreach_reverse (i, n; DP[N]) if (n < int.max / 3) return writeln(i);
}
