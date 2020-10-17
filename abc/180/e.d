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

alias S = Tuple!(int, "i", uint, "s", long, "c");

void main()
{
    int N; get(N);
    int[] xs, ys, zs; get_lines(N, xs, ys, zs);
    auto G = new long[][](N, N);
    foreach (i; 0..N) foreach (j; 0..N) if (i != j) {
        G[i][j] = abs(xs[i] - xs[j]) + abs(ys[i] - ys[j]) + max(0, zs[j] - zs[i]);
    }

    auto DP = new long[][](N, 1<<N);
    foreach (ref dp; DP) dp[] = long.max/3;
    DP[0][0] = 0;
    auto Q = heapify!"a.c > b.c"([S(0, 0, 0)]);
    while (!Q.empty) {
        auto front = Q.front;
        Q.popFront();
        with (front) {
            foreach (j; 0..N) {
                auto ss = s | (1<<j);
                auto cc = c + G[i][j];
                if (DP[j][ss] > cc) {
                    DP[j][ss] = cc;
                    Q.insert(S(j, ss, cc));
                }
            }
        }
    }
    writeln(DP[0][(1<<N)-1]);
}