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
    int N, M; get(N, M);
    auto G = new int[][N];
    auto RG = new int[][N];
    while (M--) {
        int A, B; get(A, B); --A; --B;
        G[A] ~= B;
        RG[B] ~= A;
    }
    auto ns = new int[](N);
    auto memo = new bool[](N);
    int t;
    void run(int i) {
        if (memo[i]) return;
        memo[i] = true;
        foreach (j; G[i]) run(j);
        ns[t++] = i;
    }
    foreach (i; 0..N) run(i);

    memo[] = false;
    long solve(int i) {
        if (memo[i]) return 0;
        memo[i] = true;
        long r;
        foreach (j; RG[i]) r += solve(j);
        return r + 1;
    }
    long res;
    foreach_reverse (i; ns) {
        auto r = solve(i);
        res += r * (r - 1) / 2;
    }
    writeln(res);
}
