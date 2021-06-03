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

void main()
{
    long N; int M; get(N, M);
    if (N > 450) {
        while (M--) {
            readln;
            writeln("no");
        }
        return;
    }

    auto G = new bool[][](N, N);
    foreach (ref g; G) g[] = true;
    auto G2 = new int[][N];
    foreach (i; 0..N) foreach (j; 0..N) if (i != j) G2[i] ~= j.to!int;

    bool is_forest() {
        auto memo = new bool[](N);
        foreach (i; 0..N) if (!memo[i]) {
            memo[i] = true;
            bool walk(long i, long j) {
                foreach (k; G2[i]) if (k != j) {
                    if (memo[k]) return true;
                    memo[k] = true;
                    if (walk(k, i)) return true;
                }
                return false;
            }
            if (walk(i, -1)) return false;
        }
        return true;
    }

    long cnt = N * (N - 1) / 2;
    while (M--) {
        int S, T; get(S, T); --S; --T;
        G[S][T] = G[T][S] = !G[S][T];
        if (G[S][T]) {
            ++cnt;
            G2[S] ~= T;
            G2[T] ~= S;
        } else {
            --cnt;
            int[] ss, tt;
            foreach (i; G2[S]) if (i != T) ss ~= i;
            foreach (i; G2[T]) if (i != S) tt ~= i;
            G2[S] = ss;
            G2[T] = tt;
        }
        writeln(cnt < N && is_forest() ? "yes" : "no");
    }
}

/*

N * (N - 1) / 2 - N - 1 = 100000
N^2 - N - 2N - 2 = 200000
N^2 - 3N - 200002 = 0

*/
