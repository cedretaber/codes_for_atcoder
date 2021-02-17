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

alias X = Tuple!(dchar[], dchar[]);

void main()
{
    int N; get(N);
    dchar[] S; get(S);

    long[X] memo;
    foreach (b; 0..(1<<N)) {
        dchar[] aa, bb;
        foreach (i; 0..N) {
            if (b & (1<<i)) {
                aa ~= S[i];
            } else {
                bb ~= S[i];
            }
        }
        memo[X(aa, bb)] += 1;
    }

    long r;
    foreach (b; 0..(1<<N)) {
        dchar[] aa, bb;
        foreach_reverse (i; N..N*2) {
            if (b & (1<<(i-N))) {
                aa ~= S[i];
            } else {
                bb ~= S[i];
            }
        }
        auto x = X(bb, aa);
        if (x in memo) r += memo[x];
    }
    writeln(r);
}