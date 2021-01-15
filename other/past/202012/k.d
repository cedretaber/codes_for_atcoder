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
    uint S;
    foreach (i; 0..4) foreach (j, c; readln.chomp) if (c == '#') S |= (1 << (i * 4 + j));
    auto DP = new double[](2^^16);
    DP[0] = 0;

    double solve(uint s) {
        if (!isNaN(DP[s])) return DP[s];

        auto r = double.infinity;
        foreach (i; 0..4) foreach (j; 0..4) {
            double x = 1, y = 1;
            static foreach (d; [[0, 0], [1, 0], [-1, 0], [0, 1], [0, -1]]) {{
                auto ii = i + d[0];
                auto jj = j + d[1];
                auto k = ii * 4 + jj;
                if (0 <= ii && ii < 4 && 0 <= jj && jj < 4 && (s & (1 << k))) {
                    x += solve(s & ~(1<<k)) * 0.2;
                } else {
                    y -= 0.2;
                }
            }}
            r = min(r, x / y);
        }
        return DP[s] = r;
    }

    writefln!"%.012f"(solve(S));
}