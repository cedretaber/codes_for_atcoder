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
    int N; get(N);
    auto T = new int[][N];
    foreach (_; 1..N) {
        int a, b; get(a, b);
        T[a] ~= b;
        T[b] ~= a;
    }

    int x, max_d;
    void run(int i, int p, int d) {
        if (d > max_d) {
            x = i;
            max_d = d;
        }
        foreach (j; T[i]) if (j != p) run(j, i, d + 1);
    }
    run(0, -1, 0);
    auto y = x;
    x = 0; max_d = 0;
    run(y, -1, 0);

    int solve(int i, int p) {
        if (p != -1 && T[i].length == 1) return 0;
        if ((p == -1 && T[i].length == 1) || (p != -1 && T[i].length == 2)) {
            foreach (j; T[i]) if (j != p) return solve(j, i);
        }

        int s, lc;
        foreach (j; T[i]) if (j != p) {
            auto r = solve(j, i);
            if (r == 0) ++lc;
            s += r;
        }
        return s + max(0, lc - 1);
    }
    writeln(min(solve(x, -1), solve(y, -1)) + 1);
}   