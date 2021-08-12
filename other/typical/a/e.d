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

enum MAX = 50 + 50 * 51 / 2;

void main()
{
    auto DP = new uint[][](51, MAX + 1);
    auto memo = new bool[](50 + MAX + 1);
    foreach (w; 0..51) foreach (b; 0..MAX + 1) {
        memo[] = false;
        if (w && b + w <= MAX) memo[DP[w - 1][b + w]] = true;
        if (b > 1) foreach (k; 1..b / 2 + 1) memo[DP[w][b - k]] = true;
        foreach (i, x; memo) if (!x) {
            DP[w][b] = i.to!uint;
            break;
        }
    }
    int N; get(N);
    int[] WS, BS; get(WS); get(BS);
    uint s;
    foreach (i; 0..N) s ^= DP[WS[i]][BS[i]];
    writeln(s == 0 ? "Second" : "First");
}
