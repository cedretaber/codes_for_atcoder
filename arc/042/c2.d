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

alias G = Tuple!(int, "a", int, "b");

void main()
{
    int N, P; get(N, P);
    G[] gs; get_lines(N, gs);
    sort!"a.a > b.a"(gs);

    auto DP = new int[][](N+1, P+101);
    foreach (i; 0..N) with (gs[i]) {
        foreach (j; 0..P+101) {
            DP[i+1][j] = max(DP[i+1][j], DP[i][j]);
            if (j+a < P+101) DP[i+1][j+a] = DP[i][j] + b;
        }
    }
    int r;
    foreach (i; 0..N) with (gs[i]) {
        r = max(r, DP[i+1][0..P+a+1].maxElement);
    }
    writeln(r);
}